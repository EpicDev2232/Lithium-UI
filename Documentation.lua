local Lithium = require(Lithium)

-- Creating a new window (only do this once)
local Window = Lithium:MakeWindow({
  Title = string; -- This text will appear in the center of the topbar
  Theme = string; -- This is the default theme applied to the UI (check source code for themes)
})

-- Getting Flags (UI element values)
local FlagValue = Window:GetFlag(flagname)

-- Creating a tab
local NewTab = Window:MakeTab({
  Name = string; -- This text will be shown on the tab button
})

-- Creating a panel
local NewPanel = Window:MakePanel({
  Name = string; -- This text will appear at the top of the panel
  Side = string -- The side the panel will appear on ("Left" or "Right")
})

-- Toggle element
local NewToggle = NewPanel:MakeToggle({
  Text = string; -- This text will appear on the toggle ui
  Value = bool; -- The default value of the toggle
  Callback = function(value) -- The callback function that is fired every time the toggle is changed
      
  end;
  Flag = string; -- Name of the toggle's flag (get toggle value by doing Window:GetFlag())
})

NewToggle:SetValue(bool) -- Set value of the toggle

-- Slider element
local NewSlider = NewPanel:MakeSlider({
  Text = string; -- This text will appear on the slider ui
  Min = number; -- Minimum value of the slider
  Max = number; -- Maximum value of the slider
  Inc = number; -- Step increment of the slider
  Value = number; -- Default value of the slider
  Callback = function(value) -- The callback function that is fired every time the slider is moved
  
  end;
  Flag = string; -- Name of the slider's flag (get slider value by doing Window:GetFlag())
})

NewSlider:SetValue(number) -- Set value of the slider

-- Color picker element
local NewColorPicker = NewPanel:MakeColorPicker({
  Text = string; -- This text will appear on the color picker ui
  Value = Color3; -- Default value of the color picker
  Callback = function(value) -- The callback function that is fired every time the color is changed
      
  end;
  Flag = string; -- Name of the color pickers's flag (get color value by doing Window:GetFlag())
})
