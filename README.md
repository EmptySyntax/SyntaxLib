# SyntaxLib UI Library Documentation

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
