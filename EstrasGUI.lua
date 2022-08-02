local module = {}
local errorstate = {
	["InvalidType"] = "The Frame Selected Is Not Valid"
}
module.CreatorId = game.CreatorId
module.GameId = game.GameId
module.sortAcustom = "00xEstrasCustom: ".. game.CreatorId.. game.GameId.. game.Name

function CVSNewTab(frame,name)
	if typeof(frame) ~= "table" then
		return errorstate.InvalidType
	end
	if frame[1] ~= "ValidEstraFrame" then
		return errorstate.InvalidType
	end
	local tabs_2 = Instance.new("ScrollingFrame")
	local mf = frame[2]
	local UIListLayout_2 = Instance.new("UIListLayout")
	tabs_2.Name = "tabs"
	tabs_2.Parent = mf.mf.selection
	tabs_2.Active = true
	tabs_2.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	tabs_2.BorderSizePixel = 0
	tabs_2.Size = UDim2.new(0.973421931, 0, 0.970212758, 0)
	tabs_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabs_2.Visible = false
	tabs_2.AutomaticCanvasSize = Enum.AutomaticSize.Y
	UIListLayout_2.Parent = tabs_2
	UIListLayout_2.SortOrder = Enum.SortOrder.Name
	UIListLayout_2.Padding = UDim.new(0, 5)
	tabs_2.Name = name
	local tab = mf:FindFirstChild("NewTab")
	if tab then
		local newTab = tab:Clone()
		newTab.Visible = true
		newTab.Parent = mf.mf.tabs
		newTab.TextButton.Text = name
		local function newDropdown(Name)
			local drop = tab:Clone()
			drop.Visible = true
			drop.Parent = tabs_2
			local UIListLayout_22 = Instance.new("UIListLayout")
			UIListLayout_22.Parent = drop
			UIListLayout_22.SortOrder = Enum.SortOrder.LayoutOrder
			drop.TextButton.Text = Name
			drop.TextButton.Size = UDim2.new(1, 0,0, 22)
			drop.Size = UDim2.new(1, 0,0, 22)
			drop.Name = Name
			local isVisible = false
			drop.TextButton.MouseButton1Down:Connect(function()
				isVisible = not isVisible
				for _, db in pairs(drop:GetChildren()) do
					if db:IsA("Frame") then
						db.Visible = isVisible
					end
				end
				if isVisible then
					drop.Size = UDim2.new(1, 0,0, 22 * (#drop:GetChildren()-2))
					
				else
					drop.Size = UDim2.new(1, 0,0, 22)
				end
			end)

			local function newInt(name,start,placeholder,amt)
				local st = tab:Clone()
				st.TextButton:Destroy()
				st.Parent = drop
				st.Visible = true
				st.Visible = false
				local txt = Instance.new("TextLabel")
				txt.Size = UDim2.new(.2,0,0,22)
				txt.BackgroundTransparency = 1
				txt.TextColor3 = drop.TextButton.TextColor3
				txt.TextScaled = true
				txt.Text = name
				txt.Parent = st
				txt.ZIndex = 2
				local input = Instance.new("TextBox")
				input.AnchorPoint = Vector2.new(1)
				input.Size = UDim2.new(.1,0,0,16.5)
				input.Position = UDim2.new(.95,0,0,2.25)
				input.BackgroundColor3 = Color3.fromRGB(25,25,25)
				input.TextColor3 = Color3.fromRGB(255,255,255)
				input.TextScaled = true
				input.TextWrapped = false
				input.AutomaticSize = Enum.AutomaticSize.X
				input.TextXAlignment = Enum.TextXAlignment.Right
				input.Parent = st
				if not tonumber(start) then
					start = 0
				end
				input.Text = start
				Instance.new("UICorner",input).CornerRadius = UDim.new(0,4)
				if placeholder then
					input.PlaceholderText = placeholder
				end
				local be = Instance.new("BindableEvent")
				local lastInput = start
				input.FocusLost:Connect(function()
					if not tonumber(input.Text) then
						input.Text = lastInput
					else
						if amt then
							if amt[1] and amt[2] then
								lastInput = math.clamp(tonumber(input.Text),amt[1],amt[2])
							else
								lastInput = tonumber(input.Text)
							end
						else
							lastInput = tonumber(input.Text)
						end
						input.Text = lastInput
						be:Fire(lastInput)
					end
					
				end)
				local function getText()
					return input.Text
				end
				return {
					st;
					["Inputed"] = be.Event;
					["GetText"] = getText;
				}
			end
			local function newString(name,placeholder,cap)
				local st = tab:Clone()
				st.TextButton:Destroy()
				st.Parent = drop
				st.Visible = true
				st.Visible = false
				local txt = Instance.new("TextLabel")
				txt.Size = UDim2.new(.2,0,0,22)
				txt.BackgroundTransparency = 1
				txt.TextColor3 = drop.TextButton.TextColor3
				txt.TextScaled = true
				txt.Text = name
				txt.Parent = st
				txt.ZIndex = 2
				local input = Instance.new("TextBox")
				input.AnchorPoint = Vector2.new(1)
				input.Size = UDim2.new(.1,0,0,16.5)
				input.Position = UDim2.new(.95,0,0,2.25)
				input.BackgroundColor3 = Color3.fromRGB(25,25,25)
				input.TextColor3 = Color3.fromRGB(255,255,255)
				input.TextScaled = true
				input.TextWrapped = false
				input.AutomaticSize = Enum.AutomaticSize.X
				input.TextXAlignment = Enum.TextXAlignment.Right
				input.Parent = st
				Instance.new("UICorner",input).CornerRadius = UDim.new(0,4)
				if cap then
					input.Changed:Connect(function()
						if string.len(input.Text) > cap then
							input.Text = string.sub(input.Text,0,cap)
						end
					end)
				end
				if placeholder then
					input.PlaceholderText = placeholder
				end
				local be = Instance.new("BindableEvent")
				input.FocusLost:Connect(function()
					be:Fire(input.Text)
				end)
				local function getText()
					return input.Text
				end
				return {
					st;
					["Inputed"] = be.Event;
					["GetText"] = getText;
				}
			end
			local function button(Text)
				if not Text then
					Text = "[Nill]"
				end
				local st = tab:Clone()
				st.TextButton.Text = Text
				return {
					st;
					["Clicked"] = st.TextButton.MouseButton1Down;
				}
			end
			local function bool(Text)
				if not Text then
					Text = "[Nill]"
				end
				local st = tab:Clone()
				st.TextButton:Destroy()
				st.Parent = drop
				st.Visible = true
				st.Visible = false
				local txt = Instance.new("TextLabel")
				txt.Size = UDim2.new(.2,0,0,22)
				txt.BackgroundTransparency = 1
				txt.TextColor3 = drop.TextButton.TextColor3
				txt.TextScaled = true
				txt.Text = Text
				txt.Parent = st
				txt.ZIndex = 2
				local input = Instance.new("ImageButton")
				input.AnchorPoint = Vector2.new(1)
				input.Size = UDim2.new(0,16.5,0,16.5)
				input.Position = UDim2.new(.95,0,0,2.25)
				input.BackgroundColor3 = Color3.fromRGB(25,25,25)
				input.Parent = st
				input.Image = "rbxasset://textures/ui/LuaChat/icons/ic-checkbox-on copy.png"
				local inputEd = false
				Instance.new("UICorner",input).CornerRadius = UDim.new(0,4)

				local be = Instance.new("BindableEvent")
				
				input.MouseButton1Down:Connect(function()
					inputEd = not inputEd
					if inputEd then
						input.Image = "rbxasset://textures/ui/LuaChat/icons/ic-check.png"

					else
						input.Image = "rbxasset://textures/ui/LuaChat/icons/ic-checkbox-on copy.png"

					end
					be:Fire(inputEd)
				end)
				return {
					st;
					["Changed"] = be.Event;
					["Current"] = inputEd;
				}
			end
			local ret = {
				["Frame"] = drop;
				["NewInput"] = newString;
				["Newstring"] = newString;
				["NewBool"] = bool;
				["NewCheck"] = bool;
				["NewInt"] = newInt;
				["NewNumber"] = newInt;
			}
			return ret
		end
		local ret = {
			"ValidEstraFrame";
			newTab;
			["Clicked"] = newTab.TextButton.MouseButton1Down;
			["Clicked2"] = newTab.TextButton.MouseButton2Down;
			["IsOpened"] = tabs_2.Visible;
			["NewDropdown"] = newDropdown;
		}
		
		newTab.TextButton.MouseButton1Down:Connect(function()
			for _, db in pairs(mf.mf.selection:GetChildren()) do
				db.Visible = false
			end
			tabs_2.Visible = true
		end)
		return ret
	else
		return errorstate.InvalidType
	end
end
function module.NewFrame(nameOf,pos,par,theme)
	if not pos then
		pos = UDim2.new(0,0,0,0)
		
	end
	if not par then
		par = game.Players.LocalPlayer.PlayerGui
	end
	local EstrasGUI = Instance.new("ScreenGui")
	local mf = Instance.new("Frame")
	local tabs = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local TopBar = Instance.new("Frame")
	local ofname = Instance.new("TextLabel")
	local close = Instance.new("TextButton")
	local min = Instance.new("TextButton")
	local selection = Instance.new("Frame")
	local NewSelection = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TextButton = Instance.new("TextButton")
	local NewTab = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local TextButton_2 = Instance.new("TextButton")


	EstrasGUI.Name = math.random(100000,900000)
	EstrasGUI.Parent = par
	EstrasGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	mf.Name = "mf"
	mf.Parent = EstrasGUI
	mf.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	mf.BorderSizePixel = 0
	mf.Position = UDim2.new(0.0150068216, 0, 0.0256959312, 0)
	mf.Size = UDim2.new(0, 455, 0, 263)

	tabs.Name = "tabs"
	tabs.Parent = mf
	tabs.Active = true
	tabs.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	tabs.BorderSizePixel = 0
	tabs.Position = UDim2.new(0.0153846154, 0, 0.106463879, 0)
	tabs.Size = UDim2.new(0.303296715, 0, 0.866920173, 0)
	tabs.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout.Parent = tabs
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	TopBar.Name = "TopBar"
	TopBar.Parent = mf
	TopBar.BackgroundColor3 = Color3.fromRGB(163, 0, 0)
	TopBar.BorderSizePixel = 0
	TopBar.Position = UDim2.new(0, 0, 3.62613806e-09, 0)
	TopBar.Size = UDim2.new(1, 0, 0.0760456175, 0)
	TopBar.Active = true


	ofname.Name = "ofname"
	ofname.Parent = TopBar
	ofname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ofname.BackgroundTransparency = 1.000
	ofname.Size = UDim2.new(1, 0, 1, 0)
	ofname.Font = Enum.Font.SourceSans
	ofname.Text = " ".. nameOf.. " - EstrasGUI"
	ofname.TextColor3 = Color3.fromRGB(255, 255, 255)
	ofname.TextScaled = true
	ofname.TextSize = 14.000
	ofname.TextWrapped = true
	ofname.TextXAlignment = Enum.TextXAlignment.Left

	close.Name = "close"
	close.Parent = TopBar
	close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	close.BackgroundTransparency = 1.000
	close.Position = UDim2.new(0.94725275, 0, 0, 0)
	close.Size = UDim2.new(0.0527472533, 0, 1, 0)
	close.Font = Enum.Font.SourceSansBold
	close.Text = "X"
	close.TextColor3 = Color3.fromRGB(255, 255, 255)
	close.TextScaled = true
	close.TextSize = 14.000
	close.TextWrapped = true

	min.Name = "min"
	min.Parent = TopBar
	min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	min.BackgroundTransparency = 1.000
	min.Position = UDim2.new(0.894505501, 0, 0, 0)
	min.Size = UDim2.new(0.0527472533, 0, 1, 0)
	min.Font = Enum.Font.SourceSansBold
	min.Text = "-"
	min.TextColor3 = Color3.fromRGB(255, 255, 255)
	min.TextScaled = true
	min.TextSize = 14.000
	min.TextWrapped = true

	selection.Name = "selection"
	selection.Parent = mf
	selection.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	selection.BorderSizePixel = 0
	selection.Position = UDim2.new(0.338461548, 0, 0.106463879, 0)
	selection.Size = UDim2.new(0.661538482, 0, 0.89353615, 0)
	

	NewSelection.Name = "NewSelection"
	NewSelection.Parent = EstrasGUI
	NewSelection.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	NewSelection.Size = UDim2.new(1, 0, 0, 23)
	NewSelection.Visible = false

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = NewSelection

	TextButton.Parent = NewSelection
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1.000
	TextButton.Size = UDim2.new(0, 293, 0, 22)
	TextButton.Font = Enum.Font.Nunito
	TextButton.Text = " Speed"
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.TextScaled = true
	TextButton.TextSize = 14.000
	TextButton.TextWrapped = true
	TextButton.TextXAlignment = Enum.TextXAlignment.Left

	NewTab.Name = "NewTab"
	NewTab.Parent = EstrasGUI
	NewTab.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	NewTab.Size = UDim2.new(1, 0, 0,22)
	NewTab.Visible = false

	UICorner_2.CornerRadius = UDim.new(0, 4)
	UICorner_2.Parent = NewTab

	TextButton_2.Parent = NewTab
	TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton_2.BackgroundTransparency = 1.000
	TextButton_2.Size = UDim2.new(1, 0, 1, 0)
	TextButton_2.Font = Enum.Font.Nunito
	TextButton_2.Text = "Tab"
	TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton_2.TextScaled = true
	TextButton_2.TextSize = 14.000
	TextButton_2.TextWrapped = true
	local isIn = false
	local isDown = false
	local start = nil
	local start2 = nil
	TopBar.MouseEnter:Connect(function()
		isIn = true
	end)
	TopBar.MouseLeave:Connect(function()
		isIn = false
	end)
	game:GetService("UserInputService").InputEnded:Connect(function(mouse) if mouse.UserInputType == Enum.UserInputType.MouseButton1 then isDown = false end end)
	game:GetService("UserInputService").InputBegan:Connect(function(mouse) if mouse.UserInputType == Enum.UserInputType.MouseButton1 then isDown = true end end)
	task.spawn(function()
		while wait() do
			
			if isIn and isDown then
				if not start then
					start = Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)
					start2 = mf.AbsolutePosition
				end
				local current = Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)
				mf.Position = UDim2.new(0,current.X - start.X + start2.X,0,current.Y - start.Y + start2.Y)
			else
				if isDown and start then
					if not start then
						start = Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)
						start2 = mf.AbsolutePosition
					end
					local current = Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)
					mf.Position = UDim2.new(0,current.X - start.X + start2.X,0,current.Y - start.Y + start2.Y)
				else
					start = nil
				end
				
			end
		end
	end)
	
	if theme then
		if theme == "Dark" then
			TopBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
		elseif theme == "Moon" or theme == "Blue" then
			TopBar.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
			NewTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton_2.TextColor3 = Color3.fromRGB(0,0,0)
		elseif theme == "Rise" then
			TopBar.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
			NewTab.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
			mf.BackgroundTransparency = .3
		elseif theme == "Grim" then
			TopBar.BackgroundColor3 = Color3.fromRGB(72, 80, 73)
			NewTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		end
	end
	local closeBE = Instance.new("BindableEvent")
	local minBE = Instance.new("BindableEvent")
	local isMin = false
	local bt = mf.BackgroundTransparency
	min.MouseButton1Down:Connect(function()
		isMin = not isMin
		if isMin then
			selection.Visible = false
			tabs.Visible = false
			mf.BackgroundTransparency = 1
		else
			selection.Visible = true
			tabs.Visible = true
			mf.BackgroundTransparency = bt
		end
	end)
	close.MouseButton1Down:Connect(function()
		EstrasGUI:Destroy()
	end)
	local s = Instance.new("ObjectValue")
	s.Parent = EstrasGUI
	s.Name = "Selected"

	local selected = nil
	local function callNewTab(name)
		local ret = {
			"ValidEstraFrame";
			EstrasGUI;
		}
		return CVSNewTab(ret,name)
	end
	local ret = {
		"ValidEstraFrame";
		EstrasGUI;
		["NewTab"] = callNewTab;
		["Closing"] = closeBE.Event;
		["Minimizing"] = minBE.Event;
	}
	return ret
end
return module
