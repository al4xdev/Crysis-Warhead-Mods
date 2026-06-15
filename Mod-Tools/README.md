# Crysis Warhead Modding Tools

This folder contains helper PowerShell scripts designed to pack and unpack Crysis Warhead `.pak` files (which are standard ZIP archives underneath).

## Scripts

### 1. `Pack-Mods.ps1`
Compresses a mod source directory into a `.pak` archive.

**Parameters:**
| Parameter | Required | Default | Description |
|---|---|---|---|
| `-SourceFolder`| ✅ | — | Name of the mod folder to pack |
| `-OutputPakName` | ✅ | — | Output filename (e.g. `mymod.pak`) |
| `-OutputDir` | ❌ | Script directory | Where to save the `.pak` file |

**Usage:**
```powershell
.\Pack-Mods.ps1 -SourceFolder "<mod_folder_name>" -OutputPakName "<filename.pak>" [-OutputDir "<path>"]
```

**Examples:**
```powershell
# Pack into the default output (next to the script)
.\Pack-Mods.ps1 -SourceFolder "Crysis-Crouch-Toggle" -OutputPakName "zzzzz_CrouchToggle.pak"

# Pack into a specific absolute path
.\Pack-Mods.ps1 -SourceFolder "Crysis-Crouch-Toggle" -OutputPakName "zzzzz_CrouchToggle.pak" -OutputDir "C:\MyMods\Output"

# Pack into a relative path (resolved from the script directory)
.\Pack-Mods.ps1 -SourceFolder "Crysis-Crouch-Toggle" -OutputPakName "zzzzz_CrouchToggle.pak" -OutputDir "..\Game"
```

**Source folder lookup order:**
1. Sibling of `Mod-Tools\` (i.e. `Crysis-Warhead-Mods-Github\<folder>`)
2. Inside `Mod-Tools\` itself

---

### 2. `Unpack-Pak.ps1`
Extracts files from any game or mod `.pak` archive into a folder for viewing or editing.

**Parameters:**
| Parameter | Required | Default | Description |
|---|---|---|---|
| `-PakFile` | ✅ | — | Path to the `.pak` file to extract |
| `-OutputDir` | ❌ | `<pak_name>` folder next to script | Where to extract the files |

**Usage:**
```powershell
.\Unpack-Pak.ps1 -PakFile "<path_to_pak>" [-OutputDir "<destination_folder>"]
```

**Examples:**
```powershell
# Unpack into auto-named folder next to the script
.\Unpack-Pak.ps1 -PakFile "..\Game\GameData.pak"

# Unpack into a specific folder
.\Unpack-Pak.ps1 -PakFile "..\Game\GameData.pak" -OutputDir "..\Game\gamedata_extracted"

# Unpack using an absolute path
.\Unpack-Pak.ps1 -PakFile "C:\MyMods\Game\GameData.pak" -OutputDir "C:\MyMods\Extracted\gamedata"
```

---

## Notes

- Both scripts resolve **relative paths from the script directory**, not from wherever the terminal is open. This means results are consistent regardless of where you call them from.
- Both scripts exit with **code `1` on failure** and print a clear error message — they will never print a success message if something went wrong.
- Files named `README.md` and `.git` internals are automatically skipped during packing.
- `.pak` files are standard ZIP archives and can also be inspected with any ZIP tool (7-Zip, WinRAR, etc.).