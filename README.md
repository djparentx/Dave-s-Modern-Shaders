# Dave's Modern Shaders (R36S)

by djparent

A RetroArch shader management tool for the R36S, designed for ArkOS and dArkOS, providing a clean, controller-friendly way to apply modern shader presets with improved scaling, smoothing, and color output.

---

## Overview

This script focuses on enhancing visual clarity on the R36S by using lightweight, modern shader pipelines optimized for performance on RK3326 hardware.

It removes the complexity of manual shader setup and allows quick application or removal of presets per system.

---

## Features

- Apply or remove shaders per system or globally
- Modern shader pipeline focused on clean scaling and clarity
- Scale2x upscaling with sharp bilinear filtering
- Optional NTSC color processing for console systems
- Custom Game Boy Advance color correction shader
- Lightweight shaders optimized for R36S performance
- Multi-language support (EN, FR, ES, PT, IT, DE, PL)
- Automatic shader installation on first run
- Fully controller-driven interface (X / Y toggles)

---

## Supported Systems

### Handhelds

- Nintendo Game Boy  
  Modern scaling + smoothing  

- Nintendo Game Boy Color  
  Modern scaling + smoothing  

- Nintendo Game Boy Advance  
  Color correction + scaling + smoothing  

- SEGA Game Gear  
  Modern scaling + smoothing  

- NeoGeo Pocket  
  Modern scaling + smoothing  

- NeoGeo Pocket Color  
  Modern scaling + smoothing  

- WonderSwan Color  
  Modern scaling + smoothing  

- Atari Lynx  
  Modern scaling + smoothing  

---

### Consoles

- Arcade / MAME  
- Atari 2600 / 5200 / 7800  
- CAPCOM CPS I / II / III  
- Nintendo Entertainment System  
- Super Nintendo  
- SEGA SG-1000  
- SEGA Master System  
- SEGA Mega Drive  
- SEGA CD  
- SEGA 32X  
- PC Engine  
- PC Engine CD  
- NeoGeo  
- NeoGeo CD  

---

## Shader Types

### Modern Simple

Shader: modern-simple.glslp  

- Scale2x upscaling with sharp bilinear filtering  
- Clean and smooth image output  

---

### Modern NTSC

Shader: modern-ntsc.glslp  

- Adds NTSC-style color processing  
- Includes scaling and smoothing  

---

### Modern GBA

Shader: modern-gba.glslp  

- Game Boy Advance color correction  
- Combined with scaling and smoothing  

---

## How It Works

### First Run

On first launch, the script will:

- Check for required shader files  
- Install shaders if missing:
  - Create presets in:

    ~/.config/retroarch/shaders/

  - Generate modern shader pipelines  
  - Set correct file ownership  

---

### Applying Shaders

- Writes `.glslp` files to:

  ~/.config/retroarch/config/<CoreName>/  
  ~/.config/retroarch32/config/<CoreName>/  

- RetroArch automatically loads shaders per core  

---

### Removing Shaders

- Deletes `.glslp` files from config directories  
- Restores default RetroArch behavior  

---

## Installation

1. Copy the script to your R36S Tools folder

2. Run it

---

## Requirements

- R36S running ArkOS or dArkOS  
- RetroArch (standard install paths)  

Required tools:

- dialog  
- gptokeyb  
- setfont  

---

## File Locations

Shader presets:

~/.config/retroarch/shaders/

Core shader configs:

~/.config/retroarch/config/<CoreName>/

32-bit core configs:

~/.config/retroarch32/config/<CoreName>/

---

## Notes

- Optimized specifically for R36S hardware  
- Focused on clarity and performance rather than CRT effects  
- Safe to re-run without breaking existing configs  

---

## Credits

- Created by djparent  

---
