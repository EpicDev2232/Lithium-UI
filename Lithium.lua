local Lithium = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerGui = game:WaitForChild("CoreGui")

local LocalPlayer = Players.LocalPlayer

Lithium.vars = {}

function Lithium:MakeWindow(WindowProperties)
	local Window = WindowProperties
	
	-- default
	
	if not Window.Theme then
		Window.Theme = {
			Outlines = Color3.fromRGB(67, 67, 67),
			Color1 = Color3.fromRGB(33, 33, 33),
			Color2 = Color3.fromRGB(24, 24, 24),
			Accent = Color3.fromRGB(166, 120, 175),
		}
	end
	
	if not Window.Title then
		Window.Title = "lithium.ui"
	end
	
	if not Window.Enabled then
		Window.Enabled = true
	end
	
	-- ui
	
	local LithiumContainer = Instance.new("ScreenGui")
	LithiumContainer.Parent = PlayerGui
	LithiumContainer.IgnoreGuiInset = true
	LithiumContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	Window.MouseCursor = Instance.new("Frame")
	Window.MouseCursor.Parent = LithiumContainer
	Window.MouseCursor.Active = false
	Window.MouseCursor.AnchorPoint = Vector2.new(0.5, 0.5)
	Window.MouseCursor.Size = UDim2.new(0, 2, 0, 2)
	Window.MouseCursor.BackgroundColor3 = Color3.new(1,1,1)
	Window.MouseCursor.BorderColor3 = Color3.new()
	Window.MouseCursor.ZIndex = 2
	
	Window.GUI = Instance.new("Frame")
	Window.GUI.Name = "MainFrame"
	Window.GUI.Parent = LithiumContainer
	Window.GUI.Size = UDim2.new(0, 616,0, 700)
	Window.GUI.Position = UDim2.new(0, 50, 0, 50)
	
	Window.GUI.BackgroundColor3 = Window.Theme.Accent
	Window.GUI.BorderColor3 = Window.Theme.Color2
	
	Window.GUI:SetAttribute("BackgroundColor3", "Accent")
	Window.GUI:SetAttribute("BorderColor3", "Color1")
	
	local Frame1 = Instance.new("Frame")
	Frame1.Parent = Window.GUI
	Frame1.Size = UDim2.new(1, -4, 1, -4)
	Frame1.Position = UDim2.new(0, 2, 0, 2)
	
	Frame1.BackgroundColor3 = Window.Theme.Color2
	Frame1.BorderSizePixel = 0
	
	Frame1:SetAttribute("BackgroundColor3", "Color2")
	
	local Title = Instance.new("TextLabel")
	Title.Parent = Frame1
	Title.Name = "Title"
	Title.Size = UDim2.new(1, -10, 0, 20)
	Title.Position = UDim2.new(0, 5, 0, 0)
	
	Title.BackgroundTransparency = 1
	Title.TextStrokeTransparency = 0
	Title.TextColor3 = Color3.new(1,1,1)
	Title.FontFace = Font.fromName("Inconsolata")
	Title.TextSize = 14
	Title.Text = Window.Title
	Title.TextXAlignment = Enum.TextXAlignment.Left
	
	local Frame2 = Instance.new("Frame")
	Frame2.Parent = Frame1
	Frame2.Position = UDim2.new(0, 6,0, 40)
	Frame2.Size = UDim2.new(1, -12,1, -45)
	
	Frame2.BackgroundColor3 = Window.Theme.Color1
	Frame2.BorderColor3 = Window.Theme.Outlines
	
	Frame2:SetAttribute("BackgroundColor3", "Color1")
	Frame2:SetAttribute("BorderColor3", "Outlines")
	
	local TabContainer = Instance.new("Frame")
	TabContainer.Parent = Frame2
	TabContainer.Name = "Tabs"
	TabContainer.Position = UDim2.new(0, 0, 0, -19)
	TabContainer.Size = UDim2.new(1, 0,0, 18)
	
	TabContainer.BackgroundTransparency = 1
	
	local TabsListLayout = Instance.new("UIListLayout")
	TabsListLayout.Parent = TabContainer
	TabsListLayout.Padding = UDim.new(0, 5)
	TabsListLayout.FillDirection = Enum.FillDirection.Horizontal
	TabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	local TabPanelContainer = Instance.new("Frame")
	TabPanelContainer.Parent = Frame2
	TabPanelContainer.Name = "PanelContainer"
	TabPanelContainer.Size = UDim2.new(1, -10,1, -10)
	TabPanelContainer.Position = UDim2.new(0, 5, 0, 5)
	
	TabPanelContainer.BackgroundTransparency = 1
	
	local MouseUnlock = Instance.new("TextButton")
	MouseUnlock.Parent = LithiumContainer
	MouseUnlock.Size = UDim2.new(1,0,1,0)
	MouseUnlock.Modal = true
	MouseUnlock.ZIndex = 0
	
	MouseUnlock.BackgroundTransparency = 1
	MouseUnlock.TextTransparency = 1
	
	-- code
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.KeyCode == Enum.KeyCode.RightShift then
			Window.Enabled = not Window.Enabled
			
			LithiumContainer.Enabled = Window.Enabled
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			local mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)
			
			if mousePosition.X > Window.GUI.AbsolutePosition.X and mousePosition.X < Window.GUI.AbsolutePosition.X + Window.GUI.AbsoluteSize.X then
				if mousePosition.Y > Window.GUI.AbsolutePosition.Y and mousePosition.Y < Window.GUI.AbsolutePosition.Y + 30 then
					local offset = Window.GUI.AbsolutePosition - UserInputService:GetMouseLocation()
					
					RunService:BindToRenderStep("MoveMenuWithMouse", 1, function()
						mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, -30)
						
						Window.GUI.Position = UDim2.new(
							0, mousePosition.X + offset.X,
							0, mousePosition.Y + offset.Y
						)
					end)
				end
			end
		end
	end)
	
	UserInputService.InputEnded:Connect(function()
		RunService:UnbindFromRenderStep("MoveMenuWithMouse")
	end)
	
	RunService.RenderStepped:Connect(function()
		local mousePos = UserInputService:GetMouseLocation()
		
		Window.MouseCursor.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
		
		mousePos = nil
	end)
	
	-- functions
	
	function Window:MakeTab(TabProperties)
		local Tab = TabProperties
		
		-- default
		
		if not Tab.Name then
			Tab.Name = "new tab"
		end
		
		-- ui
		
		Tab.TabButton = Instance.new("TextButton")
		Tab.TabButton.Parent = TabContainer
		Tab.TabButton.Name = Tab.Name
		Tab.TabButton.Size = UDim2.new(0, 80, 1, 0)
		
		Tab.TabButton.BackgroundColor3 = Window.Theme.Color2
		Tab.TabButton.BorderColor3 = Window.Theme.Outlines
		Tab.TabButton.Text = ""
		Tab.TabButton.AutoButtonColor = false
		
		Tab.TabButton:SetAttribute("BackgroundColor3", "Color2")
		Tab.TabButton:SetAttribute("BorderColor3", "Outlines")
		
		local TabButtonCover = Instance.new("Frame")
		TabButtonCover.Parent = Tab.TabButton
		TabButtonCover.Name = "Cover"
		TabButtonCover.Size = UDim2.new(1, 0,1, 1)
		TabButtonCover.ZIndex = 3
		TabButtonCover.Active = true
		TabButtonCover.Visible = false
		
		TabButtonCover.BackgroundColor3 = Window.Theme.Color1
		TabButtonCover.BorderSizePixel = 0
		
		TabButtonCover:SetAttribute("BackgroundColor3", "Color1")
		
		local TabButtonFade = Instance.new("Frame")
		TabButtonFade.Parent = Tab.TabButton
		TabButtonFade.Name = "Fade"
		TabButtonFade.Size = UDim2.new(1,0,1,0)
		TabButtonFade.ZIndex = 2
		TabButtonFade.Active = true
		
		TabButtonFade.BackgroundColor3 = Window.Theme.Color1
		TabButtonFade.BorderSizePixel = 0
		Lithium:VerticalFade(TabButtonFade)
		
		TabButtonFade:SetAttribute("BackgroundColor3", "Color1")
		
		local TabButtonText = Instance.new("TextLabel")
		TabButtonText.Parent = Tab.TabButton
		TabButtonText.Name = "Title"
		TabButtonText.Size = UDim2.new(1,0,1,0)
		TabButtonText.ZIndex = 4
		TabButtonText.Active = true
		
		TabButtonText.BackgroundTransparency = 1
		TabButtonText.Text = Tab.Name
		TabButtonText.TextColor3 = Color3.new(1,1,1)
		TabButtonText.TextStrokeTransparency = 0
		TabButtonText.TextSize = 14
		TabButtonText.FontFace = Font.fromName("Inconsolata")
		
		Tab.TabContainer = Instance.new("Frame")
		Tab.TabContainer.Parent = TabPanelContainer
		Tab.TabContainer.Name = Tab.Name
		Tab.TabContainer.Size = UDim2.new(1,0,1,0)
		Tab.TabContainer.BackgroundTransparency = 1
		Tab.TabContainer.Visible = false
		
		local Left = Instance.new("Frame")
		Left.Parent = Tab.TabContainer
		Left.Name = "Left"
		Left.Size = UDim2.new(0.5, -3,1, 0)
		Left.BackgroundTransparency = 1
		Left.ZIndex = 2
		
		local LeftListLayout = Instance.new("UIListLayout")
		LeftListLayout.Parent = Left
		LeftListLayout.FillDirection = Enum.FillDirection.Vertical
		LeftListLayout.Padding = UDim.new(0, 5)
		
		local Right = Instance.new("Frame")
		Right.Parent = Tab.TabContainer
		Right.Name = "Right"
		Right.Size = UDim2.new(0.5, -3,1, 0)
		Right.Position = UDim2.new(0.5, 3,0, 0)
		Right.BackgroundTransparency = 1

		local RightListLayout = Instance.new("UIListLayout")
		RightListLayout.Parent = Right
		RightListLayout.FillDirection = Enum.FillDirection.Vertical
		RightListLayout.Padding = UDim.new(0, 5)
		
		-- code
		
		Tab.TabButton.Activated:Connect(function()
			if Lithium.vars.LastTab then
				Lithium.vars.LastTab.TabButton.Cover.Visible = false
				Lithium.vars.LastTab.TabContainer.Visible = false
			end
			
			Lithium.vars.LastTab = Tab
			TabButtonCover.Visible = true
			Tab.TabContainer.Visible = true
		end)
		
		-- functions
		
		function Tab:MakePanel(PanelProperties)
			local Panel = PanelProperties
			
			-- default
			
			if not Panel.Name then
				Panel.Name = "NewPanel"
			end
			
			if not Panel.Side then
				Panel.Side = "Left"
			end
			
			-- ui
			
			Panel.PanelFrame = Instance.new("Frame")
			Panel.PanelFrame.Parent = Tab.TabContainer[Panel.Side]
			Panel.PanelFrame.Size = UDim2.new(1, 0, 0, 20)
			Panel.PanelFrame.Name = Panel.Name
			
			Panel.PanelFrame.BackgroundColor3 = Window.Theme.Color2
			Panel.PanelFrame.BorderColor3 = Window.Theme.Outlines
			
			Panel.PanelFrame:SetAttribute("BackgroundColor3", "Color2")
			Panel.PanelFrame:SetAttribute("BorderColor3", "Outlines")
			
			local PanelLine = Instance.new("Frame")
			PanelLine.Parent = Panel.PanelFrame
			PanelLine.Size = UDim2.new(1, 0, 0, 1)
			PanelLine.Position = UDim2.new(0, 0, 0, -1)
			
			PanelLine.BorderSizePixel = 0
			PanelLine.BackgroundColor3 = Window.Theme.Accent
			
			PanelLine:SetAttribute("BackgroundColor3", "Accents")
			
			local PanelTitle = Instance.new("TextLabel")
			PanelTitle.Parent = Panel.PanelFrame
			PanelTitle.Size = UDim2.new(1, -4, 0, 13)
			PanelTitle.Position = UDim2.new(0, 4, 0, 0)
			
			PanelTitle.BackgroundTransparency = 1
			PanelTitle.Text = Panel.Name
			PanelTitle.TextColor3 = Color3.new(1,1,1)
			PanelTitle.TextStrokeTransparency = 0
			PanelTitle.TextSize = 14
			PanelTitle.FontFace = Font.fromName("Inconsolata")
			PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
			
			local PanelContainer = Instance.new("Frame")
			PanelContainer.Parent = Panel.PanelFrame
			PanelContainer.Name = "Container"
			PanelContainer.Size = UDim2.new(1, -10, 1, -24)
			PanelContainer.Position = UDim2.new(0, 5,0, 20)
			PanelContainer.BackgroundTransparency = 1
			
			local PanelContainerListLayout = Instance.new("UIListLayout")
			PanelContainerListLayout.Parent = PanelContainer
			PanelContainerListLayout.Padding = UDim.new(0, 3)
			PanelContainerListLayout.FillDirection = Enum.FillDirection.Vertical
			PanelContainerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			-- code
			
			PanelContainer.ChildAdded:Connect(function()
				Panel:UpdateSize()
			end)
			
			PanelContainer.ChildRemoved:Connect(function()
				Panel:UpdateSize()
			end)
			
			-- functions
			
			function Panel:UpdateSize()
				local totalSize = 20 -- default size
				
				for _, uiElement in pairs(PanelContainer:GetChildren()) do
					if uiElement:IsA("Frame") then
						totalSize += uiElement.AbsoluteSize.Y + PanelContainerListLayout.Padding.Offset
					end
				end
				
				Panel.PanelFrame.Size = UDim2.new(1, 0, 0, totalSize)
			end
			
			function Panel:MakeLabel(LabelProperties)
				local Label = LabelProperties or {}
				
				-- defaults
				
				if not Label.Name then
					Label.Name = "new label"
				end
				
				-- ui
				
				Label.LabelFrame = Instance.new("Frame")
				Label.LabelFrame.Name = Label.Name
				Label.LabelFrame.Size = UDim2.new(1, 0, 0, 15)
				Label.LabelFrame.Parent = PanelContainer
				
				Label.LabelFrame.BackgroundTransparency = 1
				
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Parent = Label.LabelFrame
				TextLabel.AnchorPoint = Vector2.new(0, 0.5)
				TextLabel.Size = UDim2.new(1, -4,0, 13)
				TextLabel.Position = UDim2.new(0, 0, 0.5, 0)
				
				TextLabel.BackgroundTransparency = 1
				TextLabel.TextColor3 = Color3.new(1,1,1)
				TextLabel.TextStrokeTransparency = 0
				TextLabel.TextSize = 14
				TextLabel.FontFace = Font.fromName("Inconsolata")
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.Text = Label.Name
				
				-- functions
				
				function Label:MakeToggle(ToggleProperties)
					local Toggle = ToggleProperties or {}
					
					-- defaults
					
					if not Toggle.Value then
						Toggle.Value = false
					end
					
					-- ui
					
					Toggle.ToggleContainer = Instance.new("Frame")
					Toggle.ToggleContainer.Parent = Label.LabelFrame
					Toggle.ToggleContainer.Size = UDim2.new(1, 0, 1, 0)
					
					Toggle.ToggleContainer.BorderSizePixel = 0
					Toggle.ToggleContainer.BackgroundColor3 = Window.Theme.Outlines
					
					Toggle.ToggleContainer:SetAttribute("BackgroundColor3", "Outlines")
					Toggle.ToggleContainer:SetAttribute("Toggle", true)
					
					local ToggleContainerAspectRatio = Instance.new("UIAspectRatioConstraint")
					ToggleContainerAspectRatio.Parent = Toggle.ToggleContainer
					ToggleContainerAspectRatio.DominantAxis = Enum.DominantAxis.Width
					
					local ToggleButton = Instance.new("TextButton")
					ToggleButton.Parent = Toggle.ToggleContainer
					ToggleButton.Size = UDim2.new(1, -4,1, -4)
					ToggleButton.Position = UDim2.new(0, 2, 0, 2)
					ToggleButton.AutoButtonColor = false
					
					ToggleButton.Text = ""
					ToggleButton.BorderColor3 = Color3.new()
					
					Lithium:VerticalFade(ToggleButton)
					
					-- code
					
					ToggleButton.Activated:Connect(function()
						Toggle:Toggle()
					end)
					
					-- functions
					
					function Toggle:Toggle(bool)
						if bool == nil then
							bool = not Toggle.Value
						end
						
						Toggle.Value = bool
						
						if Toggle.Callback then
							task.spawn(function() Toggle.Callback(Toggle.Value) end)
						end
						
						if Toggle.Value then
							ToggleButton:SetAttribute("BackgroundColor3", "Accent")
						else
							ToggleButton:SetAttribute("BackgroundColor3", "Color2")
						end
						
						ToggleButton.BackgroundColor3 = Window.Theme[ToggleButton:GetAttribute("BackgroundColor3")]
					end
					
					Toggle:Toggle(Toggle.Value)
					Label:UpdateComponentPadding()
					
					return Toggle
				end
				
				function Label:MakeColorPicker(ColorPickerProperties)
					local ColorPicker = ColorPickerProperties or {}
					
					-- defaults
					
					if not ColorPicker.Name then
						ColorPicker.Name = "new color picker"
					end
					
					if not ColorPicker.Color then
						ColorPicker.Color = Color3.new(1,0,0)
					end
					
					local defH, defS, defV = ColorPicker.Color:ToHSV()
					
					ColorPicker.Hue = defH
					ColorPicker.Saturation = defS
					ColorPicker.Val = defV
					
					-- ui
					
					ColorPicker.ColorPickerContainer = Instance.new("Frame")
					ColorPicker.ColorPickerContainer.Parent = Label.LabelFrame
					ColorPicker.ColorPickerContainer.Size = UDim2.new(0, 25,1, 0)

					ColorPicker.ColorPickerContainer.BorderSizePixel = 0
					ColorPicker.ColorPickerContainer.BackgroundColor3 = Window.Theme.Outlines

					ColorPicker.ColorPickerContainer:SetAttribute("BackgroundColor3", "Outlines")
					ColorPicker.ColorPickerContainer:SetAttribute("ColorPicker", true)

					local ColorPickerButton = Instance.new("TextButton")
					ColorPickerButton.Parent = ColorPicker.ColorPickerContainer
					ColorPickerButton.Size = UDim2.new(1, -4,1, -4)
					ColorPickerButton.Position = UDim2.new(0, 2, 0, 2)
					ColorPickerButton.AutoButtonColor = false
					ColorPickerButton.Text = ""
					ColorPickerButton.BorderColor3 = Color3.new()
					
					Lithium:VerticalFade(ColorPickerButton)
					
					ColorPicker.ColorPickerFrame = Instance.new("Frame")
					ColorPicker.ColorPickerFrame.Visible = false
					ColorPicker.ColorPickerFrame.Parent = Panel.PanelFrame
					ColorPicker.ColorPickerFrame.Position = UDim2.new(
						0, ColorPicker.ColorPickerContainer.AbsolutePosition.X - Panel.PanelFrame.AbsolutePosition.X,
						0, ColorPicker.ColorPickerContainer.AbsolutePosition.Y - Panel.PanelFrame.AbsolutePosition.Y
					)
					ColorPicker.ColorPickerFrame.Size = UDim2.new(0, 199,0, 207)
					
					ColorPicker.ColorPickerFrame.BackgroundColor3 = Window.Theme.Color2
					ColorPicker.ColorPickerFrame.BorderColor3 = Window.Theme.Outlines
					
					ColorPicker.ColorPickerFrame:SetAttribute("BackgroundColor3", "Color2")
					ColorPicker.ColorPickerFrame:SetAttribute("BorderColor3", "Outlines")
					
					local ColorPickerLine = Instance.new("Frame")
					ColorPickerLine.Parent = ColorPicker.ColorPickerFrame
					ColorPickerLine.Size = UDim2.new(1, 0, 0, 1)
					ColorPickerLine.Position = UDim2.new(0, 0, 0, -1)
					
					ColorPickerLine.BorderSizePixel = 0
					ColorPickerLine.BackgroundColor3 = Window.Theme.Accent
					
					ColorPickerLine:SetAttribute("BackgroundColor3", "Accent")
					
					local ColorPickerTitle = Instance.new("TextLabel")
					ColorPicker.Parent = ColorPicker.ColorPickerFrame
					ColorPicker.Size = UDim2.new(1, -4, 0, 13)
					ColorPicker.Position = UDim2.new(0, 4, 0, 0)

					ColorPicker.BackgroundTransparency = 1
					ColorPicker.Text = Label.Name
					ColorPicker.TextColor3 = Color3.new(1,1,1)
					ColorPicker.TextStrokeTransparency = 0
					ColorPicker.TextSize = 14
					ColorPicker.FontFace = Font.fromName("Inconsolata")
					ColorPicker.TextXAlignment = Enum.TextXAlignment.Left
					
					local SatVal = Instance.new("Frame")
					SatVal.Parent = ColorPicker.ColorPickerFrame
					SatVal.Size = UDim2.new(0, 147,0, 147)
					SatVal.Position = UDim2.new(0, 6,0, 18)
					
					SatVal.BorderColor3 = Window.Theme.Outlines
					
					SatVal:SetAttribute("BorderColor3", "Outlines")
					
					local SatValBlack = Instance.new("Frame")
					SatValBlack.Parent = SatVal
					SatValBlack.Size = UDim2.new(1, -2,1, -2)
					SatValBlack.Position = UDim2.new(0, 1, 0, 1)
					SatValBlack.ZIndex = 2
					
					SatValBlack.BackgroundColor3 = Color3.new()
					SatValBlack.BorderColor3 = Color3.new()
					
					local SatValBlackFade = Instance.new("UIGradient")
					SatValBlackFade.Parent = SatValBlack
					SatValBlackFade.Rotation = -90
					SatValBlackFade.Transparency = NumberSequence.new(0, 1)
					
					local SatValWhite = Instance.new("Frame")
					SatValWhite.Parent = SatVal
					SatValWhite.Size = UDim2.new(1, -2,1, -2)
					SatValWhite.Position = UDim2.new(0, 1, 0, 1)

					SatValWhite.BackgroundColor3 = Color3.new(1,1,1)
					SatValWhite.BorderColor3 = Color3.new()
					
					local SatValWhiteFade = Instance.new("UIGradient")
					SatValWhiteFade.Parent = SatValWhite
					SatValWhiteFade.Transparency = NumberSequence.new(0, 1)
					
					local SatValHandle = Instance.new("Frame")
					SatValHandle.Parent = SatVal
					SatValHandle.Size = UDim2.new(0, 2, 0, 2)
					SatValHandle.ZIndex = 3
					
					SatValHandle.BackgroundColor3 = Color3.new(1,1,1)
					SatValHandle.BorderColor3 = Color3.new()
					
					local Hue = Instance.new("Frame")
					Hue.Parent = ColorPicker.ColorPickerFrame
					Hue.Size = UDim2.new(0, 30,0, 147)
					Hue.Position = UDim2.new(0, 160,0, 18)
					
					Hue.BackgroundColor3 = Color3.new(1,1,1)
					Hue.BorderColor3 = Window.Theme.Outlines
					
					Hue:SetAttribute("BorderColor3", "Outlines")
					
					local HueRainbow = Instance.new("Frame")
					HueRainbow.Parent = Hue
					HueRainbow.Size = UDim2.new(1, -2, 1, -2)
					HueRainbow.Position = UDim2.new(0, 1, 0 ,1)
					
					HueRainbow.BackgroundColor3 = Color3.new(1,1,1)
					HueRainbow.BorderColor3 = Window.Theme.Outlines
					
					HueRainbow:SetAttribute("BorderColor3", "Outlines")
					
					local HueRainbowFade = Instance.new("UIGradient")
					HueRainbowFade.Parent = HueRainbow
					HueRainbowFade.Rotation = -90
					
					local colorSequence = {}
					
					for i = 1,20 do
						table.insert(
							colorSequence,
							ColorSequenceKeypoint.new(
								((i - 1) / 19), Color3.fromHSV(i / 20, 1, 1)
							)
						)
					end
					
					HueRainbowFade.Color = ColorSequence.new(colorSequence)
					
					local HueHandle = Instance.new("Frame")
					HueHandle.Parent = Hue
					HueHandle.Size = UDim2.new(0, 2, 0, 2)
					HueHandle.ZIndex = 3

					HueHandle.BackgroundColor3 = Color3.new(1,1,1)
					HueHandle.BorderColor3 = Color3.new()
					
					local RGBTextBoxContainer = Instance.new("Frame")
					RGBTextBoxContainer.Parent = ColorPicker.ColorPickerFrame
					RGBTextBoxContainer.Size = UDim2.new(0, 100, 0, 28)
					RGBTextBoxContainer.Position = UDim2.new(0, 6, 1, -35)

					RGBTextBoxContainer.BorderSizePixel = 0
					RGBTextBoxContainer.BackgroundColor3 = Window.Theme.Outlines

					RGBTextBoxContainer:SetAttribute("BackgroundColor3", "Outlines")
					RGBTextBoxContainer:SetAttribute("ColorPicker", true)

					local RGBTextBox = Instance.new("TextBox")
					RGBTextBox.Parent = RGBTextBoxContainer
					RGBTextBox.Size = UDim2.new(1, -4,1, -4)
					RGBTextBox.Position = UDim2.new(0, 2, 0, 2)
					RGBTextBox.ClearTextOnFocus = false
					
					RGBTextBox.BackgroundColor3 = Window.Theme.Color2
					RGBTextBox.BorderColor3 = Color3.new()
					RGBTextBox.TextColor3 = Color3.new(1,1,1)
					RGBTextBox.TextStrokeTransparency = 0
					RGBTextBox.TextSize = 14
					RGBTextBox.PlaceholderText = "hex code"
					RGBTextBox.FontFace = Font.fromName("Inconsolata")
					RGBTextBox.TextXAlignment = Enum.TextXAlignment.Left
					
					RGBTextBox:SetAttribute("BackgroundColor3", "Color2")
					
					Lithium:VerticalFade(RGBTextBox)
					
					-- code
					
					RGBTextBox.Changed:Connect(function()
						local color = Color3.fromHex(RGBTextBox.Text)
						
						if color and color ~= ColorPicker.Color then
							ColorPicker:SetColor(color)
						end
					end)
					
					ColorPickerButton.Activated:Connect(function()
						if Lithium.vars.LastColorPicker then
							Lithium.vars.LastColorPicker.ColorPickerFrame.Visible = false
						end
						
						ColorPicker.ColorPickerFrame.Visible = true
						Lithium.vars.LastColorPicker = ColorPicker
					end)
					
					UserInputService.InputBegan:Connect(function(input, gameProcessed)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and ColorPicker.ColorPickerFrame.Visible == true then
							local mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)
							
							if
								mousePosition.X < ColorPicker.ColorPickerFrame.AbsolutePosition.X + ColorPicker.ColorPickerFrame.AbsoluteSize.X and
								mousePosition.Y < ColorPicker.ColorPickerFrame.AbsolutePosition.Y + ColorPicker.ColorPickerFrame.AbsoluteSize.Y and 
								mousePosition.X > ColorPicker.ColorPickerFrame.AbsolutePosition.X and
								mousePosition.Y > ColorPicker.ColorPickerFrame.AbsolutePosition.Y
							then
								if 
									mousePosition.X < SatVal.AbsolutePosition.X + SatVal.AbsoluteSize.X and
									mousePosition.Y < SatVal.AbsolutePosition.Y + SatVal.AbsoluteSize.Y and 
									mousePosition.X > SatVal.AbsolutePosition.X and
									mousePosition.Y > SatVal.AbsolutePosition.Y
								then
									RunService:BindToRenderStep("UpdateSatVal", 1, function(delta)
										mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)

										local clampedX = math.clamp((mousePosition.X - SatVal.AbsolutePosition.X) / SatVal.AbsoluteSize.X, 0.01, 0.99)
										local clampedY = math.clamp((mousePosition.Y - SatVal.AbsolutePosition.Y) / SatVal.AbsoluteSize.Y, 0.01, 0.99)

										ColorPicker.Saturation = clampedX
										ColorPicker.Val = 1 - clampedY

										ColorPicker:SetColor(Color3.fromHSV(ColorPicker.Hue, ColorPicker.Saturation, ColorPicker.Val))
									end)
								elseif 
									mousePosition.X < Hue.AbsolutePosition.X + Hue.AbsoluteSize.X and
									mousePosition.Y < Hue.AbsolutePosition.Y + Hue.AbsoluteSize.Y and 
									mousePosition.X > Hue.AbsolutePosition.X and
									mousePosition.Y > Hue.AbsolutePosition.Y
								then
									RunService:BindToRenderStep("UpdateHue", 1, function(delta)
										mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)

										local clampedY = math.clamp((mousePosition.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y, 0.01, 0.99)

										ColorPicker.Hue = 1 - clampedY

										ColorPicker:SetColor(Color3.fromHSV(ColorPicker.Hue, ColorPicker.Saturation, ColorPicker.Val))
									end)
								end
							else
								ColorPicker.ColorPickerFrame.Visible = false
								Lithium.vars.LastColorPicker = nil
							end
						end
					end)
					
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							RunService:UnbindFromRenderStep("UpdateSatVal")
							RunService:UnbindFromRenderStep("UpdateHue")
						end
					end)
					
					-- functions
					
					function ColorPicker:SetColor(color)
						if color then
							ColorPicker.Color = color
							
							local h, s, v = color:ToHSV()
							
							SatVal.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
							SatValHandle.Position = UDim2.new(s, 0, 1-v, 0)
							HueHandle.Position = UDim2.new(0.5, 0, 1-h, 0)
							
							ColorPickerButton.BackgroundColor3 = color
							
							RGBTextBox.Text = color:ToHex()
							
							if ColorPicker.Callback then
								task.spawn(function() ColorPicker.Callback(color) end)
							end
						end
					end
					
					ColorPicker:SetColor(ColorPicker.Color)
					Label:UpdateComponentPadding()
					
					return ColorPicker
				end
				
				function Label:MakeKeybind(KeybindProperties)
					local Keybind = KeybindProperties or {}
					
					-- defaults

					Keybind.KeyDown = false

					-- ui
					
					Keybind.KeybindFrame = Instance.new("Frame")
					Keybind.KeybindFrame.Parent = Label.LabelFrame
					Keybind.KeybindFrame.Size = UDim2.new(0, 25,1, 0)
					
					Keybind.KeybindFrame.BorderSizePixel = 0
					Keybind.KeybindFrame.BackgroundColor3 = Window.Theme.Outlines
					
					Keybind.KeybindFrame:SetAttribute("BackgroundColor3", "Outlines")
					Keybind.KeybindFrame:SetAttribute("Keybind", true)
					
					local KeybindButton = Instance.new("TextButton")
					KeybindButton.Parent = Keybind.KeybindFrame
					KeybindButton.Size = UDim2.new(1, -4,1, -4)
					KeybindButton.Position = UDim2.new(0, 2, 0, 2)
					KeybindButton.AutoButtonColor = false
					
					KeybindButton.BackgroundColor3 = Window.Theme.Color2
					KeybindButton.BorderColor3 = Color3.new()
					
					KeybindButton.TextColor3 = Color3.new(1,1,1)
					KeybindButton.TextStrokeTransparency = 0
					KeybindButton.TextSize = 14
					KeybindButton.FontFace = Font.fromName("Inconsolata")
					KeybindButton.Text = ""
					
					Lithium:VerticalFade(KeybindButton)
					
					-- code
					
					KeybindButton.Activated:Connect(function()
						KeybindButton.Text = "_"
						Keybind.Key = nil
						
						local KeyChange
						
						KeyChange = UserInputService.InputBegan:Connect(function(input)
							if input.KeyCode == Enum.KeyCode.Backspace then
								Keybind:ChangeKeybind(nil)
							else
								Keybind:ChangeKeybind(input)
							end
							
							KeyChange:Disconnect()
							KeyChange = nil
						end)
					end)
					
					UserInputService.InputBegan:Connect(function(input)
						if input == Keybind.Key then
							Keybind.KeyDown = true

							if Keybind.KeyPressed then
								task.spawn(function() Keybind.KeyPressed() end)
							end
						end
					end)
					
					UserInputService.InputEnded:Connect(function(input)
						if input == Keybind.Key then
							Keybind.KeyDown = false

							if Keybind.KeyReleased then
								task.spawn(function() Keybind.KeyReleased() end)
							end
						end
					end)
					
					-- functions
					
					function Keybind:ChangeKeybind(key)
						if key then
							Keybind.Key = key

							local name = key.KeyCode.Name

							if name == "Unknown" then
								name = key.UserInputType.Name
							end
							
							KeybindButton.Text = name
						else
							KeybindButton.Text = ""
						end
					end
					
					Label:UpdateComponentPadding()
					
					return Keybind
				end
				
				function Label:UpdateComponentPadding()
					local pad1 = 0
					local pad2 = 0

					for _, child in pairs(Label.LabelFrame:GetChildren()) do
						if child:GetAttribute("Toggle") then
							child.Position = UDim2.new(0, pad1, 0, 0)
							
							pad1 += child.AbsoluteSize.X + 3
						elseif child:GetAttribute("ColorPicker") or child:GetAttribute("Keybind") then
							child.Position = UDim2.new(1, -child.AbsoluteSize.X - pad2, 0, 0)
							
							pad2 += child.AbsoluteSize.X + 3
						end
					end
					
					TextLabel.Position = UDim2.new(0, pad1 + 2, 0.5, 0)
					
					return pad1, pad2
				end
				
				return Label
			end

			function Panel:MakeSlider(SliderProperties)
				local Slider = SliderProperties or {}
				
				-- default
				
				if not Slider.Min then
					Slider.Min = 0
				end
				
				if not Slider.Max then
					Slider.Max = 100
				end
				
				if not Slider.Inc then
					Slider.Inc = 1
				end
				
				if not Slider.Def then
					Slider.Def = Slider.Min
				end
				
				-- ui
				
				Slider.SliderFrame = Instance.new("Frame")
				Slider.SliderFrame.Parent = PanelContainer
				Slider.SliderFrame.Size = UDim2.new(1, 0, 0, 15)
				
				Slider.SliderFrame.BackgroundTransparency = 0
				Slider.SliderFrame.BorderColor3 = Window.Theme.Outlines
				
				Slider.SliderFrame:SetAttribute("BorderColor3", "Outlines")
				
				local SliderContainer = Instance.new("Frame")
				SliderContainer.Parent = Slider.SliderFrame
				SliderContainer.Size = UDim2.new(1, -2, 1, -2)
				SliderContainer.Position = UDim2.new(0, 1, 0, 1)
				
				SliderContainer.BackgroundColor3 = Window.Theme.Color1
				SliderContainer.BorderColor3 = Color3.new()
				
				SliderContainer:SetAttribute("BackgroundColor3", "Color1")
				
				local SliderBar = Instance.new("Frame")
				SliderBar.Parent = SliderContainer
				SliderBar.Size = UDim2.new(0.5, 0, 1, 0)
				
				SliderBar.BorderSizePixel = 0
				SliderBar.BackgroundColor3 = Window.Theme.Accent
				
				SliderBar:SetAttribute("BackgroundColor3", "Accents")
				
				local SliderLabel = Instance.new("TextLabel")
				SliderLabel.Parent = Slider.SliderFrame
				SliderLabel.AnchorPoint = Vector2.new(0, 0.5)
				SliderLabel.Size = UDim2.new(1, 0, 0, 13)
				SliderLabel.Position = UDim2.new(0, 0, 0.5, 0)
				
				SliderLabel.BackgroundTransparency = 1
				
				SliderLabel.TextColor3 = Color3.new(1,1,1)
				SliderLabel.TextStrokeTransparency = 0
				SliderLabel.TextSize = 14
				SliderLabel.FontFace = Font.fromName("Inconsolata")
				
				SliderLabel.ZIndex = 2
				
				local SliderOverlay = Instance.new("Frame")
				SliderOverlay.Parent = Slider.SliderFrame
				SliderOverlay.Size = UDim2.new(1, -2, 1, -2)
				SliderOverlay.Position = UDim2.new(0, 1, 0, 1)
				SliderOverlay.ZIndex = 2
				
				SliderOverlay.BorderSizePixel = 0
				SliderOverlay.BackgroundColor3 = Color3.new()
				
				local SliderFade = Instance.new("UIGradient")
				SliderFade.Parent = SliderOverlay
				SliderFade.Rotation = -90
				SliderFade.Transparency = NumberSequence.new(0.65, 1)
				
				-- code
				
				UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not Lithium.vars.LastColorPicker and Tab.TabContainer.Visible == true then
						local mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)

						if
							mousePosition.X < SliderContainer.AbsolutePosition.X + SliderContainer.AbsoluteSize.X and
							mousePosition.Y < SliderContainer.AbsolutePosition.Y + SliderContainer.AbsoluteSize.Y and 
							mousePosition.X > SliderContainer.AbsolutePosition.X and
							mousePosition.Y > SliderContainer.AbsolutePosition.Y
						then
							RunService:BindToRenderStep("SliderUpdate", 1, function(delta)
								mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, 30)
								
								local lerp = math.clamp((mousePosition.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
								
								Slider:SetValue(math.round(Lithium:Lerp(Slider.Min, Slider.Max, lerp) / Slider.Inc) * Slider.Inc)
							end)
						end
					end
				end)
				
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						RunService:UnbindFromRenderStep("SliderUpdate")
					end
				end)
				
				-- functions
				
				function Slider:SetValue(value)
					SliderLabel.Text = tostring(value).. " / ".. tostring(Slider.Max)
					
					local lerp = math.clamp((value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1)
					
					SliderBar.Size = UDim2.new(lerp, 0, 1, 0)
					
					Slider.Value = value
					
					if Slider.Callback then
						task.spawn(function() Slider.Callback(value) end)
					end
				end
				
				Slider:SetValue(Slider.Def)
				Panel:UpdateSize()

				return Slider
			end

			function Panel:MakeDropdown()
				local Dropdown = {}

				return Dropdown
			end

			function Panel:MakeSeparator(SeperatorProperties)
				local Separator = SeperatorProperties or {}
				
				-- default
				
				if not Separator.Name then
					Separator.Name = "new separator"
				end
				
				-- ui
				
				Separator.SeparatorFrame = Instance.new("Frame")
				Separator.SeparatorFrame.Parent = PanelContainer
				Separator.SeparatorFrame.Size = UDim2.new(1, 0, 0, 25)
				
				Separator.SeparatorFrame.BackgroundTransparency = 1
				
				local SeparatorTextLabel = Instance.new("TextLabel")
				SeparatorTextLabel.Parent = Separator.SeparatorFrame
				SeparatorTextLabel.AnchorPoint = Vector2.new(0, 0.5)
				SeparatorTextLabel.Size = UDim2.new(1, -4, 0, 13)
				SeparatorTextLabel.Position = UDim2.new(0, 2, 0.5, 0)
				
				SeparatorTextLabel.BackgroundTransparency = 1
				SeparatorTextLabel.BackgroundColor3 = Window.Theme.Color1
				SeparatorTextLabel.BorderColor3 = Window.Theme.Outlines
				
				SeparatorTextLabel.TextColor3 = Color3.new(1,1,1)
				SeparatorTextLabel.TextStrokeTransparency = 0
				SeparatorTextLabel.TextSize = 14
				SeparatorTextLabel.FontFace = Font.fromName("Inconsolata")
				SeparatorTextLabel.Text = Separator.Name
				
				SeparatorTextLabel:SetAttribute("BackgroundColor3", "Color1")
				SeparatorTextLabel:SetAttribute("BorderColor3", "Outlines")
				
				local line1 = Instance.new("Frame")
				line1.Parent = Separator.SeparatorFrame
				line1.AnchorPoint = Vector2.new(0, 0.5)
				line1.Size = UDim2.new(0.5, -(SeparatorTextLabel.TextBounds.X + 5), 0, 2)
				line1.Position = UDim2.new(0, 0, 0.5, 1)
				
				line1.BackgroundColor3 = Window.Theme.Color1
				line1.BorderColor3 = Window.Theme.Outlines
				
				line1:SetAttribute("BackgroundColor3", "Color1")
				line1:SetAttribute("BorderColor3", "Outlines")
				
				local line2 = Instance.new("Frame")
				line2.Parent = Separator.SeparatorFrame
				line2.AnchorPoint = Vector2.new(0, 0.5)
				line2.Size = UDim2.new(0.5, -(SeparatorTextLabel.TextBounds.X + 5), 0, 2)
				line2.Position = UDim2.new(0.5, SeparatorTextLabel.TextBounds.X + 5, 0.5, 1)

				line2.BackgroundColor3 = Window.Theme.Color1
				line2.BorderColor3 = Window.Theme.Outlines

				line2:SetAttribute("BackgroundColor3", "Color1")
				line2:SetAttribute("BorderColor3", "Outlines")
				
				Panel:UpdateSize()
				
				return Separator
			end
			
			return Panel
		end
		
		return Tab
	end
	
	function Window:UpdateTheme(theme)
		
	end
	
	return Window
end

function Lithium:VerticalFade(frame)
	local Fade = Instance.new("UIGradient")
	Fade.Parent = frame
	Fade.Rotation = -90
	
	Fade.Color = ColorSequence.new(Color3.fromRGB(172, 172, 172), Color3.fromRGB(255, 255, 255))
end

function Lithium:Lerp(a, b, c)
	return a + (b - a) * c
end

return Lithium
