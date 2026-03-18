local Library = {}

-- ══════════════════════════════════════
--  THEME – #00D4FF  (Sky Cyan)
--  ACCENT  = 0, 212, 255
--  BG_MAIN = 15, 15, 20   (tối như ảnh)
-- ══════════════════════════════════════
local ACCENT     = Color3.fromRGB(0,   212, 255)
local ACCENT2    = Color3.fromRGB(0,   160, 200)
local BG_MAIN    = Color3.fromRGB(15,   15,  20)
local BG_PANEL   = Color3.fromRGB(20,   20,  28)
local BG_ITEM    = Color3.fromRGB(26,   26,  36)
local BG_ITEM2   = Color3.fromRGB(32,   32,  44)
local TEXT_W     = Color3.fromRGB(240, 240, 250)
local TEXT_GRAY  = Color3.fromRGB(140, 140, 160)
local TOGGLE_OFF = Color3.fromRGB(55,   55,  70)

function Library:TweenInstance(Instance, Time, OldValue, NewValue)
	local rz_Tween = game:GetService("TweenService"):Create(Instance, TweenInfo.new(Time, Enum.EasingStyle.Quad), { [OldValue] = NewValue })
	rz_Tween:Play()
	return rz_Tween
end

function Library:UpdateContent(Content, Title, Object)
	if Content.Text ~= "" then
		Title.Position = UDim2.new(0, 12, 0, 7)
		Title.Size = UDim2.new(1, -60, 0, 16)
		local MaxY = math.max(Content.TextBounds.Y + 15, 45)
		Object.Size = UDim2.new(1, 0, 0, MaxY)
	end
end

function Library:UpdateScrolling(Scroll, List)
	List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 15)
	end)
end

function Library:MakeConfig(Config, NewConfig)
	for i, v in next, Config do
		if not NewConfig[i] then NewConfig[i] = v end
	end
	return NewConfig
end

function Library:MakeDraggable(topbarobject, object)
	local Dragging, DragInput, DragStart, StartPosition
	local function UpdatePos(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(object, TweenInfo.new(0.15), { Position = pos }):Play()
	end
	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true; DragStart = input.Position; StartPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then Dragging = false end
			end)
		end
	end)
	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == DragInput and Dragging then UpdatePos(input) end
	end)
end

