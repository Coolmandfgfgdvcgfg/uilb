local Library = {}

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Binds = {
	Toggle = Enum.KeyCode.Comma
}

local Bools = {
	IsCMDBarOpen = false
}

Library.Connections = {}
Library.Commands = {}

local UiLib = Instance.new("ScreenGui")
UiLib.DisplayOrder = 999999
local CMD_Bar = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local InputArrow = Instance.new("ImageLabel")
local CmdBox = Instance.new("TextBox")
local AutoComplete = Instance.new("TextLabel")
local NotifMenu = Instance.new("Frame")
local NotifHolder = Instance.new("Frame")
local AFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local notifImage = Instance.new("ImageLabel")
local UICorner_2 = Instance.new("UICorner")
local Line = Instance.new("Frame")
local LoadBar = Instance.new("Frame")
local Bar = Instance.new("Frame")
local txt = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

UiLib.Parent = game.CoreGui
UiLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UiLib.ResetOnSpawn = false
UiLib.IgnoreGuiInset = true

CMD_Bar.Name = "CMD_Bar"
CMD_Bar.Parent = UiLib
CMD_Bar.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
CMD_Bar.BackgroundTransparency = 0.300
CMD_Bar.AnchorPoint = Vector2.new(0.5,0.5)
CMD_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
CMD_Bar.BorderSizePixel = 0
CMD_Bar.Position = UDim2.new(0.5, 0, 1.4, 0)
CMD_Bar.Size = UDim2.new(0.15, 0, 0.02, 0)
CMD_Bar.SizeConstraint = Enum.SizeConstraint.RelativeXX

UICorner.Parent = CMD_Bar

InputArrow.Name = "InputArrow"
InputArrow.Parent = CMD_Bar
InputArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InputArrow.BackgroundTransparency = 1.000
InputArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
InputArrow.BorderSizePixel = 0
InputArrow.Position = UDim2.new(0.0387596898, 0, 0.285714298, 0)
InputArrow.Size = UDim2.new(0.0581395365, 0, 0.0581395365, 0)
InputArrow.SizeConstraint = Enum.SizeConstraint.RelativeXX
InputArrow.Image = "rbxassetid://8540263699"
InputArrow.ImageTransparency = 0.200

CmdBox.Name = "CmdBox"
CmdBox.Parent = CMD_Bar
CmdBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CmdBox.BackgroundTransparency = 1.000
CmdBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
CmdBox.BorderSizePixel = 0
CmdBox.Position = UDim2.new(0.12, 0,0.171, 0)
CmdBox.Size = UDim2.new(0.835, 0,0.085, 0)
CmdBox.SizeConstraint = Enum.SizeConstraint.RelativeXX
CmdBox.Font = Enum.Font.Highway
CmdBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
CmdBox.Text = "claimbl"
CmdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdBox.TextSize = 22
CmdBox.TextTransparency = 0.200
CmdBox.TextWrapped = false
CmdBox.ClipsDescendants = true
CmdBox.TextScaled = false
CmdBox.TextXAlignment = Enum.TextXAlignment.Left

AutoComplete.Name = "AutoComplete"
AutoComplete.Parent = CMD_Bar
AutoComplete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoComplete.BackgroundTransparency = 1.000
AutoComplete.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoComplete.BorderSizePixel = 0
AutoComplete.Position = UDim2.new(0.12, 0,0.171, 0)
AutoComplete.Size = UDim2.new(0.835, 0,0.085, 0)
AutoComplete.SizeConstraint = Enum.SizeConstraint.RelativeXX
AutoComplete.Font = Enum.Font.Highway
AutoComplete.Text = "claimblock"
AutoComplete.TextScaled = false
AutoComplete.ClipsDescendants = true
AutoComplete.TextSize = 22
AutoComplete.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoComplete.TextTransparency = 0.500
AutoComplete.TextXAlignment = Enum.TextXAlignment.Left

NotifMenu.Name = "NotifMenu"
NotifMenu.Parent = UiLib
NotifMenu.AnchorPoint = Vector2.new(1, 0)
NotifMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotifMenu.BackgroundTransparency = 1.000
NotifMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
NotifMenu.BorderSizePixel = 0
NotifMenu.Position = UDim2.new(0.995000005, 0, 0.00411522621, 0)
NotifMenu.Size = UDim2.new(0.344650209, 0, 0.99000001, 0)
NotifMenu.SizeConstraint = Enum.SizeConstraint.RelativeYY

