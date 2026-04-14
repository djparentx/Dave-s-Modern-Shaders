Dave's Modern Shaders
by djparent

A RetroArch shader management tool for ArkOS and DarkOS handheld devices.

Provides a clean, controller-friendly menu to apply and remove modern shader presets per system with improved scaling, smoothing, and color output.

Features

- Apply or remove shaders per system or all at once
- Modern shader pipeline focused on clarity and smooth scaling
- Uses Scale2x and sharp bilinear filtering for cleaner upscaling
- Optional NTSC color shader for console systems
- Custom Game Boy Advance color correction shader
- Lightweight shader stack designed for performance on RK3326 devices
- Multilingual support (auto-detected from EmulationStation):
    - English, Français, Español, Português, Italiano, Deutsch, Polski
- Self-installing shader presets on first run
- Fully gamepad navigable:
    - X / Y buttons toggle checklist items

Supported Systems:

Handhelds:

- Nintendo Game Boy
  - Modern scaling + smoothing
- Nintendo Game Boy Color
  - Modern scaling + smoothing
- Nintendo Game Boy Advance
  - GBA color correction + scaling + smoothing
- SEGA Game Gear
  - Modern scaling + smoothing
- NeoGeo Pocket
  - Modern scaling + smoothing
- NeoGeo Pocket Color
  - Modern scaling + smoothing
- WonderSwan Color
  - Modern scaling + smoothing
- Atari Lynx
  - Modern scaling + smoothing

Consoles:

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

Shader Types:

Modern Simple
Shader: modern-simple.glslp
- Scale2x upscaling with sharp bilinear filtering for smooth, clean output

Modern NTSC
Shader: modern-ntsc.glslp
- Adds NTSC-style color processing with scaling and smoothing

Modern GBA
Shader: modern-gba.glslp
- Game Boy Advance color correction combined with scaling and smoothing

How It Works:

First Run:

- Checks if shader files are installed
    - If not, installer will:
      Create shader presets in:
      ~/.config/retroarch/shaders/
      Generate all required modern shader pipelines
      Set correct ownership on all files

Applying Shaders:

- Writes .glslp files to:
  ~/.config/retroarch/config/<CoreName>/
  ~/.config/retroarch32/config/<CoreName>/ (for 32-bit cores)
  RetroArch loads shaders automatically per core

Removing Shaders:

- Deletes .glslp files from core config folders
- Restores default RetroArch behavior

Installation:

- Copy script to device (via Samba or SSH)

Make executable:

- chmod +x Dave_s_Modern_Shaders.sh

Launch:

- From Ports / Tools menu in EmulationStation
- Or run directly in terminal
- Script will request root privileges if needed

Requirements:

- ArkOS or DarkOS (RK3326 devices)
- Examples: R36S, RG351MP, Odroid-Go Advance
- RetroArch (standard install paths)

Required tools:

dialog
gptokeyb
setfont

File Locations:

Shader presets:
~/.config/retroarch/shaders/

Core shader configs
~/.config/retroarch/config/<CoreName>/

32-bit core configs
~/.config/retroarch32/config/<CoreName>/