function Library:NewWindow(ConfigWindow)
	ConfigWindow = self:MakeConfig({ Title = "Hub", Description = "Script Hub" }, ConfigWindow or {})

	-- ── ScreenGui ──
	local TeddyUI_Premium    = Instance.new("ScreenGui")
	local DropShadowHolder   = Instance.new("Frame")
	local DropShadow         = Instance.new("ImageLabel")
	local Main               = Instance.new("Frame")
	local MainCorner         = Instance.new("UICorner")
	local MainStroke         = Instance.new("UIStroke")

	-- ── Topbar ──
	local Top                = Instance.new("Frame")
	local TopLine            = Instance.new("Frame")
	local LogoHolder         = Instance.new("Frame")
	local LogoCorner         = Instance.new("UICorner")
	local LogoHub            = Instance.new("ImageLabel")
	local NameHub            = Instance.new("TextLabel")
	local Desc               = Instance.new("TextLabel")
	local BtnFrame           = Instance.new("Frame")
	local BtnLayout          = Instance.new("UIListLayout")

	local Minize             = Instance.new("TextButton")
	local MinizeIcon         = Instance.new("ImageLabel")
	local Large              = Instance.new("TextButton")
	local LargeIcon          = Instance.new("ImageLabel")
	local Close              = Instance.new("TextButton")
	local CloseIcon          = Instance.new("ImageLabel")

	-- ── Tab sidebar ──
	local TabFrame           = Instance.new("Frame")
	local TabLine            = Instance.new("Frame")
	local SearchFrame        = Instance.new("Frame")
	local SearchCorner       = Instance.new("UICorner")
	local SearchStroke       = Instance.new("UIStroke")
	local IconSearch         = Instance.new("ImageLabel")
	local SearchBox          = Instance.new("TextBox")
	local ScrollingTab       = Instance.new("ScrollingFrame")
	local TabPad             = Instance.new("UIPadding")
	local TabList            = Instance.new("UIListLayout")

	-- ── Content area ──
	local LayoutFrame        = Instance.new("Frame")
	local RealLayout         = Instance.new("Frame")
	local LayoutList         = Instance.new("Folder")
	local UIPageLayout       = Instance.new("UIPageLayout")
	local LayoutName         = Instance.new("Frame")
	local TabNameLabel       = Instance.new("TextLabel")
	local TabNameLine        = Instance.new("Frame")
	local TabNameGrad        = Instance.new("UIGradient")
	local DropdownZone       = Instance.new("Frame")

	-- ScreenGui
	TeddyUI_Premium.Name = "TeddyUI_Premium"
	TeddyUI_Premium.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	TeddyUI_Premium.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TeddyUI_Premium.ResetOnSpawn = false

	-- Shadow holder
	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = TeddyUI_Premium
	DropShadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadowHolder.BackgroundTransparency = 1
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadowHolder.Size = UDim2.new(0, 570, 0, 360)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 60, 1, 60)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 212, 255)
	DropShadow.ImageTransparency = 0.82
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	-- Main frame
	Main.Name = "Main"
	Main.Parent = DropShadowHolder
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 570, 0, 360)
	Main.BackgroundColor3 = BG_MAIN
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true

	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = Main

	MainStroke.Color = ACCENT
	MainStroke.Thickness = 1.2
	MainStroke.Transparency = 0.5
	MainStroke.Parent = Main

	-- Topbar
	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = BG_PANEL
	Top.BackgroundTransparency = 0
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 52)

	TopLine.Name = "TopLine"
	TopLine.Parent = Top
	TopLine.BackgroundColor3 = ACCENT
	TopLine.BackgroundTransparency = 0.4
	TopLine.BorderSizePixel = 0
	TopLine.Position = UDim2.new(0, 0, 1, -1)
	TopLine.Size = UDim2.new(1, 0, 0, 1)

	-- Logo circle
	LogoHolder.Parent = Top
	LogoHolder.BackgroundColor3 = BG_ITEM2
	LogoHolder.BorderSizePixel = 0
	LogoHolder.Position = UDim2.new(0, 10, 0, 8)
	LogoHolder.Size = UDim2.new(0, 36, 0, 36)
	LogoCorner.CornerRadius = UDim.new(0, 6)
	LogoCorner.Parent = LogoHolder

	local LogoStroke = Instance.new("UIStroke", LogoHolder)
	LogoStroke.Color = ACCENT
	LogoStroke.Thickness = 1
	LogoStroke.Transparency = 0.4

	LogoHub.Name = "LogoHub"
	LogoHub.Parent = LogoHolder
	LogoHub.BackgroundTransparency = 1
	LogoHub.BorderSizePixel = 0
	LogoHub.Position = UDim2.new(0, 4, 0, 4)
	LogoHub.Size = UDim2.new(1, -8, 1, -8)
	LogoHub.Image = "rbxassetid://80900795508277"
	LogoHub.ScaleType = Enum.ScaleType.Fit

	NameHub.Name = "NameHub"
	NameHub.Parent = Top
	NameHub.BackgroundTransparency = 1
	NameHub.BorderSizePixel = 0
	NameHub.Position = UDim2.new(0, 54, 0, 9)
	NameHub.Size = UDim2.new(0, 400, 0, 20)
	NameHub.Font = Enum.Font.GothamBold
	NameHub.Text = ConfigWindow.Title
	NameHub.TextColor3 = TEXT_W
	NameHub.TextSize = 14
	NameHub.TextXAlignment = Enum.TextXAlignment.Left

	Desc.Name = "Desc"
	Desc.Parent = Top
	Desc.BackgroundTransparency = 1
	Desc.BorderSizePixel = 0
	Desc.Position = UDim2.new(0, 54, 0, 28)
	Desc.Size = UDim2.new(0, 400, 0, 16)
	Desc.Font = Enum.Font.Gotham
	Desc.Text = ConfigWindow.Description
	Desc.TextColor3 = TEXT_GRAY
	Desc.TextSize = 11
	Desc.TextXAlignment = Enum.TextXAlignment.Left

	-- Buttons (minimize, maximize, close)
	BtnFrame.Parent = Top
	BtnFrame.BackgroundTransparency = 1
	BtnFrame.BorderSizePixel = 0
	BtnFrame.Position = UDim2.new(1, -108, 0, 0)
	BtnFrame.Size = UDim2.new(0, 108, 1, 0)
	BtnLayout.Parent = BtnFrame
	BtnLayout.FillDirection = Enum.FillDirection.Horizontal
	BtnLayout.SortOrder = Enum.SortOrder.LayoutOrder
	BtnLayout.Padding = UDim.new(0, 2)
	BtnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	Instance.new("UIPadding", BtnFrame).PaddingTop = UDim.new(0, 12)

	local function MakeTopBtn(icon, rx, ry, parent)
		local btn = Instance.new("TextButton", parent)
		btn.BackgroundTransparency = 1
		btn.BorderSizePixel = 0
		btn.Size = UDim2.new(0, 30, 0, 30)
		btn.Text = ""
		local img = Instance.new("ImageLabel", btn)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.BackgroundTransparency = 1
		img.Position = UDim2.new(0.5, 0, 0.5, 0)
		img.Size = UDim2.new(0, 16, 0, 16)
		img.Image = icon
		img.ImageRectOffset = Vector2.new(rx, ry)
		img.ImageRectSize = Vector2.new(96, 96)
		img.ImageColor3 = TEXT_GRAY
		btn.MouseEnter:Connect(function() img.ImageColor3 = TEXT_W end)
		btn.MouseLeave:Connect(function() img.ImageColor3 = TEXT_GRAY end)
		return btn, img
	end

	Minize, MinizeIcon = MakeTopBtn("rbxassetid://136452605242985", 288, 672, BtnFrame)
	Large,  LargeIcon  = MakeTopBtn("rbxassetid://136452605242985", 580, 194, BtnFrame)
	Close,  CloseIcon  = MakeTopBtn("rbxassetid://105957381820378", 480,   0, BtnFrame)
	CloseIcon.ImageColor3 = Color3.fromRGB(255, 80, 80)

	Close.MouseButton1Down:Connect(function()
		DropdownZone.Visible = true
		local overlay = Instance.new("Frame", DropdownZone)
		overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
		overlay.BackgroundTransparency = 0.4
		overlay.BorderSizePixel = 0
		overlay.Size = UDim2.new(1,0,1,0)

		local dialog = Instance.new("Frame", DropdownZone)
		dialog.AnchorPoint = Vector2.new(0.5, 0.5)
		dialog.BackgroundColor3 = BG_PANEL
		dialog.BorderSizePixel = 0
		dialog.Position = UDim2.new(0.5,0,0.5,0)
		dialog.Size = UDim2.new(0, 320, 0, 120)
		local dc = Instance.new("UICorner", dialog); dc.CornerRadius = UDim.new(0,8)
		local ds = Instance.new("UIStroke", dialog); ds.Color = ACCENT; ds.Thickness = 1; ds.Transparency = 0.4

		local dlabel = Instance.new("TextLabel", dialog)
		dlabel.BackgroundTransparency = 1
		dlabel.Position = UDim2.new(0,0,0,14)
		dlabel.Size = UDim2.new(1,0,0,30)
		dlabel.Font = Enum.Font.GothamBold
		dlabel.Text = "Close the hub?"
		dlabel.TextColor3 = TEXT_W
		dlabel.TextSize = 16

		local function MakeDialogBtn(txt, col, xpos)
			local b = Instance.new("TextButton", dialog)
			b.AnchorPoint = Vector2.new(0.5, 1)
			b.BackgroundColor3 = col
			b.BorderSizePixel = 0
			b.Position = UDim2.new(xpos, 0, 1, -16)
			b.Size = UDim2.new(0, 120, 0, 36)
			b.Font = Enum.Font.GothamBold
			b.Text = txt
			b.TextColor3 = TEXT_W
			b.TextSize = 13
			local bc = Instance.new("UICorner", b); bc.CornerRadius = UDim.new(0,6)
			return b
		end
		local btnYes = MakeDialogBtn("Yes", Color3.fromRGB(200,50,50), 0.3)
		local btnNo  = MakeDialogBtn("No",  BG_ITEM2, 0.7)
		btnYes.MouseButton1Down:Connect(function() TeddyUI_Premium:Destroy() end)
		btnNo.MouseButton1Down:Connect(function()
			dialog:Destroy(); overlay:Destroy()
			DropdownZone.Visible = false
		end)
	end)

	-- Tab sidebar
	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Main
	TabFrame.BackgroundColor3 = BG_PANEL
	TabFrame.BackgroundTransparency = 0
	TabFrame.BorderSizePixel = 0
	TabFrame.Position = UDim2.new(0, 0, 0, 52)
	TabFrame.Size = UDim2.new(0, 148, 1, -52)

	TabLine.Name = "TabLine"
	TabLine.Parent = TabFrame
	TabLine.BackgroundColor3 = ACCENT
	TabLine.BackgroundTransparency = 0.5
	TabLine.BorderSizePixel = 0
	TabLine.Position = UDim2.new(1, -1, 0, 0)
	TabLine.Size = UDim2.new(0, 1, 1, 0)

	-- Search box
	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = TabFrame
	SearchFrame.BackgroundColor3 = BG_ITEM
	SearchFrame.BackgroundTransparency = 0
	SearchFrame.BorderSizePixel = 0
	SearchFrame.Position = UDim2.new(0, 8, 0, 10)
	SearchFrame.Size = UDim2.new(1, -16, 0, 28)
	SearchCorner.CornerRadius = UDim.new(0, 5)
	SearchCorner.Parent = SearchFrame
	SearchStroke.Color = ACCENT
	SearchStroke.Thickness = 0.8
	SearchStroke.Transparency = 0.7
	SearchStroke.Parent = SearchFrame

	IconSearch.Parent = SearchFrame
	IconSearch.AnchorPoint = Vector2.new(0, 0.5)
	IconSearch.BackgroundTransparency = 1
	IconSearch.Position = UDim2.new(0, 7, 0.5, 0)
	IconSearch.Size = UDim2.new(0, 13, 0, 13)
	IconSearch.Image = "rbxassetid://71309835376233"
	IconSearch.ImageColor3 = TEXT_GRAY

	SearchBox.Parent = SearchFrame
	SearchBox.BackgroundTransparency = 1
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0, 26, 0, 0)
	SearchBox.Size = UDim2.new(1, -30, 1, 0)
	SearchBox.Font = Enum.Font.Gotham
	SearchBox.PlaceholderText = "Search section or..."
	SearchBox.PlaceholderColor3 = TEXT_GRAY
	SearchBox.Text = ""
	SearchBox.TextColor3 = TEXT_W
	SearchBox.TextSize = 11
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left
	SearchBox.ClearTextOnFocus = false

	ScrollingTab.Name = "ScrollingTab"
	ScrollingTab.Parent = TabFrame
	ScrollingTab.BackgroundTransparency = 1
	ScrollingTab.BorderSizePixel = 0
	ScrollingTab.Position = UDim2.new(0, 0, 0, 48)
	ScrollingTab.Selectable = false
	ScrollingTab.Size = UDim2.new(1, 0, 1, -48)
	ScrollingTab.ScrollBarThickness = 0
	self:UpdateScrolling(ScrollingTab, TabList)

	TabPad.Parent = ScrollingTab
	TabPad.PaddingTop = UDim.new(0, 6)
	TabPad.PaddingLeft = UDim.new(0, 6)
	TabPad.PaddingRight = UDim.new(0, 6)
	TabPad.PaddingBottom = UDim.new(0, 6)

	TabList.Parent = ScrollingTab
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Padding = UDim.new(0, 3)

	-- Content
	LayoutFrame.Name = "LayoutFrame"
	LayoutFrame.Parent = Main
	LayoutFrame.BackgroundTransparency = 1
	LayoutFrame.BorderSizePixel = 0
	LayoutFrame.Position = UDim2.new(0, 148, 0, 52)
	LayoutFrame.Size = UDim2.new(1, -148, 1, -52)
	LayoutFrame.ClipsDescendants = true

	RealLayout.Name = "RealLayout"
	RealLayout.Parent = LayoutFrame
	RealLayout.BackgroundTransparency = 1
	RealLayout.BorderSizePixel = 0
	RealLayout.Position = UDim2.new(0, 0, 0, 36)
	RealLayout.Size = UDim2.new(1, 0, 1, -36)

	LayoutList.Name = "Layout List"
	LayoutList.Parent = RealLayout

	-- Tab name bar
	LayoutName.Name = "LayoutName"
	LayoutName.Parent = LayoutFrame
	LayoutName.BackgroundTransparency = 1
	LayoutName.BorderSizePixel = 0
	LayoutName.Size = UDim2.new(1, 0, 0, 36)

	TabNameLabel.Parent = LayoutName
	TabNameLabel.BackgroundTransparency = 1
	TabNameLabel.BorderSizePixel = 0
	TabNameLabel.Position = UDim2.new(0, 14, 0, 0)
	TabNameLabel.Size = UDim2.new(1, -14, 0, 30)
	TabNameLabel.Font = Enum.Font.GothamBold
	TabNameLabel.Text = ""
	TabNameLabel.TextColor3 = TEXT_W
	TabNameLabel.TextSize = 13
	TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

	TabNameLine.Parent = LayoutName
	TabNameLine.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabNameLine.BorderSizePixel = 0
	TabNameLine.Position = UDim2.new(0, 0, 1, -1)
	TabNameLine.Size = UDim2.new(1, 0, 0, 1)
	TabNameGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, BG_PANEL),
		ColorSequenceKeypoint.new(0.5, ACCENT),
		ColorSequenceKeypoint.new(1, BG_PANEL),
	}
	TabNameGrad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.7),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(1, 0.7),
	}
	TabNameGrad.Parent = TabNameLine

	-- Dropdown zone (overlay)
	DropdownZone.Name = "DropdownZone"
	DropdownZone.Parent = Main
	DropdownZone.BackgroundTransparency = 1
	DropdownZone.BorderSizePixel = 0
	DropdownZone.Size = UDim2.new(1,0,1,0)
	DropdownZone.Visible = false
	DropdownZone.ZIndex = 10

	-- Search filter
	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local q = SearchBox.Text:lower()
		for _, Layout in next, LayoutList:GetChildren() do
			if Layout:IsA("ScrollingFrame") then
				for _, Section in next, Layout:GetChildren() do
					if Section.Name == "Section" then
						local sl = Section:FindFirstChild("SectionList")
						if sl then
							for _, el in next, sl:GetChildren() do
								if el:IsA("Frame") and el:FindFirstChild("Title") then
									el.Visible = el.Title.Text:lower():find(q) ~= nil
								end
							end
						end
					end
				end
			end
		end
	end)

	UIPageLayout.Parent = LayoutList
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
	UIPageLayout.TweenTime = 0.25

	self:MakeDraggable(Top, DropShadowHolder)

	-- Toggle button (icon ngoài)
	local ToggleGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
	ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ToggleGui.ResetOnSpawn = false

	local ToggleBtn = Instance.new("ImageButton", ToggleGui)
	ToggleBtn.BackgroundColor3 = BG_PANEL
	ToggleBtn.BorderSizePixel = 0
	ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
	ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
	ToggleBtn.Image = "rbxassetid://80900795508277"
	local tbc = Instance.new("UICorner", ToggleBtn); tbc.CornerRadius = UDim.new(1,0)
	local tbs = Instance.new("UIStroke", ToggleBtn); tbs.Color = ACCENT; tbs.Thickness = 1.5; tbs.Transparency = 0.3
	self:MakeDraggable(ToggleBtn, ToggleBtn)
	ToggleBtn.MouseButton1Click:Connect(function()
		TeddyUI_Premium.Enabled = not TeddyUI_Premium.Enabled
	end)
	Minize.MouseButton1Click:Connect(function()
		TeddyUI_Premium.Enabled = false
	end)

	-- ── Tab builder ──
	local AllLayouts = 0
	local Tab = {}

	function Tab:T(t, iconid)
		-- Tab button
		local TabBtn = Instance.new("TextButton", ScrollingTab)
		TabBtn.Name = "TabBtn"
		TabBtn.BackgroundColor3 = BG_ITEM
		TabBtn.BackgroundTransparency = 1
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 30)
		TabBtn.Text = ""
		TabBtn.AutoButtonColor = false
		local tbc2 = Instance.new("UICorner", TabBtn); tbc2.CornerRadius = UDim.new(0,6)

		-- Active indicator bar
		local ActiveBar = Instance.new("Frame", TabBtn)
		ActiveBar.BackgroundColor3 = ACCENT
		ActiveBar.BorderSizePixel = 0
		ActiveBar.Position = UDim2.new(0, 0, 0, 6)
		ActiveBar.Size = UDim2.new(0, 3, 0, 18)
		ActiveBar.Visible = false
		local abc = Instance.new("UICorner", ActiveBar); abc.CornerRadius = UDim.new(1,0)

		-- Icon
		local TabIcon = Instance.new("ImageLabel", TabBtn)
		TabIcon.BackgroundTransparency = 1
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.Position = UDim2.new(0, 10, 0.5, 0)
		TabIcon.Size = UDim2.new(0, 14, 0, 14)
		TabIcon.ImageColor3 = TEXT_GRAY
		local ir = Instance.new("UICorner", TabIcon); ir.CornerRadius = UDim.new(0,3)

		local namePosX = 10
		if iconid and tostring(iconid) ~= "" then
			TabIcon.Image = iconid
			TabIcon.Visible = true
			namePosX = 30
		else
			TabIcon.Visible = false
		end

		-- Label
		local NameTab = Instance.new("TextLabel", TabBtn)
		NameTab.Name = "NameTab"
		NameTab.BackgroundTransparency = 1
		NameTab.BorderSizePixel = 0
		NameTab.Position = UDim2.new(0, namePosX, 0, 0)
		NameTab.Size = UDim2.new(1, -namePosX-4, 1, 0)
		NameTab.Font = Enum.Font.Gotham
		NameTab.Text = t
		NameTab.TextColor3 = TEXT_GRAY
		NameTab.TextSize = 12
		NameTab.TextXAlignment = Enum.TextXAlignment.Left
		NameTab.TextTransparency = 0.3

		-- Scroll layout
		local Layout = Instance.new("ScrollingFrame", LayoutList)
		Layout.BackgroundTransparency = 1
		Layout.BorderSizePixel = 0
		Layout.Selectable = false
		Layout.Size = UDim2.new(1, 0, 1, 0)
		Layout.CanvasSize = UDim2.new(0,0,1,0)
		Layout.ScrollBarThickness = 2
		Layout.ScrollBarImageColor3 = ACCENT
		Layout.LayoutOrder = AllLayouts

		local lpad = Instance.new("UIPadding", Layout)
		lpad.PaddingBottom = UDim.new(0,8)
		lpad.PaddingLeft = UDim.new(0,10)
		lpad.PaddingRight = UDim.new(0,8)

		local llist = Instance.new("UIListLayout", Layout)
		llist.SortOrder = Enum.SortOrder.LayoutOrder
		llist.Padding = UDim.new(0,8)
		Library:UpdateScrolling(Layout, llist)

		-- First tab active
		if AllLayouts == 0 then
			TabBtn.BackgroundTransparency = 0.85
			NameTab.TextColor3 = TEXT_W
			NameTab.TextTransparency = 0
			NameTab.Font = Enum.Font.GothamBold
			TabIcon.ImageColor3 = ACCENT
			ActiveBar.Visible = true
			UIPageLayout:JumpToIndex(0)
			TabNameLabel.Text = t
		end

		TabBtn.MouseButton1Click:Connect(function()
			TabNameLabel.Text = t
			-- Reset all
			for _, v in next, ScrollingTab:GetChildren() do
				if v:IsA("TextButton") and v.Name == "TabBtn" then
					Library:TweenInstance(v, 0.2, "BackgroundTransparency", 1)
					local nl = v:FindFirstChild("NameTab")
					if nl then
						Library:TweenInstance(nl, 0.2, "TextColor3", TEXT_GRAY)
						nl.Font = Enum.Font.Gotham
						nl.TextTransparency = 0.3
					end
					local ab = v:FindFirstChild("Frame") -- ActiveBar
					if ab then ab.Visible = false end
					local ti = v:FindFirstChild("ImageLabel")
					if ti then Library:TweenInstance(ti, 0.2, "ImageColor3", TEXT_GRAY) end
				end
			end
			-- Activate this
			Library:TweenInstance(TabBtn, 0.2, "BackgroundTransparency", 0.85)
			Library:TweenInstance(NameTab, 0.2, "TextColor3", TEXT_W)
			NameTab.Font = Enum.Font.GothamBold
			NameTab.TextTransparency = 0
			Library:TweenInstance(TabIcon, 0.2, "ImageColor3", ACCENT)
			ActiveBar.Visible = true
			UIPageLayout:JumpToIndex(Layout.LayoutOrder)
		end)

		AllLayouts = AllLayouts + 1

		-- ── Section builder ──
		local TabFunc = {}

		function TabFunc:AddSection(name)
			local Section = Instance.new("Frame", Layout)
			Section.Name = "Section"
			Section.BackgroundColor3 = BG_ITEM
			Section.BackgroundTransparency = 0.3
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 50)
			local sc = Instance.new("UICorner", Section); sc.CornerRadius = UDim.new(0,6)
			local ss = Instance.new("UIStroke", Section)
			ss.Color = ACCENT; ss.Thickness = 0.8; ss.Transparency = 0.75

			-- Section header
			local SectHead = Instance.new("Frame", Section)
			SectHead.Name = "SectHead"
			SectHead.BackgroundTransparency = 1
			SectHead.BorderSizePixel = 0
			SectHead.Size = UDim2.new(1,0,0,28)

			local SectTitle = Instance.new("TextLabel", SectHead)
			SectTitle.BackgroundTransparency = 1
			SectTitle.BorderSizePixel = 0
			SectTitle.Position = UDim2.new(0,10,0,0)
			SectTitle.Size = UDim2.new(1,-10,1,0)
			SectTitle.Font = Enum.Font.GothamBold
			SectTitle.Text = name
			SectTitle.TextColor3 = TEXT_W
			SectTitle.TextSize = 13
			SectTitle.TextXAlignment = Enum.TextXAlignment.Left

			local SectLine = Instance.new("Frame", SectHead)
			SectLine.BackgroundColor3 = Color3.new(1,1,1)
			SectLine.BorderSizePixel = 0
			SectLine.Position = UDim2.new(0,0,1,-1)
			SectLine.Size = UDim2.new(1,0,0,1)
			local slg = Instance.new("UIGradient", SectLine)
			slg.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, BG_ITEM),
				ColorSequenceKeypoint.new(0.5, ACCENT),
				ColorSequenceKeypoint.new(1, BG_ITEM),
			}
			slg.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0,0.8),
				NumberSequenceKeypoint.new(0.5,0.1),
				NumberSequenceKeypoint.new(1,0.8),
			}

			-- Items list
			local SectionList = Instance.new("Frame", Section)
			SectionList.Name = "SectionList"
			SectionList.BackgroundTransparency = 1
			SectionList.BorderSizePixel = 0
			SectionList.Position = UDim2.new(0,0,0,30)
			SectionList.Size = UDim2.new(1,0,1,-30)

			local slpad = Instance.new("UIPadding", SectionList)
			slpad.PaddingBottom = UDim.new(0,6)
			slpad.PaddingLeft = UDim.new(0,6)
			slpad.PaddingRight = UDim.new(0,6)
			slpad.PaddingTop = UDim.new(0,4)

			local sllist = Instance.new("UIListLayout", SectionList)
			sllist.SortOrder = Enum.SortOrder.LayoutOrder
			sllist.Padding = UDim.new(0,5)

			sllist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Size = UDim2.new(1,0,0, sllist.AbsoluteContentSize.Y + 42)
			end)

			local SectionFunc = {}

			-- ── TOGGLE ──
			function SectionFunc:AddToggle(cfg)
				cfg = Library:MakeConfig({
					Title = "Toggle", Description = "", Default = false, Callback = function() end
				}, cfg or {})

				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Toggle"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,36)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,0)
				TitleL.Size = UDim2.new(1,-60,1,0)
				TitleL.Font = Enum.Font.Gotham
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 13
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local DescL = Instance.new("TextLabel", Row)
				DescL.Name = "Content"
				DescL.BackgroundTransparency = 1
				DescL.Position = UDim2.new(0,10,0,20)
				DescL.Size = UDim2.new(1,-60,0,14)
				DescL.Font = Enum.Font.Gotham
				DescL.Text = cfg.Description
				DescL.TextColor3 = TEXT_GRAY
				DescL.TextSize = 11
				DescL.TextXAlignment = Enum.TextXAlignment.Left
				Library:UpdateContent(DescL, TitleL, Row)

				-- Pill toggle
				local Track = Instance.new("Frame", Row)
				Track.Name = "ToggleCheck"
				Track.AnchorPoint = Vector2.new(1,0.5)
				Track.BackgroundColor3 = TOGGLE_OFF
				Track.BorderSizePixel = 0
				Track.Position = UDim2.new(1,-10,0.5,0)
				Track.Size = UDim2.new(0,38,0,20)
				local trc = Instance.new("UICorner",Track); trc.CornerRadius = UDim.new(1,0)

				local Knob = Instance.new("Frame", Track)
				Knob.Name = "Check"
				Knob.AnchorPoint = Vector2.new(0,0.5)
				Knob.BackgroundColor3 = Color3.fromRGB(210,210,220)
				Knob.BorderSizePixel = 0
				Knob.Position = UDim2.new(0,3,0.5,0)
				Knob.Size = UDim2.new(0,14,0,14)
				local knc = Instance.new("UICorner",Knob); knc.CornerRadius = UDim.new(1,0)

				local Clicker = Instance.new("TextButton", Row)
				Clicker.BackgroundTransparency = 1
				Clicker.BorderSizePixel = 0
				Clicker.Size = UDim2.new(1,0,1,0)
				Clicker.Text = ""

				local TogFunc = { Value = cfg.Default }
				function TogFunc:Set(v)
					TogFunc.Value = v
					if v then
						Library:TweenInstance(Track, 0.25, "BackgroundColor3", ACCENT)
						Library:TweenInstance(Knob,  0.25, "Position", UDim2.new(0,21,0.5,0))
						Library:TweenInstance(Knob,  0.25, "BackgroundColor3", Color3.fromRGB(255,255,255))
					else
						Library:TweenInstance(Track, 0.25, "BackgroundColor3", TOGGLE_OFF)
						Library:TweenInstance(Knob,  0.25, "Position", UDim2.new(0,3,0.5,0))
						Library:TweenInstance(Knob,  0.25, "BackgroundColor3", Color3.fromRGB(210,210,220))
					end
					cfg.Callback(v)
				end
				TogFunc:Set(cfg.Default)
				Clicker.Activated:Connect(function() TogFunc:Set(not TogFunc.Value) end)

				-- Hover
				Row.MouseEnter:Connect(function()
					Library:TweenInstance(Row, 0.15, "BackgroundTransparency", 0.2)
				end)
				Row.MouseLeave:Connect(function()
					Library:TweenInstance(Row, 0.15, "BackgroundTransparency", 0.5)
				end)

				return TogFunc
			end

			-- ── BUTTON ──
			function SectionFunc:AddButton(cfg)
				cfg = Library:MakeConfig({
					Title = "Button", Description = "", Callback = function() end
				}, cfg or {})

				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Button"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,36)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,0)
				TitleL.Size = UDim2.new(1,-50,1,0)
				TitleL.Font = Enum.Font.Gotham
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 13
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local DescL = Instance.new("TextLabel", Row)
				DescL.Name = "Content"
				DescL.BackgroundTransparency = 1
				DescL.Position = UDim2.new(0,10,0,20)
				DescL.Size = UDim2.new(1,-50,0,14)
				DescL.Font = Enum.Font.Gotham
				DescL.Text = cfg.Description
				DescL.TextColor3 = TEXT_GRAY
				DescL.TextSize = 11
				DescL.TextXAlignment = Enum.TextXAlignment.Left
				Library:UpdateContent(DescL, TitleL, Row)

				-- Arrow icon
				local Arrow = Instance.new("ImageLabel", Row)
				Arrow.AnchorPoint = Vector2.new(1,0.5)
				Arrow.BackgroundTransparency = 1
				Arrow.Position = UDim2.new(1,-10,0.5,0)
				Arrow.Size = UDim2.new(0,16,0,16)
				Arrow.Image = "rbxassetid://85905776508942"
				Arrow.ImageColor3 = ACCENT2

				local Clicker = Instance.new("TextButton", Row)
				Clicker.BackgroundTransparency = 1
				Clicker.BorderSizePixel = 0
				Clicker.Size = UDim2.new(1,0,1,0)
				Clicker.Text = ""

				Clicker.Activated:Connect(function()
					Library:TweenInstance(Row, 0.1, "BackgroundTransparency", 0.1)
					cfg.Callback()
					Library:TweenInstance(Row, 0.2, "BackgroundTransparency", 0.5)
				end)
				Row.MouseEnter:Connect(function()
					Library:TweenInstance(Row, 0.15, "BackgroundTransparency", 0.2)
				end)
				Row.MouseLeave:Connect(function()
					Library:TweenInstance(Row, 0.15, "BackgroundTransparency", 0.5)
				end)
			end

			-- ── DROPDOWN ──
			function SectionFunc:AddDropdown(cfg)
				cfg = Library:MakeConfig({
					Title="Dropdown", Description="", Values={}, Default={}, Multi=false, Callback=function() end
				}, cfg or {})

				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Dropdown"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,36)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,0)
				TitleL.Size = UDim2.new(1,-100,1,0)
				TitleL.Font = Enum.Font.Gotham
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 13
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local DescL = Instance.new("TextLabel", Row)
				DescL.Name = "Content"
				DescL.BackgroundTransparency = 1
				DescL.Position = UDim2.new(0,10,0,20)
				DescL.Size = UDim2.new(1,-100,0,14)
				DescL.Font = Enum.Font.Gotham
				DescL.Text = cfg.Description
				DescL.TextColor3 = TEXT_GRAY
				DescL.TextSize = 11
				DescL.TextXAlignment = Enum.TextXAlignment.Left
				Library:UpdateContent(DescL, TitleL, Row)

				-- Value pill
				local Selects = Instance.new("Frame", Row)
				Selects.AnchorPoint = Vector2.new(1,0.5)
				Selects.BackgroundColor3 = BG_MAIN
				Selects.BorderSizePixel = 0
				Selects.Position = UDim2.new(1,-8,0.5,0)
				Selects.Size = UDim2.new(0,82,0,24)
				local ssc = Instance.new("UICorner",Selects); ssc.CornerRadius = UDim.new(0,4)
				local sss = Instance.new("UIStroke",Selects); sss.Color=ACCENT; sss.Thickness=0.8; sss.Transparency=0.6

				local SelectText = Instance.new("TextLabel", Selects)
				SelectText.Name = "SelectText"
				SelectText.BackgroundTransparency = 1
				SelectText.Position = UDim2.new(0,4,0,0)
				SelectText.Size = UDim2.new(1,-22,1,0)
				SelectText.Font = Enum.Font.Gotham
				SelectText.Text = "None"
				SelectText.TextColor3 = TEXT_W
				SelectText.TextSize = 11
				SelectText.TextScaled = true
				SelectText.TextWrapped = true
				Instance.new("UITextSizeConstraint", SelectText).MaxTextSize = 11

				local DropArrow = Instance.new("ImageLabel", Selects)
				DropArrow.AnchorPoint = Vector2.new(1,0.5)
				DropArrow.BackgroundTransparency = 1
				DropArrow.Position = UDim2.new(1,-2,0.5,0)
				DropArrow.Size = UDim2.new(0,14,0,14)
				DropArrow.Image = "rbxassetid://80845745785361"
				DropArrow.ImageColor3 = ACCENT2

				local Drop_Click = Instance.new("TextButton", Selects)
				Drop_Click.BackgroundTransparency = 1
				Drop_Click.BorderSizePixel = 0
				Drop_Click.Size = UDim2.new(1,0,1,0)
				Drop_Click.Text = ""

				-- Dropdown popup
				local DropList = Instance.new("Frame", DropdownZone)
				DropList.Name = "DropdownList"
				DropList.AnchorPoint = Vector2.new(0.5,0.5)
				DropList.BackgroundColor3 = BG_PANEL
				DropList.BorderSizePixel = 0
				DropList.Position = UDim2.new(0.5,0,0.5,0)
				DropList.Size = UDim2.new(0,380,0,240)
				DropList.Visible = false
				local dlc = Instance.new("UICorner",DropList); dlc.CornerRadius = UDim.new(0,8)
				local dls = Instance.new("UIStroke",DropList); dls.Color=ACCENT; dls.Thickness=1; dls.Transparency=0.5

				-- Popup topbar
				local PopTop = Instance.new("Frame", DropList)
				PopTop.BackgroundTransparency = 1
				PopTop.BorderSizePixel = 0
				PopTop.Size = UDim2.new(1,0,0,44)

				local PopTitle = Instance.new("TextLabel", PopTop)
				PopTitle.BackgroundTransparency = 1
				PopTitle.Position = UDim2.new(0,14,0,0)
				PopTitle.Size = UDim2.new(1,-120,1,0)
				PopTitle.Font = Enum.Font.GothamBold
				PopTitle.Text = cfg.Title
				PopTitle.TextColor3 = TEXT_W
				PopTitle.TextSize = 13
				PopTitle.TextXAlignment = Enum.TextXAlignment.Left

				-- Search inside dropdown
				local PopSearch = Instance.new("Frame", PopTop)
				PopSearch.BackgroundColor3 = BG_ITEM
				PopSearch.BorderSizePixel = 0
				PopSearch.Position = UDim2.new(1,-140,0,8)
				PopSearch.Size = UDim2.new(0,90,0,28)
				local psc = Instance.new("UICorner",PopSearch); psc.CornerRadius = UDim.new(0,5)
				local pss = Instance.new("UIStroke",PopSearch); pss.Color=ACCENT; pss.Thickness=0.8; pss.Transparency=0.7
				local psIcon = Instance.new("ImageLabel",PopSearch)
				psIcon.AnchorPoint = Vector2.new(0,0.5)
				psIcon.BackgroundTransparency = 1
				psIcon.Position = UDim2.new(0,6,0.5,0)
				psIcon.Size = UDim2.new(0,12,0,12)
				psIcon.Image = "rbxassetid://71309835376233"
				psIcon.ImageColor3 = TEXT_GRAY
				local PopTB = Instance.new("TextBox", PopSearch)
				PopTB.BackgroundTransparency = 1
				PopTB.BorderSizePixel = 0
				PopTB.Position = UDim2.new(0,22,0,0)
				PopTB.Size = UDim2.new(1,-26,1,0)
				PopTB.Font = Enum.Font.Gotham
				PopTB.PlaceholderText = "Search..."
				PopTB.PlaceholderColor3 = TEXT_GRAY
				PopTB.Text = ""
				PopTB.TextColor3 = TEXT_W
				PopTB.TextSize = 11
				PopTB.TextXAlignment = Enum.TextXAlignment.Left
				PopTB.ClearTextOnFocus = false

				-- Close popup btn
				local PopClose = Instance.new("TextButton", PopTop)
				PopClose.BackgroundTransparency = 1
				PopClose.BorderSizePixel = 0
				PopClose.Position = UDim2.new(1,-38,0,8)
				PopClose.Size = UDim2.new(0,28,0,28)
				PopClose.Text = ""
				local pcIcon = Instance.new("ImageLabel", PopClose)
				pcIcon.AnchorPoint = Vector2.new(0.5,0.5)
				pcIcon.BackgroundTransparency = 1
				pcIcon.Position = UDim2.new(0.5,0,0.5,0)
				pcIcon.Size = UDim2.new(0,14,0,14)
				pcIcon.Image = "rbxassetid://105957381820378"
				pcIcon.ImageRectOffset = Vector2.new(480,0)
				pcIcon.ImageRectSize = Vector2.new(96,96)
				pcIcon.ImageColor3 = TEXT_GRAY

				-- Items list
				local RealList = Instance.new("ScrollingFrame", DropList)
				RealList.Name = "Real_List"
				RealList.BackgroundColor3 = BG_MAIN
				RealList.BackgroundTransparency = 0.3
				RealList.BorderSizePixel = 0
				RealList.Position = UDim2.new(0,10,0,48)
				RealList.Size = UDim2.new(1,-20,1,-58)
				RealList.ScrollBarThickness = 2
				RealList.ScrollBarImageColor3 = ACCENT
				RealList.Selectable = false
				local rlc = Instance.new("UICorner",RealList); rlc.CornerRadius = UDim.new(0,6)
				local rll = Instance.new("UIListLayout",RealList)
				rll.SortOrder = Enum.SortOrder.LayoutOrder
				rll.Padding = UDim.new(0,3)
				local rlp = Instance.new("UIPadding",RealList)
				rlp.PaddingTop=UDim.new(0,5); rlp.PaddingBottom=UDim.new(0,5)
				rlp.PaddingLeft=UDim.new(0,5); rlp.PaddingRight=UDim.new(0,5)
				Library:UpdateScrolling(RealList, rll)

				-- Search filter
				PopTB:GetPropertyChangedSignal("Text"):Connect(function()
					local q = PopTB.Text:lower()
					for _, item in next, RealList:GetChildren() do
						if item:IsA("Frame") and item:FindFirstChild("Title") then
							item.Visible = item.Title.Text:lower():find(q) ~= nil
						end
					end
				end)

				Drop_Click.Activated:Connect(function()
					DropdownZone.Visible = true
					DropList.Visible = true
				end)
				PopClose.Activated:Connect(function()
					DropList.Visible = false
					DropdownZone.Visible = false
				end)

				local DropFunc = { Value = {} }
				if type(cfg.Default)=="string" then
					if cfg.Default~="" then DropFunc.Value = {cfg.Default} end
				elseif type(cfg.Default)=="table" then
					DropFunc.Value = cfg.Default
				end

				function DropFunc:Set()
					for _, v in next, RealList:GetChildren() do
						if v:IsA("Frame") and v:FindFirstChild("Title") then
							local sel = table.find(DropFunc.Value, v.Title.Text)
							Library:TweenInstance(v, 0.2, "BackgroundTransparency", sel and 0.1 or 0.7)
							Library:TweenInstance(v.Title, 0.2, "TextColor3", sel and ACCENT or TEXT_W)
						end
					end
					local s = table.concat(DropFunc.Value, ", ")
					SelectText.Text = s ~= "" and s or "None"
				end

				function DropFunc:Add(v)
					local Item = Instance.new("Frame", RealList)
					Item.BackgroundColor3 = BG_ITEM2
					Item.BackgroundTransparency = 0.7
					Item.BorderSizePixel = 0
					Item.Size = UDim2.new(1,0,0,32)
					local ic = Instance.new("UICorner",Item); ic.CornerRadius = UDim.new(0,5)
					local iTitle = Instance.new("TextLabel", Item)
					iTitle.Name = "Title"
					iTitle.BackgroundTransparency = 1
					iTitle.Position = UDim2.new(0,10,0,0)
					iTitle.Size = UDim2.new(1,-10,1,0)
					iTitle.Font = Enum.Font.Gotham
					iTitle.Text = v
					iTitle.TextColor3 = TEXT_W
					iTitle.TextSize = 12
					iTitle.TextXAlignment = Enum.TextXAlignment.Left
					local iClick = Instance.new("TextButton", Item)
					iClick.BackgroundTransparency = 1
					iClick.BorderSizePixel = 0
					iClick.Size = UDim2.new(1,0,1,0)
					iClick.Text = ""
					iClick.Activated:Connect(function()
						local cur = iTitle.Text
						if cfg.Multi then
							if table.find(DropFunc.Value, cur) then
								for i,val in pairs(DropFunc.Value) do
									if val==cur then table.remove(DropFunc.Value,i); break end
								end
							else
								table.insert(DropFunc.Value, cur)
							end
						else
							DropFunc.Value = {cur}
						end
						DropFunc:Set()
						if cfg.Multi then cfg.Callback(DropFunc.Value)
						else cfg.Callback(DropFunc.Value[1]) end
					end)
					Item.MouseEnter:Connect(function()
						Library:TweenInstance(Item, 0.1, "BackgroundTransparency", 0.3)
					end)
					Item.MouseLeave:Connect(function()
						local sel = table.find(DropFunc.Value, v)
						Library:TweenInstance(Item, 0.1, "BackgroundTransparency", sel and 0.1 or 0.7)
					end)
				end

				function DropFunc:Clear()
					for _, v in next, RealList:GetChildren() do
						if v:IsA("Frame") then v:Destroy() end
					end
				end

				function DropFunc:Refresh(NewList)
					self:Clear()
					for _, v in next, NewList do self:Add(v) end
				end

				DropFunc:Refresh(cfg.Values)
				DropFunc:Set()
				if #DropFunc.Value > 0 then
					if cfg.Multi then cfg.Callback(DropFunc.Value)
					else cfg.Callback(DropFunc.Value[1]) end
				end
				return DropFunc
			end

			-- ── INPUT ──
			function SectionFunc:AddInput(cfg)
				cfg = Library:MakeConfig({
					Title="Textbox", Description="", PlaceHolder="", Default="", Callback=function() end
				}, cfg or {})

				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Input"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,36)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,0)
				TitleL.Size = UDim2.new(1,-150,1,0)
				TitleL.Font = Enum.Font.Gotham
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 13
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local DescL = Instance.new("TextLabel", Row)
				DescL.Name = "Content"
				DescL.BackgroundTransparency = 1
				DescL.Position = UDim2.new(0,10,0,20)
				DescL.Size = UDim2.new(1,-150,0,14)
				DescL.Font = Enum.Font.Gotham
				DescL.Text = cfg.Description
				DescL.TextColor3 = TEXT_GRAY
				DescL.TextSize = 11
				DescL.TextXAlignment = Enum.TextXAlignment.Left
				Library:UpdateContent(DescL, TitleL, Row)

				local TBFrame = Instance.new("Frame", Row)
				TBFrame.AnchorPoint = Vector2.new(1,0.5)
				TBFrame.BackgroundColor3 = BG_MAIN
				TBFrame.BorderSizePixel = 0
				TBFrame.Position = UDim2.new(1,-8,0.5,0)
				TBFrame.Size = UDim2.new(0,130,0,26)
				local tfc = Instance.new("UICorner",TBFrame); tfc.CornerRadius = UDim.new(0,5)
				local tfs = Instance.new("UIStroke",TBFrame); tfs.Color=ACCENT; tfs.Thickness=0.8; tfs.Transparency=0.6

				local WriteIcon = Instance.new("ImageLabel", TBFrame)
				WriteIcon.AnchorPoint = Vector2.new(0,0.5)
				WriteIcon.BackgroundTransparency = 1
				WriteIcon.Position = UDim2.new(0,6,0.5,0)
				WriteIcon.Size = UDim2.new(0,12,0,12)
				WriteIcon.Image = "rbxassetid://126409600467363"
				WriteIcon.ImageColor3 = ACCENT2

				local TB = Instance.new("TextBox", TBFrame)
				TB.Name = "RealTextBox"
				TB.BackgroundTransparency = 1
				TB.BorderSizePixel = 0
				TB.Position = UDim2.new(0,22,0,0)
				TB.Size = UDim2.new(1,-26,1,0)
				TB.Font = Enum.Font.Gotham
				TB.PlaceholderText = cfg.PlaceHolder
				TB.PlaceholderColor3 = TEXT_GRAY
				TB.Text = cfg.Default
				TB.TextColor3 = TEXT_W
				TB.TextSize = 11
				TB.TextXAlignment = Enum.TextXAlignment.Left
				TB.ClearTextOnFocus = false

				TB.FocusLost:Connect(function() cfg.Callback(TB.Text) end)
				cfg.Callback(TB.Text)
			end

			-- ── SLIDER ──
			function SectionFunc:AddSlider(cfg)
				cfg = Library:MakeConfig({
					Title="Slider", Description="", Max=100, Min=0, Increment=1, Default=0, Callback=function() end
				}, cfg or {})

				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Slider"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,36)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,0)
				TitleL.Size = UDim2.new(1,-160,1,0)
				TitleL.Font = Enum.Font.Gotham
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 13
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local DescL = Instance.new("TextLabel", Row)
				DescL.Name = "Content"
				DescL.BackgroundTransparency = 1
				DescL.Position = UDim2.new(0,10,0,20)
				DescL.Size = UDim2.new(1,-160,0,14)
				DescL.Font = Enum.Font.Gotham
				DescL.Text = cfg.Description
				DescL.TextColor3 = TEXT_GRAY
				DescL.TextSize = 11
				DescL.TextXAlignment = Enum.TextXAlignment.Left
				Library:UpdateContent(DescL, TitleL, Row)

				-- Value box
				local ValBox = Instance.new("TextBox", Row)
				ValBox.Name = "SliderValue"
				ValBox.AnchorPoint = Vector2.new(1,0.5)
				ValBox.BackgroundColor3 = ACCENT2
				ValBox.BackgroundTransparency = 0.6
				ValBox.BorderSizePixel = 0
				ValBox.Position = UDim2.new(1,-148,0.5,0)
				ValBox.Size = UDim2.new(0,32,0,18)
				ValBox.Font = Enum.Font.GothamBold
				ValBox.Text = tostring(cfg.Default)
				ValBox.TextColor3 = TEXT_W
				ValBox.TextSize = 10
				ValBox.ClearTextOnFocus = false
				local vbc = Instance.new("UICorner",ValBox); vbc.CornerRadius = UDim.new(0,4)

				-- Track
				local Track = Instance.new("Frame", Row)
				Track.Name = "SliderFrame"
				Track.AnchorPoint = Vector2.new(1,0.5)
				Track.BackgroundColor3 = BG_MAIN
				Track.BorderSizePixel = 0
				Track.Position = UDim2.new(1,-10,0.5,0)
				Track.Size = UDim2.new(0,130,0,6)
				local trc = Instance.new("UICorner",Track); trc.CornerRadius = UDim.new(1,0)

				local Fill = Instance.new("Frame", Track)
				Fill.Name = "SliderDraggable"
				Fill.BackgroundColor3 = ACCENT
				Fill.BorderSizePixel = 0
				Fill.Size = UDim2.new(0,0,1,0)
				local fc = Instance.new("UICorner",Fill); fc.CornerRadius = UDim.new(1,0)

				local Dot = Instance.new("Frame", Fill)
				Dot.Name = "Circle"
				Dot.AnchorPoint = Vector2.new(1,0.5)
				Dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Dot.BorderSizePixel = 0
				Dot.Position = UDim2.new(1,0,0.5,0)
				Dot.Size = UDim2.new(0,10,0,10)
				local dotc = Instance.new("UICorner",Dot); dotc.CornerRadius = UDim.new(1,0)

				local SliderFunc = { Value = cfg.Default }
				local Dragging = false

				local function Round(n, f)
					return math.floor(n/f + 0.5*math.sign(n)) * f
				end

				function SliderFunc:Set(v)
					v = math.clamp(Round(v, cfg.Increment), cfg.Min, cfg.Max)
					SliderFunc.Value = v
					ValBox.Text = tostring(v)
					local scale = (v - cfg.Min) / (cfg.Max - cfg.Min)
					game:GetService("TweenService"):Create(Fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
						Size = UDim2.fromScale(scale, 1)
					}):Play()
				end

				Track.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true end
				end)
				Track.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false; cfg.Callback(SliderFunc.Value)
					end
				end)
				game:GetService("UserInputService").InputChanged:Connect(function(i)
					if Dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
						local s = math.clamp((i.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
						SliderFunc:Set(cfg.Min + (cfg.Max - cfg.Min) * s)
					end
				end)
				ValBox.FocusLost:Connect(function()
					local n = tonumber(ValBox.Text)
					if n then SliderFunc:Set(n) else SliderFunc:Set(cfg.Default) end
					cfg.Callback(SliderFunc.Value)
				end)

				SliderFunc:Set(cfg.Default)
				return SliderFunc
			end

			-- ── SEPARATOR ──
			function SectionFunc:AddSeperator(txt)
				local Sep = Instance.new("Frame", SectionList)
				Sep.Name = "Seperator"
				Sep.BackgroundTransparency = 1
				Sep.BorderSizePixel = 0
				Sep.Size = UDim2.new(1,0,0,18)
				local TitleL = Instance.new("TextLabel", Sep)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,6,0,0)
				TitleL.Size = UDim2.new(1,-6,1,0)
				TitleL.Font = Enum.Font.GothamBold
				TitleL.Text = txt
				TitleL.TextColor3 = ACCENT2
				TitleL.TextSize = 11
				TitleL.TextXAlignment = Enum.TextXAlignment.Left
			end

			-- ── PARAGRAPH ──
			function SectionFunc:AddParagraph(cfg)
				cfg = Library:MakeConfig({ Title="", Content="" }, cfg or {})
				local Row = Instance.new("Frame", SectionList)
				Row.Name = "Paragraph"
				Row.BackgroundColor3 = BG_ITEM2
				Row.BackgroundTransparency = 0.5
				Row.BorderSizePixel = 0
				Row.Size = UDim2.new(1,0,0,44)
				local rc = Instance.new("UICorner",Row); rc.CornerRadius = UDim.new(0,5)

				local TitleL = Instance.new("TextLabel", Row)
				TitleL.Name = "Title"
				TitleL.BackgroundTransparency = 1
				TitleL.Position = UDim2.new(0,10,0,6)
				TitleL.Size = UDim2.new(1,-12,0,16)
				TitleL.Font = Enum.Font.GothamBold
				TitleL.Text = cfg.Title
				TitleL.TextColor3 = TEXT_W
				TitleL.TextSize = 12
				TitleL.TextXAlignment = Enum.TextXAlignment.Left

				local ContentL = Instance.new("TextLabel", Row)
				ContentL.Name = "Content"
				ContentL.BackgroundTransparency = 1
				ContentL.Position = UDim2.new(0,10,0,22)
				ContentL.Size = UDim2.new(1,-12,1,-24)
				ContentL.Font = Enum.Font.Gotham
				ContentL.Text = cfg.Content
				ContentL.TextColor3 = TEXT_GRAY
				ContentL.TextSize = 11
				ContentL.TextXAlignment = Enum.TextXAlignment.Left
				ContentL.TextYAlignment = Enum.TextYAlignment.Top
				ContentL.TextWrapped = true
				Library:UpdateContent(ContentL, TitleL, Row)

				local ParaFunc = {}
				function ParaFunc:SetTitle(v) TitleL.Text = v end
				function ParaFunc:SetDesc(v) ContentL.Text = v end
				return ParaFunc
			end

			-- ── DISCORD CARD ──
			function SectionFunc:AddDiscord(title, code)
				local Card = Instance.new("Frame", SectionList)
				Card.Name = "DiscordCard"
				Card.BackgroundColor3 = Color3.fromRGB(30,33,45)
				Card.BackgroundTransparency = 0.2
				Card.BorderSizePixel = 0
				Card.Size = UDim2.new(1,0,0,60)
				local cc = Instance.new("UICorner",Card); cc.CornerRadius = UDim.new(0,8)
				local cs = Instance.new("UIStroke",Card); cs.Color=Color3.fromRGB(88,101,242); cs.Thickness=1; cs.Transparency=0.5

				local Icon = Instance.new("ImageLabel", Card)
				Icon.BackgroundTransparency = 1
				Icon.Position = UDim2.new(0,10,0,8)
				Icon.Size = UDim2.new(0,42,0,42)
				Icon.Image = "rbxassetid://80900795508277"

				local Title = Instance.new("TextLabel", Card)
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0,60,0,12)
				Title.Size = UDim2.new(1,-150,0,18)
				Title.Font = Enum.Font.GothamBold
				Title.Text = title or "Discord"
				Title.TextColor3 = TEXT_W
				Title.TextSize = 13
				Title.TextXAlignment = Enum.TextXAlignment.Left

				local Sub = Instance.new("TextLabel", Card)
				Sub.BackgroundTransparency = 1
				Sub.Position = UDim2.new(0,60,0,30)
				Sub.Size = UDim2.new(1,-150,0,16)
				Sub.Font = Enum.Font.Gotham
				Sub.Text = "Click to join server"
				Sub.TextColor3 = TEXT_GRAY
				Sub.TextSize = 11
				Sub.TextXAlignment = Enum.TextXAlignment.Left

				local JoinBtn = Instance.new("TextButton", Card)
				JoinBtn.Name = "JoinBtn"
				JoinBtn.AnchorPoint = Vector2.new(1,0.5)
				JoinBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)
				JoinBtn.BorderSizePixel = 0
				JoinBtn.Position = UDim2.new(1,-10,0.5,0)
				JoinBtn.Size = UDim2.new(0,60,0,28)
				JoinBtn.Font = Enum.Font.GothamBold
				JoinBtn.Text = "Join"
				JoinBtn.TextColor3 = TEXT_W
				JoinBtn.TextSize = 12
				local jbc = Instance.new("UICorner",JoinBtn); jbc.CornerRadius = UDim.new(0,6)

				JoinBtn.MouseButton1Click:Connect(function()
					if setclipboard then setclipboard("https://discord.gg/"..code) end
					local req = (syn and syn.request) or (http and http.request) or http_request or request
					if req then pcall(function()
						req({
							Url="http://127.0.0.1:6463/rpc?v=1", Method="POST",
							Headers={["Content-Type"]="application/json",["Origin"]="https://discord.com"},
							Body=game:GetService("HttpService"):JSONEncode({
								cmd="INVITE_BROWSER",
								nonce=game:GetService("HttpService"):GenerateGUID(false),
								args={code=code}
							})
						})
					end) end
					JoinBtn.Text = "Copied!"
					task.wait(2)
					JoinBtn.Text = "Join"
				end)
			end

			return SectionFunc
		end

		return TabFunc
	end

	return Tab
end

return Library
