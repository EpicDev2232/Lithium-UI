local Lithium = {}

-- Vars

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Themes = {
	["Default Green"] = {
		UIAccents = Color3.fromRGB(94, 180, 85);
		ZIndex1Col = Color3.fromRGB(56, 56, 56);
		ZIndex2Col = Color3.fromRGB(47, 47, 47);
		ZIndex3Col = Color3.fromRGB(39, 39, 39);
		ZIndex4Col = Color3.fromRGB(31, 31, 31);
		BackgroundCol = Color3.fromRGB(21, 21, 21)
	};
	
	["Default Blue"] = {
		UIAccents = Color3.fromRGB(94, 140, 180);
		ZIndex1Col = Color3.fromRGB(56, 56, 56);
		ZIndex2Col = Color3.fromRGB(47, 47, 47);
		ZIndex3Col = Color3.fromRGB(39, 39, 39);
		ZIndex4Col = Color3.fromRGB(31, 31, 31);
		BackgroundCol = Color3.fromRGB(21, 21, 21)
	};
	
	["Default Purple"] = {
		UIAccents = Color3.fromRGB(141, 102, 180);
		ZIndex1Col = Color3.fromRGB(56, 56, 56);
		ZIndex2Col = Color3.fromRGB(47, 47, 47);
		ZIndex3Col = Color3.fromRGB(39, 39, 39);
		ZIndex4Col = Color3.fromRGB(31, 31, 31);
		BackgroundCol = Color3.fromRGB(21, 21, 21)
	};
	
	["Default"] = {
		UIAccents = Color3.fromRGB(66, 66, 66);
		ZIndex1Col = Color3.fromRGB(56, 56, 56);
		ZIndex2Col = Color3.fromRGB(47, 47, 47);
		ZIndex3Col = Color3.fromRGB(39, 39, 39);
		ZIndex4Col = Color3.fromRGB(31, 31, 31);
		BackgroundCol = Color3.fromRGB(21, 21, 21)
	};
}

-- Misc

function lerp(a, b, c)
	return a + (b - a) * c
end

-- Lithium

