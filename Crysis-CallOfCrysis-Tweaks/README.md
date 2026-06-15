# Crysis Remastered - Call of Crysis (Gameplay Tweaks)

This mod adjusts player movement physics to make the gameplay feel faster, more responsive, and agile (bringing a Call of Duty-style super-soldier feel to Crysis).

## Features

- **Base Run Speed:** Increased normal running speed from `5.0` to `6.5` m/s.
- **Base Sprint Speed:** Increased the normal sprint multiplier from `1.5` to `2.0` (making your non-energy sprint significantly faster).
- **100% Clean:** Derived entirely from the original game assets. It contains no third-party code and has no dependencies on other mods.

## Installation

1. Copy `zzzz_CallOfCrysis.pak` into your `...\Crysis Remastered\Game\` folder.

## Optional Nanosuit Speed Mode Upgrades (highly recommended)

To also increase Nanosuit Speed mode sprinting speed and jump height, open or create the file `autoexec.cfg` in the game's root directory (`...\Crysis Remastered\`) and add the following lines:

```cfg
-- Nanosuit Speed Mode Sprint Multipliers (Default is 2, set to 3 for faster Speed sprinting)
g_suitSprintMultiplier_speedMode_gotFullEnergy = 3.0
g_suitSprintMultiplier_speedMode_gotLowEnergy = 3.0
g_suitSprintMultiplier_speedMode_outOfEnergy = 3.0

-- Nanosuit Speed Mode Horizontal Jump Force
g_suitSpeedJumpExtraForceInViewDirection_Horizontal = 2.2
```

---

## Nexus Mods & Updates
You can also find this mod on my [Nexus Mods Profile](https://www.nexusmods.com/profile/alexspf).
> [!NOTE]
> The GitHub repository is the main source of development. The most up-to-date and stable versions of the mods will always be released here first.
