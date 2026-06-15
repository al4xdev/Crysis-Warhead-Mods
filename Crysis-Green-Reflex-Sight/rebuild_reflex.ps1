# Reflex Sight Mod Rebuild and Deploy script
$scriptRoot = $PSScriptRoot
$processScript = Join-Path $scriptRoot "process_reflex.py"
$tempPng = Join-Path $scriptRoot "reflex_processed.png"
$tempDds = Join-Path $scriptRoot "reflex_processed.dds"

# Resolve target folder inside this mod
$destDir = Join-Path $scriptRoot "objects\weapons\Attachments\reflex_rifle\textures"

# Find texconv
$texconv = "C:\Users\alexs\AppData\Local\Microsoft\WinGet\Links\texconv.exe"
if (-not (Test-Path $texconv)) {
    $texconvCmd = Get-Command texconv -ErrorAction SilentlyContinue
    if ($texconvCmd) { $texconv = $texconvCmd.Source }
}

if (-not (Test-Path $texconv)) {
    Write-Error "texconv.exe not found! Please install it via winget: winget install Microsoft.DirectXTex.Texconv"
    exit 1
}

# 1. Run process script to extract and scale PNG
Write-Host "Processing VPK reticle texture with Python..." -ForegroundColor Cyan
uv run --with Pillow --with vpk --with vtf2img python $processScript

# 2. Convert PNG to DDS
Write-Host "Converting PNG to DDS..." -ForegroundColor Cyan
& $texconv -f BC3_UNORM -y -o $scriptRoot $tempPng

# 3. Copy to all base target names in textures folder
Write-Host "Copying DDS to textures folder..." -ForegroundColor Cyan
$targets = @(
    "green_triangle.dds",
    "reflex_crossh.dds"
)

if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

# Clear old split files
Get-ChildItem -Path $destDir -Filter "*.dds.*" | Remove-Item -Force

foreach ($target in $targets) {
    $destFile = Join-Path $destDir $target
    Copy-Item -Path $tempDds -Destination $destFile -Force
}

# Clean up temporary files
Remove-Item -Path $tempPng -Force -ErrorAction SilentlyContinue
Remove-Item -Path $tempDds -Force -ErrorAction SilentlyContinue

# 4. Pack mod to pak
Write-Host "Packing mod to pak..." -ForegroundColor Cyan
$packScript = Join-Path $scriptRoot "..\Mod-Tools\Pack-Mods.ps1"
if (-not (Test-Path $packScript)) {
    $packScript = Join-Path $scriptRoot "Mod-Tools\Pack-Mods.ps1"
}
powershell -File $packScript -SourceFolder "Crysis-Green-Reflex-Sight" -OutputPakName "zzzzz_GreenReflexSight.pak" -OutputDir "../Game"

# 5. Copy pak to game installation
Write-Host "Deploying pak to game folder..." -ForegroundColor Cyan
$repoPak = Join-Path $scriptRoot "..\Game\zzzzz_GreenReflexSight.pak"
$gamePakDir = "C:\Program Files (x86)\Steam\steamapps\common\Crysis Remastered\Game"
if (Test-Path $gamePakDir) {
    Copy-Item -Path $repoPak -Destination $gamePakDir -Force
    Write-Host "Deployed to game installation: $gamePakDir" -ForegroundColor Green
} else {
    Write-Host "Game directory not found, skipping deployment." -ForegroundColor Yellow
}

Write-Host "Reflex Mod rebuild completed successfully!" -ForegroundColor Green
