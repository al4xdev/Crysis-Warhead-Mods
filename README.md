# Crysis Remastered Mods Collection

A collection of lightweight gameplay and visual modifications for *Crysis Remastered*, designed to work cleanly with other major community mods.

## Nexus Mods & Updates
You can also find these mods on my [Nexus Mods Profile](https://www.nexusmods.com/profile/alexspf).
> [!NOTE]
> The GitHub repository is the main source of development. The most up-to-date and stable versions of the mods will always be released here first.

---

## Mod List

1. **[Crysis Crouch Toggle](./Crysis-Crouch-Toggle)**
   * Converts the Crouch action from hold-to-crouch to a clean toggle functionality.
   * Completely clean: preserves all other defaults and custom hotkeys.

2. **[Crysis Green Reflex Sight](./Crysis-Green-Reflex-Sight)**
   * Replaces the default red reflex sight triangle reticle with a vibrant, high-resolution (512x512) neon-green reticle for improved target acquisition.

3. **[Call of Crysis - Gameplay Tweaks](./Crysis-CallOfCrysis-Tweaks)**
   * Boosts movement dynamics by increasing the default walk/run speed (normal and Nanosuit) and adjusting cloak energy drain for a faster, modern shooter experience.

4. **[Crysis Walk & Crouch Toggle](./Crysis-Walk-Toggle)**
   * Converts Crouch into a toggle (C), adds Walk toggle functionality (LALT), and customizes binds for modern combat (Cloak on T, Armor on Mouse3, Lean on Q/E).

5. **[Crysis ACOG Scope (R6S Style)](./Crysis-ACOG-Scope)**
   * Replaces the default Assault Scope reticle with a clean, high-resolution (512x512) Rainbow Six Siege style red ACOG reticle (hollow chevron with vertical distance markings).

---

## How to Install (For Players)

To install any of these mods:
1. Go to the **Releases** section of this repository.
2. Download the `.pak` file of the mod you want to install:
   * `zzzzz_CrouchToggle.pak` (Crouch Toggle Standalone)
   * `zzzzz_WalkAndCrouch_Toggle.pak` (Walk & Crouch Toggle + Custom Binds)
   * `zzzzz_CallOfCrysisTweaks.pak` (Call of Crysis Gameplay Tweaks)
   * `zzzzz_GreenReflexSight.pak` (High-Res Green Reflex Sight)
   * `zzzzz_ACOGScope.pak` (High-Res ACOG R6S Style Scope)
3. Copy the `.pak` files and paste them into your game's installation folder:
   `...\Crysis Remastered\Game\`
4. If you are using either Crouch Toggle or Walk & Crouch Toggle, open or create the file `autoexec.cfg` in the game's root directory (`...\Crysis Remastered\`) and add:
   ```cfg
   cl_crouchToggle = 1
   ```

*Note: The `zzzzz_` prefix in the filenames ensures that these mods load after all other assets (including other community mods), overriding their default files correctly.*
