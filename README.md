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
