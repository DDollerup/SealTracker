# SealTracker

SealTracker is a World of Warcraft addon designed to help Paladins monitor their active Seal buffs in real-time. It provides a draggable, semi-transparent frame that displays the currently active Seal buff with its associated icon and status.

## Features

- **Movable Frame**: Hold `CTRL + Left-Click` to drag the frame to your desired position on the screen.
- **Seal Buff Tracking**: Automatically updates to display the currently active Seal buff or shows "Inactive" if no Seal is active.
- **Dynamic Icon**: Displays the icon corresponding to the active Seal for visual clarity.
- **Customizable Positioning**: A lightweight, draggable UI element for seamless integration into your custom UI setup.

## How It Works

- **Frame Setup**: Displays a frame with a width of 58px and height of 98px, positioned by default in the center-right of the screen, offset by 145 pixels to the right.
- **Background and Transparency**: A semi-transparent black background with a decorative border ensures clear visibility without being intrusive.
- **Event-Driven Updates**:
  - `UNIT_AURA`: Updates whenever buffs on the player change.
  - `PLAYER_ENTERING_WORLD`: Initializes Seal tracking upon logging in.
- **Dynamic Seal Detection**: Scans the player's active buffs to detect and display the currently active Seal.

## Supported Seal Buffs

SealTracker recognizes the following Seals:
- Seal of Light
- Seal of the Crusader
- Seal of Wisdom
- Seal of the Righteous
- Seal of Justice
- Seal of Command

If no Seal is active, the frame displays a placeholder icon and "Inactive" status.

## Usage

1. **Install SealTracker** (instructions below).
2. Launch World of Warcraft; the addon will load automatically.
3. Use `CTRL + Left-Click` to drag the frame to your preferred location.
4. The frame will update dynamically to show:
   - The icon of the active Seal.
   - The status text ("Active" or "Inactive").

## Installation

1. Download the addon files.
2. Extract them to your `World of Warcraft/Interface/AddOns` folder.
3. Restart World of Warcraft.
4. Enjoy streamlined Seal tracking with SealTracker!

## Additional Information

- Developed by Dollerp.
- Fully integrated into the World of Warcraft UI.
- Lightweight and optimized for performance.

Enhance your Paladin gameplay with SealTracker today!
