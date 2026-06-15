# Crysis Remastered - Crouch Toggle Fix

This mod restores Crouch Toggle functionality to *Crysis Remastered* natively without breaking or overwriting any other keys or custom control layouts.

## Features

- **Toggle Crouch:** Switches Crouch from hold-to-toggle natively.
- **Clean Profile:** Leaves all other default keys completely untouched, allowing you to customize your other keybinds inside the in-game options menu without issues.

## Installation & Setup

1. Copy `zzzz_zRemasterCrouchToggleFix.pak` into your `...\Crysis Remastered\Game\` folder.
2. In the game's root directory (`...\Crysis Remastered\`), open (or create) a file named `autoexec.cfg` and add the following line:
   ```cfg
   cl_crouchToggle = 1
   ```
   *This console variable tells the engine to handle the C key input as a toggle event.*

---

## Nexus Mods & Updates
You can also find this mod on my [Nexus Mods Profile](https://www.nexusmods.com/profile/alexspf).
> [!NOTE]
> The GitHub repository is the main source of development. The most up-to-date and stable versions of the mods will always be released here first.
