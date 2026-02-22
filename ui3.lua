local Library = {}

if getgenv then
	if getgenv().Lib then
		getgenv().Lib:Destroy()
	end
	getgenv().Lib = Library
end

local BlurUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Coolmandfgfgdvcgfg/uilb/refs/heads/main/UIBlurLib"))()
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local newSecureCoreGui = cloneref(game.CoreGui)

-- ── Config ──────────────────────────────────────────────
local ACCENT = Color3.fromRGB(130, 80, 255) -- purple accent
local ACCENT_DIM = Color3.fromRGB(90, 55, 180)
local BG_PRIMARY = Color3.fromRGB(18, 18, 22)
local BG_SECONDARY = Color3.fromRGB(26, 26, 32)
local TEXT_PRIMARY = Color3.fromRGB(230, 230, 240)
local TEXT_DIM = Color3.fromRGB(140, 140, 160)
local BORDER_COLOR = Color3.fromRGB(50, 50, 65)
local CORNER_RADIUS = UDim.new(0, 10)
local CORNER_RADIUS_SM = UDim.new(0, 6)

local Binds = {
	Toggle = Enum.KeyCode.Comma,
}

local Bools = {
	IsCMDBarOpen = false,
}

Library.Connections = {}
Library.Commands = {}

-- ── Helpers ─────────────────────────────────────────────
local function create(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		inst[k] = v
	end
	if children then
		for _, child in ipairs(children) do
			child.Parent = inst
		end
	end
	return inst
end

local function applyStroke(parent, color, thickness, transparency)
	return create("UIStroke", {
		Parent = parent,
		Color = color or BORDER_COLOR,
		Thickness = thickness or 1,
		Transparency = transparency or 0.5,
	})
end

local function applyCorner(parent, radius)
	return create("UICorner", {
		Parent = parent,
		CornerRadius = radius or CORNER_RADIUS,
	})
end

local function applyGradient(parent, c1, c2, rotation)
	return create("UIGradient", {
		Parent = parent,
		Color = ColorSequence.new(c1 or BG_PRIMARY, c2 or BG_SECONDARY),
		Rotation = rotation or 90,
	})
end

local function applyPadding(parent, l, r, t, b)
	return create("UIPadding", {
		Parent = parent,
		PaddingLeft = UDim.new(0, l or 0),
		PaddingRight = UDim.new(0, r or 0),
		PaddingTop = UDim.new(0, t or 0),
		PaddingBottom = UDim.new(0, b or 0),
	})
end

-- ── ScreenGui ───────────────────────────────────────────
local UiLib = create("ScreenGui", {
	Name = "skibidiutils",
	Parent = newSecureCoreGui,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999999,
})

-- ═══════════════════════════════════════════════════════
-- ██  COMMAND BAR
-- ═══════════════════════════════════════════════════════
local CMD_Bar = create("Frame", {
	Name = "CMD_Bar",
	Parent = UiLib,
	BackgroundColor3 = BG_PRIMARY,
	BackgroundTransparency = 0.15,
	AnchorPoint = Vector2.new(0.5, 0.5),
	BorderSizePixel = 0,
	Position = UDim2.new(0.5, 0, 1.4, 0),
	Size = UDim2.new(0, 420, 0, 44),
	ClipsDescendants = true,
})
applyCorner(CMD_Bar, CORNER_RADIUS)
applyStroke(CMD_Bar, ACCENT_DIM, 1.2, 0.6)
applyGradient(CMD_Bar, Color3.fromRGB(22, 22, 30), Color3.fromRGB(16, 16, 20), 0)

local cmdbarBlur = BlurUI.new(CMD_Bar, "Rectangle")
cmdbarBlur.IgnoreGuiInset = false

-- accent line at bottom of cmd bar
create("Frame", {
	Name = "AccentLine",
	Parent = CMD_Bar,
	BackgroundColor3 = ACCENT,
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0.5, 1),
	Position = UDim2.new(0.5, 0, 1, 0),
	Size = UDim2.new(1, 0, 0, 2),
})

-- arrow icon
local InputArrow = create("TextLabel", {
	Name = "InputArrow",
	Parent = CMD_Bar,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 12, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	Size = UDim2.new(0, 20, 0, 20),
	Font = Enum.Font.GothamBold,
	Text = ">",
	TextColor3 = ACCENT,
	TextSize = 18,
	TextTransparency = 0.1,
})

-- command text box
local CmdBox = create("TextBox", {
	Name = "CmdBox",
	Parent = CMD_Bar,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 38, 0, 0),
	Size = UDim2.new(1, -48, 1, 0),
	Font = Enum.Font.GothamMedium,
	PlaceholderText = "",
	PlaceholderColor3 = TEXT_DIM,
	Text = "",
	TextColor3 = TEXT_PRIMARY,
	TextSize = 16,
	TextTransparency = 0,
	TextWrapped = false,
	ClipsDescendants = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
})

