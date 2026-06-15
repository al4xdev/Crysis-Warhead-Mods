# Unpack-Pak.ps1
# This script extracts standard Crysis .pak archives into folders for editing.
# Run this script from PowerShell inside the Mod-Tools directory or the root directory.

param (
    [string]$PakFile,       # Path to the .pak file to extract
    [string]$OutputDir = "" # Output folder path where files will be extracted (default: next to script)
)

# Load compression assembly
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

if (-not $PakFile) {
    Write-Host "Usage: .\Unpack-Pak.ps1 -PakFile <path_to_pak> [-OutputDir <output_folder>]" -ForegroundColor Yellow
    Write-Host "Example: .\Unpack-Pak.ps1 -PakFile '..\Game\zzz_ImprovementProject.pak' -OutputDir '..\Game\zzz_ImprovementProject_unpacked'" -ForegroundColor Yellow
    exit 1
}

# Resolve PakFile: absolute = use as-is | relative = resolve from script dir
if (-not [System.IO.Path]::IsPathRooted($PakFile)) {
    $PakFile = Join-Path $PSScriptRoot $PakFile
}

if (-not (Test-Path $PakFile)) {
    Write-Host "ERROR: Pak file not found: $PakFile" -ForegroundColor Red
    exit 1
}

$resolvedPak = (Get-Item $PakFile).FullName

# If no OutputDir given, use pak name (without extension) next to the script
if (-not $OutputDir) {
    $pakBaseName = [System.IO.Path]::GetFileNameWithoutExtension($resolvedPak)
    $resolvedOutputDir = Join-Path $PSScriptRoot $pakBaseName
} elseif ([System.IO.Path]::IsPathRooted($OutputDir)) {
    $resolvedOutputDir = $OutputDir
} else {
    $resolvedOutputDir = Join-Path $PSScriptRoot $OutputDir
}

# Create output dir if it doesn't exist
if (-not (Test-Path $resolvedOutputDir)) {
    New-Item -ItemType Directory -Path $resolvedOutputDir -Force | Out-Null
}

Write-Host "Unpacking '$resolvedPak' into '$resolvedOutputDir'..." -ForegroundColor Cyan

# Extract files
try {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($resolvedPak)

    if ($zip.Entries.Count -eq 0) {
        Write-Host "ERROR: Pak file is empty, nothing to extract." -ForegroundColor Red
        $zip.Dispose()
        exit 1
    }

    $extracted = 0
    foreach ($entry in $zip.Entries) {
        # Skip directory entries
        if ($entry.Name -eq "") { continue }

        $targetPath = Join-Path $resolvedOutputDir $entry.FullName
        $targetDir  = Split-Path $targetPath -Parent

        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $targetPath, $true)
        $extracted++
    }

    $zip.Dispose()

    if ($extracted -eq 0) {
        Write-Host "ERROR: No files were extracted." -ForegroundColor Red
        exit 1
    }

    Write-Host "Successfully unpacked $extracted files!" -ForegroundColor Green
    Write-Host "  Saved to: $resolvedOutputDir" -ForegroundColor Green

} catch {
    Write-Host "ERROR: Failed to unpack pak file." -ForegroundColor Red
    Write-Host "  Reason: $($_.Exception.Message)" -ForegroundColor Red
    if ($zip) { $zip.Dispose() }
    exit 1
}