NotifHolder.Name = "NotifHolder"
NotifHolder.Parent = NotifMenu
NotifHolder.Visible = false
NotifHolder.AnchorPoint = Vector2.new(1, 0)
NotifHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotifHolder.BackgroundTransparency = 1.000
NotifHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
NotifHolder.BorderSizePixel = 0
NotifHolder.Position = UDim2.new(0, 0, 0.878600836, 0)
NotifHolder.Size = UDim2.new(1, 0, 0.121586226, 0)

AFrame.Name = "AFrame"
AFrame.Parent = NotifHolder
AFrame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
AFrame.BackgroundTransparency = 0.300
AFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
AFrame.BorderSizePixel = 0
AFrame.Size = UDim2.new(1, 0, 1, 0)

title.Name = "title"
title.Parent = AFrame
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0.200000003, 0, 0.051282052, 0)
title.Size = UDim2.new(0.597014904, 0, 0.213675216, 0)
title.Font = Enum.Font.Highway
title.Text = "skibidi hacks"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextTransparency = 0.200
title.TextWrapped = true

notifImage.Name = "notifImage"
notifImage.Parent = AFrame
notifImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notifImage.BackgroundTransparency = 1.000
notifImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
notifImage.BorderSizePixel = 0
notifImage.Position = UDim2.new(0.0238805972, 0, 0.05982906, 0)
notifImage.Size = UDim2.new(0.0716417879, 0, 0.205128208, 0)
notifImage.Image = "rbxassetid://11401835376"
notifImage.ImageTransparency = 0.200

UICorner_2.Parent = AFrame

Line.Name = "Line"
Line.Parent = AFrame
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.930
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0.316239327, 0)
Line.Size = UDim2.new(1, 0, -0.00854700897, 0)

LoadBar.Name = "LoadBar"
LoadBar.Parent = AFrame
LoadBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadBar.BackgroundTransparency = 0.930
LoadBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
LoadBar.BorderSizePixel = 0
LoadBar.Position = UDim2.new(0, 0, 0.931623936, 0)
LoadBar.Size = UDim2.new(1, 0, -0.145299152, 0)

Bar.Name = "Bar"
Bar.Parent = LoadBar
Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar.Position = UDim2.new(0,0,1,0)
Bar.BorderSizePixel = 0
Bar.Size = UDim2.new(0, 0, -1, 0)

txt.Name = "txt"
txt.Parent = AFrame
txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
txt.BackgroundTransparency = 1.000
txt.BorderColor3 = Color3.fromRGB(0, 0, 0)
txt.BorderSizePixel = 0
txt.Position = UDim2.new(0.128358215, 0, 0.358974367, 0)
txt.Size = UDim2.new(0.74328357, 0, 0.350427359, 0)
txt.Font = Enum.Font.Highway
txt.Text = "Successfully loaded!\nPress ' to get started"
txt.TextColor3 = Color3.fromRGB(255, 255, 255)
txt.TextScaled = true
txt.TextSize = 20.000
txt.TextTransparency = 0.200
txt.TextWrapped = true

UIListLayout.Parent = NotifMenu
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

function Library:DisplayNotification(text, del)
	local notification = NotifHolder:Clone()

	notification.Parent = NotifMenu 
	notification.Visible = true
	notification.AFrame.txt.Text = text
	notification.AFrame.Position = UDim2.new(1, 0, 0, 0) 

	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TS:Create(notification.AFrame, tweenInfo, { Position = UDim2.new(0, 0, 0, 0) })

	tween:Play()
	local tweenInfo2 = TweenInfo.new(del, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local tween2 = TS:Create(notification.AFrame.LoadBar.Bar, tweenInfo2, { Size = UDim2.new(1, 0,-1, 0) })

	tween2:Play()
	task.delay(del,function()
		local tween = TS:Create(notification.AFrame, tweenInfo, { Position = UDim2.new(1, 0, 0, 0) })

		tween:Play()
		game:GetService("Debris"):AddItem(notification, 0.5)
	end)
end

local function ToggleCMDBar()
	Bools.IsCMDBarOpen = not Bools.IsCMDBarOpen
	CmdBox.Text = ""
	AutoComplete.Text = ""
	if Bools.IsCMDBarOpen == false then
		TS:Create(CMD_Bar, TweenInfo.new(0.4,Enum.EasingStyle.Circular,Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.4, 0)}):Play()
	else
		TS:Create(CMD_Bar, TweenInfo.new(0.4,Enum.EasingStyle.Circular,Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.9, 0)}):Play()
		task.wait()
		CmdBox:CaptureFocus()
		task.spawn(function()
			while Bools.IsCMDBarOpen == true do
				if UIS:GetFocusedTextBox() ~= CmdBox then
					ToggleCMDBar()
					break
				end
				task.wait()
			end
		end)
	end
