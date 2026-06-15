# Crysis Warhead Mods Collection

A collection of lightweight gameplay and visual modifications for *Crysis Warhead* (2008), designed to work cleanly with other major community mods.

## Nexus Mods & Updates
You can find these mods and updates on my [Nexus Mods Profile](https://www.nexusmods.com/profile/alexspf).
> [!NOTE]
> The GitHub repository is the main source of development. The most up-to-date and stable versions of the mods will always be released here first.

---

## Mod List

1. **[Crysis Crouch Toggle](./Crysis-Crouch-Toggle)**
   * Converts the Crouch action from hold-to-crouch to a clean toggle functionality.
   * Preserves all other defaults and custom hotkeys.

2. **[Crysis Green Reflex Sight](./Crysis-Green-Reflex-Sight)**
   * Replaces the default red reflex sight triangle reticle with a vibrant, high-resolution (512x512) neon-green reticle for improved target acquisition.

3. **[Call of Crysis - Gameplay Tweaks](./Crysis-CallOfCrysis-Tweaks)**
   * Boosts movement dynamics by increasing the default walk/run speed and adjusting cloak energy drain.
   * Adjusts SMG and AY69 recoil/spread/shake parameters to zero for perfect precision.
   * Acelerates first-person firing animations of the AY69 to `speed="6.0"` to provide a smooth, fast tremor without visual screen bounce.

4. **[Crysis Walk & Crouch Toggle](./Crysis-Walk-Toggle)**
   * Converts Crouch into a toggle (C), maps Prone to LCTRL, and adds Walk slowly functionality (LALT).

5. **[Crysis ACOG Scope (R6S Style)](./Crysis-ACOG-Scope)**
   * Replaces the default Assault Scope reticle with a clean, high-resolution (512x512) Rainbow Six Siege style red ACOG reticle (hollow chevron with vertical distance markings).

---

## How to Install (For Players)

To install any of these mods:
1. Go to the **Releases** section of this repository.
2. Download the `.pak` file of the mod you want to install:
   * `zzzzz_CrouchToggle.pak` (Crouch Toggle Standalone)
   * `zzzzz_WalkAndCrouch_Toggle.pak` (Walk & Crouch Toggle)
   * `zzzzz_CallOfCrysisTweaks.pak` (Call of Crysis Gameplay Tweaks)
   * `zzzzz_GreenReflexSight.pak` (High-Res Green Reflex Sight)
   * `zzzzz_ACOGScope.pak` (High-Res ACOG R6S Style Scope)
3. Copy the `.pak` files and paste them into your game's installation folder:
   `...\Crysis Warhead\Game\`
4. If you are using either Crouch Toggle or Walk & Crouch Toggle standalone (without the Gameplay Tweaks mod), you will need to enable crouch toggle in-game by opening the console (tilde `~` key), typing `con_restricted 0` followed by `cl_crouchToggle = 1`. To make it permanent, add those lines to your `autoexec.cfg` or `System.cfg` file in the game's root directory (`...\Crysis Warhead\`).
   *(Note: If you use the Gameplay Tweaks mod `zzzzz_CallOfCrysisTweaks.pak`, the toggle will be activated automatically when loading into any map).*

*Note: The `zzzzz_` prefix in the filenames ensures that these mods load after all other assets, overriding their default files correctly.*
