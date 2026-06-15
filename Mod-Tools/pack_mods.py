import zipfile
import os
import sys

def pack_folder(src_dir, output_pak):
    src_dir = os.path.abspath(src_dir)
    output_pak = os.path.abspath(output_pak)
    
    if not os.path.exists(src_dir):
        print(f"Source directory '{src_dir}' does not exist.")
        return False
        
    # Ensure output directory exists
    out_dir = os.path.dirname(output_pak)
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
        
    if os.path.exists(output_pak):
        try:
            os.remove(output_pak)
        except Exception as e:
            print(f"Error removing old pak {output_pak}: {e}")
            return False
            
    print(f"Packing '{src_dir}' into '{output_pak}'...")
    
    try:
        with zipfile.ZipFile(output_pak, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, dirs, files in os.walk(src_dir):
                # Skip .git folders
                if '.git' in root:
                    continue
                for file in files:
                    if file == 'README.md' or file.endswith('.bak'):
                        continue
                    file_path = os.path.join(root, file)
                    # Calculate relative path inside the zip
                    rel_path = os.path.relpath(file_path, src_dir)
                    # Convert to forward slashes for CryEngine
                    entry_name = rel_path.replace(os.path.sep, '/')
                    
                    # Ensure Scripts directory is lowercase 'scripts'
                    if entry_name.startswith('Scripts/'):
                        entry_name = 'scripts/' + entry_name[8:]
                        
                    zipf.write(file_path, entry_name)
        print(f"Successfully compiled {os.path.basename(output_pak)}!")
        return True
    except Exception as e:
        print(f"Failed to pack {output_pak}: {e}")
        return False

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python pack_mods.py <src_dir> <output_pak>")
        sys.exit(1)
    
    src = sys.argv[1]
    out = sys.argv[2]
    success = pack_folder(src, out)
    sys.exit(0 if success else 1)
