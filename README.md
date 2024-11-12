# SyntaxLib - A Modern Nordic-Themed UI Library
*A sleek remake of the TurtleLib, redesigned with the Nord color palette*

## Overview
SyntaxLib is a modernized remake of the popular TurtleLib UI library, completely redesigned with a Nordic-inspired color scheme and enhanced functionality. This library provides a clean, minimalist interface for creating in-game UI elements in Roblox, while maintaining the familiar structure that made TurtleLib popular.

## Why SyntaxLib?
While TurtleLib served as an excellent foundation, SyntaxLib brings several improvements:

- **Nordic Theme**: Implements the popular Nord color palette for a modern, easy-on-the-eyes design
- **Enhanced Transparency**: Subtle transparency effects for a more contemporary look
- **Blur Effects**: Background blur when the UI is active for better focus
- **Improved Notifications**: Streamlined notification system with smooth animations
- **Better Organization**: More structured and maintainable codebase
- **Cross-Platform Compatibility**: Works seamlessly on both PC and mobile devices

## Key Features
- Draggable windows
- Customizable buttons, toggles, and sliders
- Advanced color picker with rainbow mode
- Dropdown menus with dynamic options
- Smooth animations and transitions
- Notification system with auto-stacking
- Global keybind support
- Clean, modern aesthetics

## Credit
This library is a remake of the original TurtleLib, with significant visual and functional improvements. Full credit goes to the original TurtleLib creators for the base concept and structure.

## Table of Contents
- [Getting Started](#getting-started)
- [Basic Usage](#basic-usage)
- [Components](#components)
  - [Windows](#windows)
  - [Buttons](#buttons)
  - [Labels](#labels)
  - [Toggles](#toggles)
  - [Text Boxes](#text-boxes)
  - [Sliders](#sliders)
  - [Dropdowns](#dropdowns)
  - [Color Pickers](#color-pickers)
- [Notifications](#notifications)
- [Additional Features](#additional-features)

## Getting Started

First, require the library in your script:

```lua
local library = loadstring(game:HttpGet("path/to/ui.lua"))()
```

## Basic Usage

Here's a simple example showing basic usage:

```lua
-- Create a window
local window = library:Window("My Window")

-- Add some basic elements
window:Button("Click Me", function()
  print("Button clicked!")
end)

window:Toggle("Toggle Me", false, function(value)
  print("Toggle is now:", value)
end)
```

## Components

### Windows

Create a new window:
```lua
local window = library:Window("Window Title")
```

### Buttons

Add a button to your window:
```lua
window:Button("Button Text", function()
-- Callback function
  print("Button pressed!")
end)
```

### Labels

Add a label (text) to your window:
```lua
-- Regular label
window:Label("Regular Label")

-- Rainbow colored label
window:Label("Rainbow Label", true)

-- Custom colored label
window:Label("Custom Label", Color3.fromRGB(255, 0, 0))
```

### Toggles

Add a toggle switch:
```lua
window:Toggle("Toggle Option", false, function(value)
  print("Toggle state:", value)
end)
```

### Text Boxes

Add an input text box:
```lua
window:Box("Input Label", function(text, focusLost)
    if focusLost then
      print("Text submitted:", text)
    else
      print("Text changed:", text)
    end 
end)
```

### Sliders

Add a slider:
```lua
window:Slider("Slider Name", 0, 100, 50, function(value)
    print("Slider value:", value)
end)
```

You can also update the slider value programmatically:
```lua
local slider = window:Slider("Slider Name", 0, 100, 50, function(value)
    print("Slider value:", value)
end)
-- Update slider value
slider:SetValue(75)
```

### Dropdowns

Add a dropdown menu:
```lua
local dropdown = window:Dropdown("Dropdown Title", {
    "Option 1",
    "Option 2",
    "Option 3"
}, function(selected)
    print("Selected:", selected)
end)

-- Add new options dynamically
dropdown:Button("Option 4")

-- Remove options
dropdown:Remove("Option 1")
```

### Color Pickers

Add a color picker:
```lua
-- Regular color picker
local colorPicker = window:ColorPicker("Pick Color", Color3.fromRGB(255, 0, 0), function(color)
    print("Selected color:", color)
end)

-- Rainbow mode color picker
window:ColorPicker("Rainbow Colors", true, function(color)
    print("Rainbow color:", color)
end)

-- Update color programmatically
colorPicker:UpdateColorPicker(Color3.fromRGB(0, 255, 0))

-- Enable rainbow mode programmatically
colorPicker:UpdateColorPicker(true)
```

## Notifications

Show notifications:
```lua
library.Notify({
    Title = "Notification Title",
    Description = "This is a notification message",
    Duration = 5 -- Duration in seconds
})
```

## Additional Features

### Keybind to Toggle UI

Set a keybind to show/hide the entire UI:
```lua
library:Keybind("RightControl") -- Uses Enum.KeyCode names
```

### Hide/Show UI

Programmatically hide or show the UI:
```lua
library:Hide() -- Toggles UI visibility
```

### Destroy UI

Remove the UI completely:
```lua
library:Destroy()
```
