# ACOG Mod Rebuild and Deploy script
$scriptRoot = $PSScriptRoot
$drawScript = Join-Path $scriptRoot "draw_acog.ps1"
$tempPng = Join-Path $scriptRoot "acog_processed.png"
$tempDds = Join-Path $scriptRoot "acog_processed.dds"

# Resolve target folder inside this mod
$destDir = Join-Path $scriptRoot "objects\weapons\Attachments\scope_assault\textures"
$destDds = Join-Path $destDir "crosshair.dds.0"

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

# 1. Draw PNG
Write-Host "Drawing ACOG PNG texture..." -ForegroundColor Cyan
powershell -File $drawScript -destPath $tempPng

# 2. Convert PNG to DDS
Write-Host "Converting PNG to DDS..." -ForegroundColor Cyan
& $texconv -f BC3_UNORM -m 1 -y -o $scriptRoot $tempPng

# 3. Copy to target crosshair.dds.0
Write-Host "Copying DDS to textures folder..." -ForegroundColor Cyan
if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
Copy-Item -Path $tempDds -Destination $destDds -Force

# Clean up temporary files
Remove-Item -Path $tempPng -Force -ErrorAction SilentlyContinue
Remove-Item -Path $tempDds -Force -ErrorAction SilentlyContinue

# 4. Pack mod to pak
Write-Host "Packing mod to pak..." -ForegroundColor Cyan
$packScript = Join-Path $scriptRoot "..\Mod-Tools\Pack-Mods.ps1"
if (-not (Test-Path $packScript)) {
    $packScript = Join-Path $scriptRoot "Mod-Tools\Pack-Mods.ps1"
}
powershell -File $packScript -SourceFolder "Crysis-ACOG-Scope" -OutputPakName "zzzzz_ACOGScope.pak" -OutputDir "../Game"

# 5. Copy pak to game installation
Write-Host "Deploying pak to game folder..." -ForegroundColor Cyan
$repoPak = Join-Path $scriptRoot "..\Game\zzzzz_ACOGScope.pak"
$gamePakDir = "C:\Program Files (x86)\Steam\steamapps\common\Crysis Remastered\Game"
if (Test-Path $gamePakDir) {
    Copy-Item -Path $repoPak -Destination $gamePakDir -Force
    Write-Host "Deployed to game installation: $gamePakDir" -ForegroundColor Green
} else {
    Write-Host "Game directory not found, skipping deployment." -ForegroundColor Yellow
}

Write-Host "ACOG Mod rebuild completed successfully!" -ForegroundColor Green