-- autocomplete ghost text
local AutoComplete = create("TextLabel", {
	Name = "AutoComplete",
	Parent = CMD_Bar,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 38, 0, 0),
	Size = UDim2.new(1, -48, 1, 0),
	Font = Enum.Font.GothamMedium,
	Text = "",
	TextSize = 16,
	TextColor3 = TEXT_DIM,
	TextTransparency = 0.55,
	TextWrapped = false,
	ClipsDescendants = true,
	TextXAlignment = Enum.TextXAlignment.Left,
})

-- ═══════════════════════════════════════════════════════
-- ██  NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════
local NotifMenu = create("Frame", {
	Name = "NotifMenu",
	Parent = UiLib,
	AnchorPoint = Vector2.new(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(1, -12, 1, -12),
	Size = UDim2.new(0, 300, 0, 500),
})

create("UIListLayout", {
	Parent = NotifMenu,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Bottom,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 8),
})

-- ── Notification Template (NOT parented to the tree) ──
local NotifTemplate = create("Frame", {
	Name = "Notification",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 80),
	ClipsDescendants = true,
})

local NotifCard = create("Frame", {
	Name = "Card",
	Parent = NotifTemplate,
	BackgroundColor3 = BG_PRIMARY,
	BackgroundTransparency = 0.1,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(1.1, 0, 0, 0), -- starts off-screen
	ClipsDescendants = true,
})
applyCorner(NotifCard, CORNER_RADIUS)
applyStroke(NotifCard, BORDER_COLOR, 1, 0.6)
applyGradient(NotifCard, Color3.fromRGB(24, 24, 32), Color3.fromRGB(18, 18, 24), 135)

-- accent bar on left side of card
create("Frame", {
	Name = "AccentBar",
	Parent = NotifCard,
	BackgroundColor3 = ACCENT,
	BackgroundTransparency = 0.2,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 0),
	Size = UDim2.new(0, 3, 1, 0),
})

-- icon
create("ImageLabel", {
	Name = "Icon",
	Parent = NotifCard,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 14, 0, 12),
	Size = UDim2.new(0, 20, 0, 20),
	Image = "rbxassetid://11401835376",
	ImageColor3 = ACCENT,
	ImageTransparency = 0.1,
})

-- title
create("TextLabel", {
	Name = "Title",
	Parent = NotifCard,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 42, 0, 10),
	Size = UDim2.new(1, -54, 0, 18),
	Font = Enum.Font.GothamBold,
	Text = "skibidi hacks",
	TextColor3 = TEXT_PRIMARY,
	TextSize = 13,
	TextTransparency = 0.05,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
})

-- body text
create("TextLabel", {
	Name = "Body",
	Parent = NotifCard,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 42, 0, 30),
	Size = UDim2.new(1, -54, 0, 36),
	Font = Enum.Font.Gotham,
	Text = "",
	TextColor3 = TEXT_DIM,
	TextSize = 12,
	TextTransparency = 0.1,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
})

-- progress bar bg
local ProgressBG = create("Frame", {
	Name = "ProgressBG",
	Parent = NotifCard,
	BackgroundColor3 = Color3.fromRGB(40, 40, 55),
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0, 1),
	Position = UDim2.new(0, 0, 1, 0),
	Size = UDim2.new(1, 0, 0, 3),
})

-- progress bar fill
create("Frame", {
	Name = "Fill",
	Parent = ProgressBG,
	BackgroundColor3 = ACCENT,
	BackgroundTransparency = 0.15,
	BorderSizePixel = 0,
	Size = UDim2.new(0, 0, 1, 0),
})

-- ═══════════════════════════════════════════════════════
-- ██  BELL ANIMATION
-- ═══════════════════════════════════════════════════════
local function ringBell(icon, duration)
	if not icon then return end
	local totalTime = duration or 2
	local startTime = tick()
	local amplitude = 15
	local decayFactor = 0.8
	local swingTime = 0.08

	task.spawn(function()
		while tick() - startTime < totalTime and amplitude > 0.5 do
			TS:Create(icon, TweenInfo.new(swingTime, Enum.EasingStyle.Linear), { Rotation = -amplitude }):Play()
			task.wait(swingTime)
			TS:Create(icon, TweenInfo.new(swingTime, Enum.EasingStyle.Linear), { Rotation = amplitude }):Play()
			task.wait(swingTime)
			amplitude = amplitude * decayFactor
		end
		TS:Create(icon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
	end)
end

-- ═══════════════════════════════════════════════════════
-- ██  DISPLAY NOTIFICATION
-- ═══════════════════════════════════════════════════════
function Library:DisplayNotification(text, del, titleText)
	del = del or 3
	local notif = NotifTemplate:Clone()
	notif.Parent = NotifMenu
	notif.Visible = true

	local card = notif:FindFirstChild("Card")
	if not card then return end

	card.Body.Text = text
	if titleText then
		card.Title.Text = titleText
	end

	local notifBlur = BlurUI.new(card, "Rectangle")
	notifBlur.IgnoreGuiInset = false

	-- slide in
	local slideIn = TS:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0),
	})
	slideIn:Play()

	-- progress bar
	local fill = card.ProgressBG.Fill
	TS:Create(fill, TweenInfo.new(del, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 1, 0),
	}):Play()

	-- icon ring
	ringBell(card.Icon, math.min(del, 1.5))

	-- dismiss
	task.delay(del, function()
		local slideOut = TS:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1.1, 0, 0, 0),
		})
		slideOut:Play()

		task.delay(0.4, function()
			pcall(function() notifBlur:Destroy() end)
			notif:Destroy()
		end)
	end)
