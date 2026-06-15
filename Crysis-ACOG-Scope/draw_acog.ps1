param(
    [string]$destPath = ""
)

Add-Type -AssemblyName System.Drawing

if (-not $destPath) {
    $destPath = Join-Path $PSScriptRoot "acog_processed.png"
}

$width = 512
$height = 512
$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)

# Set high-quality drawing settings
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Clear with transparent background
$g.Clear([System.Drawing.Color]::Transparent)

# Define colors
$redColor = [System.Drawing.Color]::FromArgb(255, 220, 30, 30)
$blackColor = [System.Drawing.Color]::FromArgb(255, 0, 0, 0)

# Define pens
$chevPen = New-Object System.Drawing.Pen($redColor, 2.4)
$chevPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Miter
$chevPen.MiterLimit = 10

$redLinePen = New-Object System.Drawing.Pen($redColor, 1.2)
$blackLinePen = New-Object System.Drawing.Pen($blackColor, 1.2)

# 1. Draw Chevron
$chevPoints = @(
    (New-Object System.Drawing.PointF(242, 274)),
    (New-Object System.Drawing.PointF(256, 256)),
    (New-Object System.Drawing.PointF(270, 274))
)
$g.DrawLines($chevPen, $chevPoints)

# 2. Draw Vertical lines
$g.DrawLine($redLinePen, 256, 282, 256, 360)
$g.DrawLine($blackLinePen, 256, 360, 256, 480)

# 3. Draw Tick Marks
$g.DrawLine($redLinePen, 246, 282, 266, 282)
$g.DrawLine($redLinePen, 250, 308, 262, 308)
$g.DrawLine($redLinePen, 248, 334, 264, 334)
$g.DrawLine($blackLinePen, 250, 360, 262, 360)
$g.DrawLine($blackLinePen, 250, 386, 262, 386)

# 4. Draw Numbers '4' and '6'
$font = New-Object System.Drawing.Font("Arial", 10.0, [System.Drawing.FontStyle]::Bold)
$redBrush = New-Object System.Drawing.SolidBrush($redColor)

$g.DrawString("4", $font, $redBrush, 270, 273)
$g.DrawString("6", $font, $redBrush, 268, 325)

# Clean up drawing objects
$chevPen.Dispose()
$redLinePen.Dispose()
$blackLinePen.Dispose()
$font.Dispose()
$redBrush.Dispose()
$g.Dispose()

# Save bitmap
$bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "High-res clean ACOG reticle drawn and saved to $destPath"
