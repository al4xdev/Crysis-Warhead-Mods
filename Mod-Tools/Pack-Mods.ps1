# Pack-Mods.ps1
# This script compresses Crysis mod source folders into game-compatible .pak archives.
# Run this script from PowerShell inside the Mod-Tools directory or the root directory.

param (
    [string]$SourceFolder,   # e.g., "Crysis-Crouch-Toggle"
    [string]$OutputPakName,  # e.g., "zzzz_zRemasterCrouchToggleFix.pak"
    [string]$OutputDir = ""  # Default: same folder as the script
)

# Load compression assembly
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

if (-not $SourceFolder -or -not $OutputPakName) {
    Write-Host "Usage: .\Pack-Mods.ps1 -SourceFolder <folder_name> -OutputPakName <pak_name.pak> [-OutputDir <dir>]" -ForegroundColor Yellow
    exit 1
}

# Try to find source folder: first check sibling of Mod-Tools (..), then current dir
$srcPath = Join-Path ".." $SourceFolder
if (-not (Test-Path $srcPath)) {
    $srcPath = Join-Path "." $SourceFolder
}

if (-not (Test-Path $srcPath)) {
    Write-Host "ERROR: Source folder '$SourceFolder' not found." -ForegroundColor Red
    Write-Host "  Looked in: $(Resolve-Path '.')" -ForegroundColor Red
    Write-Host "  And in:    $(Resolve-Path '..')" -ForegroundColor Red
    exit 1
}

$srcDir = Get-Item (Resolve-Path $srcPath)

# Resolve OutputDir: absolute = use as-is | relative = resolve from script dir | empty = script dir
if (-not $OutputDir) {
    $resolvedOutputDir = $PSScriptRoot
} elseif ([System.IO.Path]::IsPathRooted($OutputDir)) {
    $resolvedOutputDir = $OutputDir
} else {
    $resolvedOutputDir = Join-Path $PSScriptRoot $OutputDir
}

if (-not (Test-Path $resolvedOutputDir)) {
    New-Item -ItemType Directory -Force -Path $resolvedOutputDir | Out-Null
}

$zipPath = Join-Path $resolvedOutputDir $OutputPakName

Write-Host "Packing '$srcDir' into '$zipPath'..." -ForegroundColor Cyan

# Remove old pak if it exists
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

# Create zip archive
try {
    $zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Create)
    $files = Get-ChildItem -Path $srcDir -Recurse -File

    if ($files.Count -eq 0) {
        Write-Host "ERROR: Source folder '$SourceFolder' is empty. Nothing to pack." -ForegroundColor Red
        $zip.Dispose()
        Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
        exit 1
    }

    $packed = 0
    foreach ($file in $files) {
        # Skip README.md, .git files, scripts, and VPK archives if they exist in source
        if ($file.Name -eq "README.md" -or $file.FullName -like "*\.git\*" -or $file.Extension -eq ".ps1" -or $file.Extension -eq ".vpk") {
            continue
        }

        # Calculate relative entry path
        $relPath = $file.FullName.Substring($srcDir.FullName.Length + 1)
        $entryName = $relPath.Replace("\", "/") # CryEngine requires forward slashes

        # Ensure Scripts directory is lowercase 'scripts'
        if ($entryName -like "Scripts/*") {
            $entryName = "scripts/" + $entryName.Substring(8)
        }

        $entry = $zip.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        $entryStream = $entry.Open()
        $fileStream = [System.IO.File]::OpenRead($file.FullName)
        $fileStream.CopyTo($entryStream)
        $fileStream.Close()
        $entryStream.Close()
        $packed++
    }

    $zip.Dispose()

    if ($packed -eq 0) {
        Write-Host "ERROR: No valid files were packed (only skipped files found)." -ForegroundColor Red
        Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
        exit 1
    }

    Write-Host "Successfully compiled $OutputPakName! ($packed files packed)" -ForegroundColor Green
    Write-Host "  Saved to: $zipPath" -ForegroundColor Green

} catch {
    Write-Host "ERROR: Failed to create pak archive." -ForegroundColor Red
    Write-Host "  Reason: $($_.Exception.Message)" -ForegroundColor Red
    if ($zip) { $zip.Dispose() }
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    exit 1
}