function Lithium:MakeWindow(info)
	if info then
		local LithiumUI = {}
		LithiumUI.Flags = {}
		
		local UIContainer = Instance.new("ScreenGui")
		UIContainer.ResetOnSpawn = false
		UIContainer.IgnoreGuiInset = true
		UIContainer.Parent = CoreGui
		
		-- Default Values
		if not info.Title then info.Title = "Lithium" end
		if not info.Theme then info.Theme = "Default" end
		
		if typeof(info.Theme) == "string" then
			info.Theme = Themes[info.Theme]
		end

        -- Mouse Unlock
        local MouseUnlock = Instance.new("ImageButton")
        MouseUnlock.BackgroundTransparency = 1
        MouseUnlock.Parent = UIContainer
        MouseUnlock.Size = UDim2.new(1,0,1,0)
        MouseUnlock.Position = UDim2.new()
        MouseUnlock.Modal = true
		
		-- Window
		local Frame = Instance.new("Frame")
		Frame.Parent = UIContainer
		Frame.BackgroundColor3 = info.Theme.BackgroundCol
		Frame.BorderSizePixel = 0
		Frame.ClipsDescendants = true
		Frame.Position = UDim2.new(0, 0, 0, 0)
		Frame.Size = UDim2.new(0, 377, 0, 576)
		
		local Containers = Instance.new("Frame")
		Containers.BackgroundTransparency = 1
		Containers.Size = UDim2.new(1, 0, 1, 0)
		Containers.Name = "Containers"
		Containers.Parent = Frame
		
		-- Topbar
		local Topbar = Instance.new("Frame")
		Topbar.Name = "Topbar"
		Topbar.Parent = Frame
		Topbar.BackgroundColor3 = info.Theme.ZIndex4Col
		Topbar.BorderSizePixel = 0
		Topbar.Size = UDim2.new(1, 0, 0, 30)

		-- Title
		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.Parent = Topbar
		Title.BackgroundTransparency = 1
		Title.Size = UDim2.new(1, 0, 1, 0)
		Title.ZIndex = 3
		Title.FontFace = Font.fromName("Sarpanch", Enum.FontWeight.Bold)
		Title.Text = info.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextScaled = true
		Title.TextXAlignment = Enum.TextXAlignment.Center

		-- Background Image
		local TopbarImage = Instance.new("Frame")
		TopbarImage.Name = "TopbarImage"
		TopbarImage.Parent = Topbar
		TopbarImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopbarImage.BackgroundTransparency = 1
		TopbarImage.ClipsDescendants = true
		TopbarImage.Size = UDim2.new(1, 0, 1, 0)
		TopbarImage.ZIndex = 2

		-- Topbar Image
		local Image = Instance.new("ImageLabel")
		Image.Parent = TopbarImage
		Image.BackgroundTransparency = 1
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(-0.4, 0, -12.5, 0)
		Image.Size = UDim2.new(2.48, 0, 27.93, 0)
		Image.Image = "rbxassetid://3052949762"
		Image.ImageColor3 = info.Theme.UIAccents

		-- Tabs
		local Tabs = Instance.new("Frame")
		Tabs.Name = "Tabs"
		Tabs.Parent = Topbar
		Tabs.BackgroundColor3 = info.Theme.ZIndex4Col
		Tabs.BorderSizePixel = 0
		Tabs.ClipsDescendants = true
		Tabs.Position = UDim2.new(0, 0, 1, 0)
		Tabs.Size = UDim2.new(1, 0, 0.73, 0)
		
		local TabLayout = Instance.new("UITableLayout")
		TabLayout.Parent = Tabs
		TabLayout.FillEmptySpaceRows = true
		TabLayout.FillEmptySpaceColumns = true
		TabLayout.FillDirection = Enum.FillDirection.Horizontal
		TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		-- UI Functions
		function LithiumUI:MakeTab(tabInfo)
			local NewTab = {}
			
			-- Default Values
			if not tabInfo.Name then tabInfo.Name = "NewTab" end
			
			-- Container UI
			local ExistingContainer = Containers:FindFirstChildOfClass("Frame")
			
			local Container = Instance.new("Frame")
			Container.Name = tabInfo.Name
			Container.Position = UDim2.new(0, 5,0.101, 0)
			Container.Size = UDim2.new(0.971, 0,0.887, 0)
			Container.BackgroundTransparency = 1
			Container.Parent = Containers
			
			local LeftColumn
			local RightColumn
			
			for i = 1,2 do
				local NewColumn = Instance.new("Frame")
				NewColumn.BackgroundTransparency = 1
				NewColumn.Size = UDim2.new(0.49, 0,1, 0)
				NewColumn.Parent = Container
				
				local NewListLayout = Instance.new("UIListLayout")
				NewListLayout.Parent = NewColumn
				NewListLayout.Padding = UDim.new(0, 5)
				
				if i == 1 then
					LeftColumn = NewColumn
					LeftColumn.Name = "LeftColumn"
				else
					RightColumn = NewColumn
					RightColumn.Name = "RightColumn"
					RightColumn.Position = UDim2.new(0.508, 0, 0, 0)
				end
				
				NewColumn = nil
			end
			
			-- hide frame if one is already showing
			if ExistingContainer then
				Container.Visible = false
			end
			
			-- Tab Button
			local TabButton = Instance.new("TextButton")
			TabButton.Name = tabInfo.Name
			TabButton.BackgroundColor3 = info.Theme.ZIndex2Col
			TabButton.BorderSizePixel = 0
			TabButton.TextColor3 = Color3.new(1,1,1)
			TabButton.Text = tabInfo.Name
			TabButton.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
			TabButton.Parent = Tabs
			TabButton.TextSize = 15
			
			local TabOutline = Instance.new("UIStroke")
			TabOutline.Parent = TabButton
			TabOutline.Color = info.Theme.ZIndex4Col
			TabOutline.Thickness = 1
			TabOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			TabOutline.LineJoinMode = Enum.LineJoinMode.Bevel
			
			TabButton.Activated:Connect(function()
				for _, OtherContainer in Containers:GetChildren() do
					OtherContainer.Visible = false
				end
				
				Container.Visible = true
			end)
			
			-- Tab Functions
			function NewTab:MakePanel(panelInfo)
				local NewPanel = {}
				
				-- Default Values
				if not panelInfo.Side then panelInfo.Side = "Left" end
				if not panelInfo.Name then panelInfo.Name = "NewPanel" end
				
				-- Panel UI
				local Panel = Instance.new("Frame")
				Panel.BackgroundColor3 = info.Theme.ZIndex3Col
				Panel.BorderSizePixel = 0
				Panel.Parent = Container:FindFirstChild(panelInfo.Side.. "Column")
				
				local PanelContainer = Instance.new("Frame")
				PanelContainer.BackgroundTransparency = 1
				PanelContainer.Position = UDim2.new(0.019, 0, 0, 25)
				PanelContainer.Size = UDim2.new(0.961, 0,1, -30)
				PanelContainer.Parent = Panel
				PanelContainer.Name = "Container"
				
				local PanelListLayout = Instance.new("UIListLayout")
				PanelListLayout.Parent = PanelContainer
				PanelListLayout.Padding = UDim.new(0, 4)
                PanelListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				
				local PanelName = Instance.new("TextLabel")
				PanelName.Name = "Title"
				PanelName.Text = panelInfo.Name
				PanelName.TextColor3 = Color3.new(1,1,1)
				PanelName.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
				PanelName.Size = UDim2.new(1, 0, 0, 18)
				PanelName.BackgroundColor3 = info.Theme.ZIndex2Col
				PanelName.Parent = Panel
				PanelName.TextSize = 16
				PanelName.TextXAlignment = Enum.TextXAlignment.Left
				PanelName.TextYAlignment = Enum.TextYAlignment.Bottom
				PanelName.BorderSizePixel = 0
				
				local Underline = Instance.new("Frame")
				Underline.Parent = PanelName
				Underline.BackgroundColor3 = info.Theme.UIAccents
				Underline.Size = UDim2.new(1, 0, 0, 1)
				Underline.Position = UDim2.new(0, 0, 1, 0)
				Underline.BorderSizePixel = 0
				
				-- Panel Functions
				function NewPanel:MakeToggle(toggleInfo)
					local NewToggle = toggleInfo
					
					if not NewToggle then
						NewToggle = {}
					end
					
					-- Default Values
					if not NewToggle.Text then NewToggle.Text = "NewToggle" end
					if not NewToggle.Value then NewToggle.Value = false end
                    if not NewToggle.Flag then NewToggle.Flag = NewToggle.Text end
					
					-- Slider UI
					local Toggle = Instance.new("TextButton")
					Toggle.Name = NewToggle.Text
					Toggle.BackgroundColor3 = info.Theme.ZIndex2Col
					Toggle.BorderSizePixel = 0
					Toggle.Size = UDim2.new(1, 0, 0, 20)
					Toggle.TextColor3 = Color3.new(1,1,1)
					Toggle.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
					Toggle.Text = NewToggle.Text
					Toggle.TextXAlignment = Enum.TextXAlignment.Left
					Toggle.TextSize = 14
					Toggle.Parent = PanelContainer
					Toggle.AutoButtonColor = false
					
					local ToggleIndicator = Instance.new("ImageLabel")
					ToggleIndicator.Position = UDim2.new(0.842, 0,0.25, 0)
					ToggleIndicator.Size = UDim2.new(0.059, 0,0.75, 0)
					ToggleIndicator.BackgroundColor3 = info.Theme.UIAccents
					ToggleIndicator.BorderSizePixel = 0
					ToggleIndicator.Parent = Toggle
					
					local IndicatorOutline = Instance.new("UIStroke")
					IndicatorOutline.Parent = ToggleIndicator
					IndicatorOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					IndicatorOutline.LineJoinMode = Enum.LineJoinMode.Bevel
					IndicatorOutline.Thickness = 2
					IndicatorOutline.Color = info.Theme.UIAccents
					
					local IndicatorAspectRatio = Instance.new("UIAspectRatioConstraint")
					IndicatorAspectRatio.Parent = ToggleIndicator
					
					-- Toggle Functions
					function NewToggle:SetValue(value)
						NewToggle.Value = value
						
						if NewToggle.Value == true then
							ToggleIndicator.BackgroundTransparency = 0
						else
							ToggleIndicator.BackgroundTransparency = 1
						end
						
						if NewToggle.Flag then
							LithiumUI.Flags[NewToggle.Flag] = value
						end
						
						if NewToggle.Callback then
							task.spawn(function() NewToggle.Callback(value) end)
						end
					end
					
					-- Connect Toggle
					Toggle.Activated:Connect(function()
						NewToggle:SetValue(not NewToggle.Value)
					end)
					
					-- set default value
					NewToggle:SetValue(NewToggle.Value)
					
					return NewToggle
				end
				
				function NewPanel:MakeSlider(sliderInfo)
					local NewSlider = sliderInfo
					
					if not NewSlider then
						NewSlider = {}
					end
					
					-- Default Values
					if not NewSlider.Text then NewSlider.Text = "NewSlider" end
					if not NewSlider.Min then NewSlider.Min = 0 end
					if not NewSlider.Max then NewSlider.Max = 100 end
					if not NewSlider.Inc then NewSlider.Inc = 1 end
					if not NewSlider.Value then NewSlider.Value = NewSlider.Min end
                    if not NewSlider.Flag then NewSlider.Flag = NewSlider.Text end
					
					NewSlider.Inc = math.clamp(NewSlider.Inc, 0.001, 1)
					
					-- Slider UI
					local Slider = Instance.new("Frame")
					Slider.Name = NewSlider.Text
					Slider.BackgroundColor3 = info.Theme.ZIndex2Col
					Slider.BorderSizePixel = 0
					Slider.Size = UDim2.new(1, 0, 0, 40)
					Slider.Parent = PanelContainer
					
					local SliderText = Instance.new("TextLabel")
					SliderText.Name = "Text"
					SliderText.BackgroundTransparency = 1
					SliderText.Size = UDim2.new(0.688, 0,0.5, 0)
					SliderText.Parent = Slider
					SliderText.TextColor3 = Color3.new(1,1,1)
					SliderText.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
					SliderText.Text = NewSlider.Text
					SliderText.TextXAlignment = Enum.TextXAlignment.Left
					SliderText.TextSize = 14
					
					local SliderValue = Instance.new("TextLabel")
					SliderValue.Name = "Value"
					SliderValue.BackgroundTransparency = 1
					SliderValue.Size = UDim2.new(0.287, 0,0.5, 0)
					SliderValue.Position = UDim2.new(0.713, 0, 0, 0)
					SliderValue.Parent = Slider
					SliderValue.TextColor3 = Color3.new(1,1,1)
					SliderValue.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
					SliderValue.Text = tostring(NewSlider.Def)
					SliderValue.TextXAlignment = Enum.TextXAlignment.Left
					SliderValue.TextSize = 14
					
					local SliderContainer = Instance.new("Frame")
					SliderContainer.BackgroundColor3 = info.Theme.ZIndex3Col
					SliderContainer.Position = UDim2.new(0.053, 0,0.675, 0)
					SliderContainer.Size = UDim2.new(0.888, 0,0.15, 0)
					SliderContainer.Parent = Slider
					
					local SliderContainerCorner = Instance.new("UICorner")
					SliderContainerCorner.CornerRadius = UDim.new(1, 0)
					SliderContainerCorner.Parent = SliderContainer
					
					local SliderHandle = Instance.new("ImageButton")
					SliderHandle.BackgroundColor3 = info.Theme.UIAccents
					SliderHandle.AnchorPoint = Vector2.new(0.5, 0.5)
					SliderHandle.Size = UDim2.new(0, 13, 0, 13)
					SliderHandle.Parent = SliderContainer
					SliderHandle.AutoButtonColor = false
					
					local SliderHandleCorner = Instance.new("UICorner")
					SliderHandleCorner.CornerRadius = UDim.new(1, 0)
					SliderHandleCorner.Parent = SliderHandle
					
					local SliderHandleAspect = Instance.new("UIAspectRatioConstraint")
					SliderHandleAspect.Parent = SliderHandle
					
					-- Slider Functions
					function NewSlider:SetValue(value)
						SliderHandle.Position = UDim2.new((value - NewSlider.Min) / (NewSlider.Max - NewSlider.Min), 0, 0.5, 0)
						SliderValue.Text = tostring(value)
						
						NewSlider.Value = value
						
						if NewSlider.Flag then
							LithiumUI.Flags[NewSlider.Flag] = value
						end

						if NewSlider.Callback then
							task.spawn(function() NewSlider.Callback(value) end)
						end
					end
					
					-- Connect Slider
					SliderHandle.MouseButton1Down:Connect(function()
						RunService:BindToRenderStep("ConnectSlider", 1, function()
							local mousePos = UserInputService:GetMouseLocation()
							local lerpValue = math.clamp((mousePos.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
							local newValue = math.round(lerp(NewSlider.Min, NewSlider.Max, lerpValue) / NewSlider.Inc) * NewSlider.Inc
							
							NewSlider:SetValue(newValue)
						end)
					end)
					
					UserInputService.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							RunService:UnbindFromRenderStep("ConnectSlider")
						end
					end)
					
					-- set default value
					NewSlider:SetValue(NewSlider.Value)
					
					return NewSlider
				end
				
				function NewPanel:MakeColorPicker(colorPickerInfo)
					local NewColorPicker = colorPickerInfo
					
					-- Default Values
					if not NewColorPicker.Text then NewColorPicker.Text = "NewColorPicker" end
					if not NewColorPicker.Value then NewColorPicker.Value = Color3.new(1,1,1) end
					if not (NewColorPicker.H or NewColorPicker.S or NewColorPicker.V) then
						NewColorPicker.H, NewColorPicker.S, NewColorPicker.V = NewColorPicker.Value:ToHSV()
					end
                    if not NewColorPicker.Flag then NewColorPicker.Flag = NewColorPicker.Text end
					
					-- Misc Functions
					local function CreateHandle(frame)
						local Handle = Instance.new("Frame")
						Handle.Parent = frame
						Handle.Size = UDim2.new(0, 3, 0, 3)
						Handle.BackgroundColor3 = Color3.new(1,1,1)
						Handle.AnchorPoint = Vector2.new(0, 0)

						local HandleCorner = Instance.new("UICorner")
						HandleCorner.Parent = Handle
						HandleCorner.CornerRadius = UDim.new(1, 0)

						local HandleOutline = Instance.new("UIStroke")
						HandleOutline.Parent = Handle
						HandleOutline.Thickness = 2
						HandleOutline.Color = info.Theme.ZIndex3Col
						
						return Handle
					end
					
					local function FixHSVValues()
						NewColorPicker.H = math.clamp(NewColorPicker.H * 100, 1, 100) * 0.01
						NewColorPicker.S = math.clamp(NewColorPicker.S * 100, 1, 100) * 0.01
						NewColorPicker.V = math.clamp(NewColorPicker.V * 100, 1, 100) * 0.01
					end
					
					-- Color Picker UI
					local ColorPicker = Instance.new("TextLabel")
					ColorPicker.Name = NewColorPicker.Text
					ColorPicker.BackgroundColor3 = info.Theme.ZIndex2Col
					ColorPicker.BorderSizePixel = 0
					ColorPicker.Size = UDim2.new(1, 0, 0, 20)
					ColorPicker.TextColor3 = Color3.new(1,1,1)
					ColorPicker.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
					ColorPicker.Text = NewColorPicker.Text
					ColorPicker.TextXAlignment = Enum.TextXAlignment.Left
					ColorPicker.TextSize = 14
					ColorPicker.Parent = PanelContainer
					
					local ColorIndicator = Instance.new("ImageButton")
					ColorIndicator.Position = UDim2.new(0.842, 0,0.25, 0)
					ColorIndicator.Size = UDim2.new(0.059, 0,0.75, 0)
					ColorIndicator.BackgroundColor3 = NewColorPicker.Value
					ColorIndicator.BorderSizePixel = 0
					ColorIndicator.Parent = ColorPicker

					local IndicatorOutline = Instance.new("UIStroke")
					IndicatorOutline.Parent = ColorIndicator
					IndicatorOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					IndicatorOutline.LineJoinMode = Enum.LineJoinMode.Bevel
					IndicatorOutline.Thickness = 2
					IndicatorOutline.Color = info.Theme.ZIndex3Col
					
					local IndicatorAspectRatio = Instance.new("UIAspectRatioConstraint")
					IndicatorAspectRatio.Parent = ColorIndicator
					
					local ColorPickerFrame = Instance.new("Frame")
					ColorPickerFrame.Parent = ColorPicker
					ColorPickerFrame.BackgroundColor3 = info.Theme.ZIndex4Col
					ColorPickerFrame.BorderSizePixel = 0
					ColorPickerFrame.Position = UDim2.new(0, 0, 1, 0)
					ColorPickerFrame.Size = UDim2.new(1, 0, 7, 0)
					ColorPickerFrame.Visible = false
					
					-- Hue
					local Hue = Instance.new("Frame")
					Hue.Name = "Hue"
					Hue.Parent = ColorPickerFrame
					Hue.Position = UDim2.new(0.053, 0,0.069, 0)
					Hue.Size = UDim2.new(0.66, 0,0.916, 0)
					Hue.BorderSizePixel = 0
					Hue.BackgroundColor3 = Color3.new(1,1,1)
					
					local HueGradient = Instance.new("UIGradient")
					HueGradient.Parent = Hue
					
					local Keypoints = {}
					for i = 0,10 do
						table.insert(Keypoints, ColorSequenceKeypoint.new(i * 0.1, Color3.fromHSV(i * 0.1, 1, 1)))
					end
					
					HueGradient.Color = ColorSequence.new(Keypoints)
					
					local HueAspect = Instance.new("UIAspectRatioConstraint")
					HueAspect.Parent = Hue
					
					-- Saturation
					local Saturation = Instance.new("ImageButton")
					Saturation.Name = "Saturation"
					Saturation.Parent = ColorPickerFrame
					Saturation.Position = UDim2.new(0.053, 0,0.069, 0)
					Saturation.Size = UDim2.new(0.66, 0,0.916, 0)
					Saturation.BorderSizePixel = 0
					Saturation.ZIndex = 2
					Saturation.BackgroundColor3 = Color3.new(1,1,1)
					Saturation.AutoButtonColor = false
					
					local SaturationGradient = Instance.new("UIGradient")
					SaturationGradient.Parent = Saturation
					SaturationGradient.Transparency = NumberSequence.new(0, 1)
					SaturationGradient.Rotation = -90
					
					local SaturationAspect = Instance.new("UIAspectRatioConstraint")
					SaturationAspect.Parent = Saturation
					
					local SaturationHandle = CreateHandle(Saturation)
					
					-- Value
					local Value = Instance.new("ImageButton")
					Value.Parent = ColorPickerFrame
					Value.Position = UDim2.new(0.81, 0,0.076, 0)
					Value.Size = UDim2.new(0.12, 0,0.84, 0)
					Value.BorderSizePixel = 0
					Value.BackgroundColor3 = Color3.new(1,1,1)
					Value.AutoButtonColor = false
					
					local ValueGradient = Instance.new("UIGradient")
					ValueGradient.Parent = Value
					ValueGradient.Color = ColorSequence.new(Color3.new(1,1,1), Color3.new(0,0,0))
					ValueGradient.Rotation = 90
					
					local ValueHandle = CreateHandle(Value)
					
					-- Color Picker Functions
					function NewColorPicker:SetValue(value)
						ColorIndicator.BackgroundColor3 = value
						NewColorPicker.Value = value
						
						NewColorPicker.H, NewColorPicker.S, NewColorPicker.V = value:ToHSV()
						
						Value.BackgroundColor3 = Color3.fromHSV(NewColorPicker.H, NewColorPicker.S, 1)
						
						ValueHandle.Position = UDim2.new(0.5, 0, 1 - NewColorPicker.V, 0)
						SaturationHandle.Position = UDim2.new(NewColorPicker.H, 0, 1 - NewColorPicker.S, 0)
						
						if NewColorPicker.Flag then
							LithiumUI.Flags[NewColorPicker.Flag] = value
						end
						
						if NewColorPicker.Callback then
							task.spawn(function() NewColorPicker.Callback(value) end)
						end
					end
					
					-- Connect Color Picker
					ColorIndicator.Activated:Connect(function()
						ColorPickerFrame.Visible = not ColorPickerFrame.Visible
					end)
					
					Saturation.MouseButton1Down:Connect(function()
						RunService:BindToRenderStep("ConnectColorPickerHS", 1, function()
							local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 30)
							
							local x = math.clamp((mousePos.X - Saturation.AbsolutePosition.X) / Saturation.AbsoluteSize.X, 0, 1)
							local y = 1 - math.clamp((mousePos.Y - Saturation.AbsolutePosition.Y) / Saturation.AbsoluteSize.Y, 0, 1)
							
							NewColorPicker.H = x
							NewColorPicker.S = y
							
							FixHSVValues()
							
							NewColorPicker:SetValue(Color3.fromHSV(NewColorPicker.H, NewColorPicker.S, NewColorPicker.V))
						end)
					end)
					
					Value.MouseButton1Down:Connect(function()
						RunService:BindToRenderStep("ConnectColorPickerV", 1, function()
							local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 30)

							local y = 1 - math.clamp((mousePos.Y - Value.AbsolutePosition.Y) / Value.AbsoluteSize.Y, 0, 1)
							
							NewColorPicker.V = y
							
							FixHSVValues()
							
							NewColorPicker:SetValue(Color3.fromHSV(NewColorPicker.H, NewColorPicker.S, NewColorPicker.V))
						end)
					end)
					
					UserInputService.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							RunService:UnbindFromRenderStep("ConnectColorPickerV")
							RunService:UnbindFromRenderStep("ConnectColorPickerHS")
						end
					end)
					
					-- set default value
					NewColorPicker:SetValue(NewColorPicker.Value)
					
					return NewColorPicker
				end

                function NewPanel:MakeSeparator(separatorInfo)
                    local NewSeparator = separatorInfo

                    -- Default Values
                    if not NewSeparator.Text then NewSeparator.Text = "NewSeparator" end

                    -- Separator UI
                    local Separator = Instance.new("TextLabel")
                    Separator.Parent = PanelContainer
                    Separator.BackgroundTransparency = 1
                    Separator.Size = UDim2.new(1, 0, 0, 30)
                    Separator.FontFace = Font.fromName("Jura", Enum.FontWeight.Bold)
                    Separator.TextColor3 = Color3.new(1,1,1)
                    Separator.TextStrokeColor3 = info.Theme.ZIndex4Col
                    Separator.TextStrokeTransparency = 0
                    Separator.TextSize = 14
                    Separator.Text = NewSeparator.Text

                    local Line1 = Instance.new("Frame")
                    Line1.BorderColor3 = info.Theme.ZIndex4Col
                    Line1.BorderSizePixel = 1
                    Line1.Size = UDim2.new(0.5, -(Separator.TextBounds.X * 0.5) - 5, 0, 0)
                    Line1.Position = UDim2.new(0, 0, 0.5, 0)
                    Line1.Parent = Separator

                    local Line2 = Instance.new("Frame")
                    Line2.BorderColor3 = info.Theme.ZIndex4Col
                    Line2.BorderSizePixel = 1
                    Line2.Size = UDim2.new(0.5, -Separator.TextBounds.X * 0.5 - 5, 0, 0)
                    Line2.Position = UDim2.new(0.5, Separator.TextBounds.X * 0.5 + 5, 0.5, 0)
                    Line2.Parent = Separator

                    return NewSeparator
                end
				
				-- extend panel
				local function UpdateSize()
					local totalSize = 25

					for _, child in pairs(PanelContainer:GetChildren()) do
						if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
							totalSize = totalSize + child.AbsoluteSize.Y + PanelListLayout.Padding.Offset
						end
					end

					Panel.Size = UDim2.new(1, 0, 0, totalSize)
				end
				
				PanelContainer.ChildAdded:Connect(UpdateSize)
				PanelContainer.ChildRemoved:Connect(UpdateSize)
				
				UpdateSize()
				
				return NewPanel
			end
			
			function NewTab:Destroy()
				Container:Destroy()
				TabButton:Destroy()
			end
			
			return NewTab
		end
		
		-- Connect Window
		Topbar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mousePos = UserInputService:GetMouseLocation()
				local offset = Frame.AbsolutePosition - mousePos
				
				RunService:BindToRenderStep("DragLithiumWindow", 1, function()
					mousePos = UserInputService:GetMouseLocation()
					
					Frame.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y) + UDim2.new(0, offset.X, 0, offset.Y)
				end)
			end
		end)
		
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.RightShift then
				UIContainer.Enabled = not UIContainer.Enabled

                UserInputService.MouseCursorEnabled = UIContainer.Enabled
			end
		end)
		
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				RunService:UnbindFromRenderStep("DragLithiumWindow")
			end
		end)
		
		-- Flag Functions
		function LithiumUI:GetFlag(name)
			local flag = LithiumUI.Flags[name]
			
			if flag then
				return flag
			end
		end
		
		return LithiumUI
	end
end

return Lithium
