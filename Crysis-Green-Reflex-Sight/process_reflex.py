from PIL import Image
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
vpk_path = os.path.join(script_dir, "green triangle reticle for red dot (ver. 2).vpk")
temp_vtf = os.path.join(script_dir, "aimpoint_dot.vtf")
temp_png = os.path.join(script_dir, "aimpoint_dot.png")
final_png = os.path.join(script_dir, "reflex_processed.png")

# 1. Extract VTF from VPK
import vpk
pak = vpk.open(vpk_path)
entry = pak['materials/models/weapons/optics/aimpoint_dot.vtf']
with open(temp_vtf, 'wb') as f:
    f.write(entry.read())

# 2. Convert VTF to PNG
from vtf2img import Parser
parser = Parser(temp_vtf)
img = parser.get_image()
img.save(temp_png)

# 3. Load image
img = Image.open(temp_png).convert("RGBA")
px = img.load()

# 4. Clean and Solidify reticle (forces R6S green: 0, 255, 0 with 255 alpha)
# This removes all semi-transparent noise that causes the blurry/faded spray effect in-game
for y in range(img.height):
    for x in range(img.width):
        r, g, b, a = px[x, y]
        # If the pixel is part of the triangle (non-trivial green and alpha)
        if a > 35 and g > 50:
            px[x, y] = (0, 255, 0, 255) # Make it solid neon green
        else:
            px[x, y] = (0, 0, 0, 0)


# 5. Find bounding box of cleaned pixels
min_x, max_x = img.width, -1
min_y, max_y = img.height, -1

for y in range(img.height):
    for x in range(img.width):
        r, g, b, a = px[x, y]
        if a > 0:
            if x < min_x: min_x = x
            if x > max_x: max_x = x
            if y < min_y: min_y = y
            if y > max_y: max_y = y

if max_x < min_x or max_y < min_y:
    print("Error: No green pixels survived cleaning!")
    exit(1)

# 6. Crop to bounding box
cropped = img.crop((min_x, min_y, max_x + 1, max_y + 1))
crop_width = max_x - min_x + 1
crop_height = max_y - min_y + 1

# Find local peak X (topmost solid green pixel)
peak_x_local = -1
for y in range(crop_height):
    for x in range(crop_width):
        r, g, b, a = cropped.getpixel((x, y))
        if a > 0:
            peak_x_local = x
            break
    if peak_x_local != -1:
        break

# 7. Create transparent canvas (256x256)
canvas = Image.new("RGBA", (256, 256), (0, 0, 0, 0))

# 8. Scale cropped triangle
scale = 0.45
new_w = int(crop_width * scale)
new_h = int(crop_height * scale)
resized = cropped.resize((new_w, new_h), Image.Resampling.LANCZOS)

# Peak position in resized image
peak_x_resized = int(peak_x_local * scale)
peak_y_resized = 0

# Paste aligning peak at (128, 128) - the center of the 256x256 image
offset_x = 128 - peak_x_resized
offset_y = 128 - peak_y_resized

canvas.paste(resized, (offset_x, offset_y), resized)

# 9. Save final image
canvas.save(final_png)

# Clean up temp files
if os.path.exists(temp_vtf): os.remove(temp_vtf)
if os.path.exists(temp_png): os.remove(temp_png)

print(f"Processed solid reflex sight texture saved to {final_png}")