end

-- ═══════════════════════════════════════════════════════
-- ██  CMD BAR TOGGLE
-- ═══════════════════════════════════════════════════════
local function ToggleCMDBar()
	Bools.IsCMDBarOpen = not Bools.IsCMDBarOpen
	CmdBox.Text = ""
	AutoComplete.Text = ""

	if not Bools.IsCMDBarOpen then
		TS:Create(CMD_Bar, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(0.5, 0, 1.4, 0),
		}):Play()
	else
		TS:Create(CMD_Bar, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.92, 0),
		}):Play()
		task.wait(0.05)
		CmdBox:CaptureFocus()
		task.spawn(function()
			while Bools.IsCMDBarOpen do
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

-- ═══════════════════════════════════════════════════════
-- ██  AUTOCOMPLETE LOGIC
-- ═══════════════════════════════════════════════════════
local function GetClosestMatch(input, options)
	for name, _ in pairs(options) do
		if name:lower():sub(1, #input) == input:lower() then
			return name:lower()
		end
	end
	return ""
end

local function GetClosestMatchiPairs(input, options)
	for _, option in ipairs(options) do
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
	CmdBox.Text = CmdBox.Text:gsub("%s+", " "):gsub("\t", ""):lower()

	local alignMode = CmdBox.TextFits and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
	CmdBox.TextXAlignment = alignMode
	AutoComplete.TextXAlignment = alignMode

	local text = CmdBox.Text
	local args = text:split(" ")

	if #args == 1 and args[1] ~= "" then
		AutoComplete.Text = GetClosestMatch(args[1], Library.Commands)
	elseif #args >= 2 then
		local command = Library.Commands[args[1]]
		if command and command.ArgTypes then
			local parts = { args[1] }

			for i = 2, #args do
				local arg = args[i] or ""
				if arg == "" then break end

				local match = arg
				if command.ArgTypes[i - 1] == "player" then
					match = GetClosestMatchiPairs(arg, GetPlayerNames())
				else
					match = GetClosestMatchiPairs(arg, { command.ArgTypes[i - 1] })
				end
				table.insert(parts, match ~= "" and match or arg)
			end

			AutoComplete.Text = table.concat(parts, " ")
		else
			AutoComplete.Text = text
		end
	else
		AutoComplete.Text = ""
	end
end

-- ═══════════════════════════════════════════════════════
-- ██  INPUT CONNECTIONS
-- ═══════════════════════════════════════════════════════
local textc = CmdBox:GetPropertyChangedSignal("Text"):Connect(UpdateAutoComplete)

local connect1 = UIS.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.Tab and gp then
		local d = AutoComplete.Text
		task.wait()
		CmdBox.Text = d
		AutoComplete.Text = ""
		CmdBox.CursorPosition = #CmdBox.Text + 1
	end
end)

local connect2 = UIS.InputBegan:Connect(function(input, _)
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

table.insert(Library.Connections, textc)
table.insert(Library.Connections, connect1)
table.insert(Library.Connections, connect2)

-- ═══════════════════════════════════════════════════════
-- ██  PUBLIC API
-- ═══════════════════════════════════════════════════════
function Library:RegisterCommand(name, func, argTypes)
	Library.Commands[name] = { Func = func, ArgTypes = argTypes }
end

function Library:Destroy()
	pcall(function() cmdbarBlur:Destroy() end)
	UiLib:Destroy()
	for _, v in pairs(Library.Connections) do
		if typeof(v) == "RBXScriptConnection" and v.Connected then
			v:Disconnect()
		end
	end
	Library.Connections = {}
	Library.Commands = {}
end

-- ── Default Commands ────────────────────────────────────
Library:RegisterCommand("cmds", function()
	local cmdList = {}
	for name, _ in pairs(Library.Commands) do
		table.insert(cmdList, name)
	end
	table.sort(cmdList)
	Library:DisplayNotification(table.concat(cmdList, ", "), 5, "Commands")
end)

Library:RegisterCommand("destroyui", function()
	Library:Destroy()
end)

-- ── Blur Loop ───────────────────────────────────────────
Library.Connections["BlurLoop"] = RunService.RenderStepped:Connect(function()
	BlurUI.updateAll()
end)

return Library