end

UIS.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Binds.Toggle and not gp then
		ToggleCMDBar()
	end
end)

local function GetClosestMatch(input, options)
	for i, option in pairs(options) do
		if i:lower():sub(1, #input) == input:lower() then
			return i:lower()
		end
	end
	return ""
end

local function GetClosestMatchiPairs(input, options)
	for i, option in ipairs(options) do

		if option:lower():sub(1, #input) == input:lower() then
			return option:lower()
		end
	end
	return ""
end

local function GetPlayerNames()
	local names = {}
	for _, player in ipairs(Players:GetPlayers()) do
		table.insert(names, player.Name)
	end
	return names
end

local function UpdateAutoComplete()
	CmdBox.Text = CmdBox.Text:gsub("%s+", " "):gsub("\t", "")
	CmdBox.Text = CmdBox.Text:lower()
	AutoComplete.Text = AutoComplete.Text:lower()

	if not CmdBox.TextFits then
		CmdBox.TextXAlignment = Enum.TextXAlignment.Right
		AutoComplete.TextXAlignment = Enum.TextXAlignment.Right
	else
		CmdBox.TextXAlignment = Enum.TextXAlignment.Left
		AutoComplete.TextXAlignment = Enum.TextXAlignment.Left
	end

	local text = CmdBox.Text
	local args = text:split(" ")

	if #args == 1 and args[1] ~= "" then
		local commandMatch = GetClosestMatch(args[1], Library.Commands)
		AutoComplete.Text = commandMatch
	elseif #args >= 2 then
		local command = Library.Commands[args[1]]
		if command and command.ArgTypes then
			local autoCompleteText = {args[1]} 

			for i = 2, #args do
				local arg = args[i] or ""
				if arg == "" then
					break
				end

				local match = arg
				if command.ArgTypes[i-1] == "player" then
					match = GetClosestMatchiPairs(arg, GetPlayerNames())
				else
					match = GetClosestMatchiPairs(arg, {command.ArgTypes[i-1]})
				end

				table.insert(autoCompleteText, match ~= "" and match or arg)
			end

			AutoComplete.Text = table.concat(autoCompleteText, " ") 
		else
			AutoComplete.Text = text
		end
	else
		AutoComplete.Text = ""
	end
end

local textc
textc = CmdBox:GetPropertyChangedSignal("Text"):Connect(UpdateAutoComplete)

local connect1
connect1 = UIS.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.Tab and gp then
		local d = AutoComplete.Text
		task.wait()
		CmdBox.Text = d
		AutoComplete.Text = ""
		CmdBox.CursorPosition = #CmdBox.Text + 1
	end
end)

local connect2
connect2 = UIS.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.Return then
		local args = CmdBox.Text:split(" ")
		local command = Library.Commands[args[1]]
		if command then
			table.remove(args, 1)
			command.Func(unpack(args))
		end
		CmdBox.Text = ""
		AutoComplete.Text = ""
	end
end)

table.insert(textc, Library.Connections)
table.insert(connect1, Library.Connections)
table.insert(connect2, Library.Connections)

function Library:RegisterCommand(name, func, argTypes)
	Library.Commands[name] = {Func = func, ArgTypes = argTypes}
end

function Library:Destroy()
	UiLib:Destroy()
	for i, v in ipairs(Library.Connections) do
		if v then
			v:Disconnect()
		end
	end
end

Library:RegisterCommand("cmds", function()

end)

Library:RegisterCommand("destroyui", function()
	Library:Destroy()
end)

return Library
