# Crysis Warhead - Crouch Toggle Fix

This mod restores Crouch Toggle functionality to *Crysis Warhead* natively without breaking or overwriting any other keys or custom control layouts.

## Features

- **Toggle Crouch:** Switches Crouch from hold-to-toggle natively.
- **Clean Profile:** Leaves all other default keys completely untouched, allowing you to customize your other keybinds inside the in-game options menu without issues.

## Installation & Setup

1. Copy `zzzzz_CrouchToggle.pak` into your `...\Crysis Warhead\Game\` folder.
2. In the game's root directory (`...\Crysis Warhead\`), open (or create) a file named `autoexec.cfg` or `System.cfg` and add the following line:
   ```cfg
   cl_crouchToggle = 1
   ```
   *(Note: This console variable tells the engine to handle the crouch key input as a toggle event).*

---

## Nexus Mods & Updates
You can find this mod and updates on my [Nexus Mods Profile](https://www.nexusmods.com/profile/alexspf).
> [!NOTE]
> The GitHub repository is the main source of development. The most up-to-date and stable versions of the mods will always be released here first.
