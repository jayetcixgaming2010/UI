local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Utility = {}
local Objects = {}

-- ─── Easing Presets (dùng chung) ──────────────────────────────────────────────
local EASE = {
    Fast   = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Medium = TweenInfo.new(0.30, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Slow   = TweenInfo.new(0.50, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Bounce = TweenInfo.new(0.45, Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
    Spring = TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
}

-- ─── Dragging ─────────────────────────────────────────────────────────────────
function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, inputPos, framePos

    local function startDrag(inp)
        dragging = true
        inputPos = inp.Position
        framePos = parent.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    frame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            startDrag(inp)
        end
    end)
    frame.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            dragInput = inp
        end
    end)
    input.InputChanged:Connect(function(inp)
        if inp == dragInput and dragging then
            local delta = inp.Position - inputPos
            parent.Position = UDim2.new(
                framePos.X.Scale, framePos.X.Offset + delta.X,
                framePos.Y.Scale, framePos.Y.Offset + delta.Y
            )
        end
    end)
end

function Utility:TweenObject(obj, props, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), props):Play()
end

-- ─── Themes ───────────────────────────────────────────────────────────────────
local themes = {
    SchemeColor  = Color3.fromRGB(74, 99, 135),
    Background   = Color3.fromRGB(36, 37, 43),
    Header       = Color3.fromRGB(28, 29, 34),
    TextColor    = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38),
}

local themeStyles = {
    -- ── Themes cũ ──
    DarkTheme  = { SchemeColor=Color3.fromRGB(64,64,64),    Background=Color3.fromRGB(0,0,0),       Header=Color3.fromRGB(0,0,0),       TextColor=Color3.fromRGB(255,255,255), ElementColor=Color3.fromRGB(20,20,20)    },
    LightTheme = { SchemeColor=Color3.fromRGB(150,150,150), Background=Color3.fromRGB(255,255,255), Header=Color3.fromRGB(200,200,200), TextColor=Color3.fromRGB(0,0,0),       ElementColor=Color3.fromRGB(224,224,224) },
    BloodTheme = { SchemeColor=Color3.fromRGB(227,27,27),   Background=Color3.fromRGB(10,10,10),    Header=Color3.fromRGB(5,5,5),       TextColor=Color3.fromRGB(255,255,255), ElementColor=Color3.fromRGB(20,20,20)    },
    GrapeTheme = { SchemeColor=Color3.fromRGB(166,71,214),  Background=Color3.fromRGB(64,50,71),    Header=Color3.fromRGB(36,28,41),    TextColor=Color3.fromRGB(255,255,255), ElementColor=Color3.fromRGB(74,58,84)    },
    Ocean      = { SchemeColor=Color3.fromRGB(86,76,251),   Background=Color3.fromRGB(26,32,58),    Header=Color3.fromRGB(38,45,71),    TextColor=Color3.fromRGB(200,200,200), ElementColor=Color3.fromRGB(38,45,71)    },
    Midnight   = { SchemeColor=Color3.fromRGB(26,189,158),  Background=Color3.fromRGB(44,62,82),    Header=Color3.fromRGB(57,81,105),   TextColor=Color3.fromRGB(255,255,255), ElementColor=Color3.fromRGB(52,74,95)    },
    Sentinel   = { SchemeColor=Color3.fromRGB(230,35,69),   Background=Color3.fromRGB(32,32,32),    Header=Color3.fromRGB(24,24,24),    TextColor=Color3.fromRGB(119,209,138), ElementColor=Color3.fromRGB(24,24,24)    },
    Synapse    = { SchemeColor=Color3.fromRGB(46,48,43),    Background=Color3.fromRGB(13,15,12),    Header=Color3.fromRGB(36,38,35),    TextColor=Color3.fromRGB(152,99,53),   ElementColor=Color3.fromRGB(24,24,24)    },
    Serpent    = { SchemeColor=Color3.fromRGB(0,166,58),    Background=Color3.fromRGB(31,41,43),    Header=Color3.fromRGB(22,29,31),    TextColor=Color3.fromRGB(255,255,255), ElementColor=Color3.fromRGB(22,29,31)    },

    -- ── Themes MỚI ──
    Neon       = { SchemeColor=Color3.fromRGB(0,255,180),   Background=Color3.fromRGB(10,10,18),    Header=Color3.fromRGB(6,6,12),      TextColor=Color3.fromRGB(220,255,245), ElementColor=Color3.fromRGB(18,18,30)    },
    Rose       = { SchemeColor=Color3.fromRGB(255,100,150), Background=Color3.fromRGB(30,15,22),    Header=Color3.fromRGB(20,10,16),    TextColor=Color3.fromRGB(255,220,230), ElementColor=Color3.fromRGB(42,22,32)    },
    Arctic     = { SchemeColor=Color3.fromRGB(130,210,255), Background=Color3.fromRGB(20,30,45),    Header=Color3.fromRGB(12,20,32),    TextColor=Color3.fromRGB(210,235,255), ElementColor=Color3.fromRGB(28,40,58)    },
    Sunset     = { SchemeColor=Color3.fromRGB(255,140,50),  Background=Color3.fromRGB(28,18,10),    Header=Color3.fromRGB(18,10,5),     TextColor=Color3.fromRGB(255,230,200), ElementColor=Color3.fromRGB(40,25,14)    },
    Cyber      = { SchemeColor=Color3.fromRGB(255,255,0),   Background=Color3.fromRGB(8,8,8),       Header=Color3.fromRGB(4,4,4),       TextColor=Color3.fromRGB(255,255,180), ElementColor=Color3.fromRGB(20,20,10)    },
    Lavender   = { SchemeColor=Color3.fromRGB(180,130,255), Background=Color3.fromRGB(25,20,40),    Header=Color3.fromRGB(16,12,28),    TextColor=Color3.fromRGB(230,215,255), ElementColor=Color3.fromRGB(36,28,55)    },
    Emerald    = { SchemeColor=Color3.fromRGB(50,220,120),  Background=Color3.fromRGB(12,25,18),    Header=Color3.fromRGB(8,16,12),     TextColor=Color3.fromRGB(200,255,225), ElementColor=Color3.fromRGB(18,35,26)    },
}

-- ─── Notification System ──────────────────────────────────────────────────────
-- Tự tạo ScreenGui riêng cho notifications để hiện dù UI chính bị đóng
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "KavoNotifications_" .. tostring(math.random(1000,9999))
NotifGui.ResetOnSpawn = false
NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotifGui.Parent = game.CoreGui

local NotifHolder = Instance.new("Frame")
NotifHolder.Name = "NotifHolder"
NotifHolder.Parent = NotifGui
NotifHolder.AnchorPoint = Vector2.new(1, 1)
NotifHolder.Position = UDim2.new(1, -16, 1, -16)
NotifHolder.Size = UDim2.new(0, 300, 1, -32)
NotifHolder.BackgroundTransparency = 1
NotifHolder.BorderSizePixel = 0

local NotifList = Instance.new("UIListLayout")
NotifList.Parent = NotifHolder
NotifList.SortOrder = Enum.SortOrder.LayoutOrder
NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifList.Padding = UDim.new(0, 8)

local notifCount = 0

--[[
    Kavo:Notify(options)
    options = {
        Title    = "Title",        -- tiêu đề
        Content  = "Message",      -- nội dung
        Duration = 4,              -- giây (default 4)
        Type     = "Info",         -- "Info" | "Success" | "Warning" | "Error"
    }
]]
function Kavo:Notify(options)
    options = options or {}
    local title    = options.Title    or "Notification"
    local content  = options.Content  or ""
    local duration = options.Duration or 4
    local ntype    = options.Type     or "Info"

    -- Màu theo type
    local typeColors = {
        Info    = Color3.fromRGB(74, 140, 255),
        Success = Color3.fromRGB(50, 210, 110),
        Warning = Color3.fromRGB(255, 185, 40),
        Error   = Color3.fromRGB(235, 60, 60),
    }
    local typeIcons = {
        Info    = "ℹ",
        Success = "✔",
        Warning = "⚠",
        Error   = "✖",
    }
    local accentColor = typeColors[ntype] or typeColors.Info
    local icon        = typeIcons[ntype]  or "ℹ"

    notifCount += 1

    -- Container
    local card = Instance.new("Frame")
    card.Name = "Notif_" .. notifCount
    card.Parent = NotifHolder
    card.Size = UDim2.new(1, 0, 0, 70)
    card.BackgroundColor3 = Color3.fromRGB(28, 29, 36)
    card.BorderSizePixel = 0
    card.ClipsDescendants = true
    card.BackgroundTransparency = 1  -- start invisible

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card

    -- Drop shadow illusion (darker frame behind)
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 4, 1, 4)
    shadow.Position = UDim2.new(0, -2, 0, 2)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = card.ZIndex - 1
    shadow.Parent = card
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 8)
    shadowCorner.Parent = shadow

    -- Accent bar (kiri)
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Parent = card
    accentBar.Size = UDim2.new(0, 4, 1, 0)
    accentBar.BackgroundColor3 = accentColor
    accentBar.BorderSizePixel = 0
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 4)
    accentCorner.Parent = accentBar

    -- Icon label
    local iconLbl = Instance.new("TextLabel")
    iconLbl.Parent = card
    iconLbl.Size = UDim2.new(0, 30, 0, 30)
    iconLbl.Position = UDim2.new(0, 14, 0, 10)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.Text = icon
    iconLbl.TextColor3 = accentColor
    iconLbl.TextSize = 18

    -- Title
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = card
    titleLbl.Size = UDim2.new(1, -90, 0, 18)
    titleLbl.Position = UDim2.new(0, 48, 0, 10)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 13
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Content
    local contentLbl = Instance.new("TextLabel")
    contentLbl.Parent = card
    contentLbl.Size = UDim2.new(1, -58, 0, 28)
    contentLbl.Position = UDim2.new(0, 48, 0, 30)
    contentLbl.BackgroundTransparency = 1
    contentLbl.Font = Enum.Font.Gotham
    contentLbl.Text = content
    contentLbl.TextColor3 = Color3.fromRGB(190, 190, 200)
    contentLbl.TextSize = 11
    contentLbl.TextXAlignment = Enum.TextXAlignment.Left
    contentLbl.TextYAlignment = Enum.TextYAlignment.Top
    contentLbl.TextWrapped = true

    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = card
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -26, 0, 8)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(140, 140, 150)
    closeBtn.TextSize = 12

    -- Progress bar (timer)
    local progressBg = Instance.new("Frame")
    progressBg.Parent = card
    progressBg.Size = UDim2.new(1, 0, 0, 3)
    progressBg.Position = UDim2.new(0, 0, 1, -3)
    progressBg.BackgroundColor3 = Color3.fromRGB(45, 46, 56)
    progressBg.BorderSizePixel = 0

    local progressBar = Instance.new("Frame")
    progressBar.Parent = progressBg
    progressBar.Size = UDim2.new(1, 0, 1, 0)
    progressBar.BackgroundColor3 = accentColor
    progressBar.BorderSizePixel = 0

    -- Slide in từ phải
    card.Position = UDim2.new(1, 20, 0, 0)  -- off-screen right
    tween:Create(card, EASE.Bounce, {BackgroundTransparency = 0}):Play()
    tween:Create(card, EASE.Bounce, {Position = UDim2.new(0, 0, 0, 0)}):Play()

    -- Hàm đóng
    local dismissed = false
    local function dismiss()
        if dismissed then return end
        dismissed = true
        tween:Create(card, EASE.Fast, {BackgroundTransparency = 1}):Play()
        tween:Create(card, EASE.Medium, {Position = UDim2.new(1, 20, 0, 0)}):Play()
        wait(0.35)
        card:Destroy()
    end

    closeBtn.MouseButton1Click:Connect(dismiss)

    -- Progress tween
    tween:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

    -- Auto dismiss
    task.delay(duration, dismiss)
end

-- ─── Toggle UI ────────────────────────────────────────────────────────────────
local LibName = tostring(math.random(1,100))..tostring(math.random(1,50))..tostring(math.random(1,100))

function Kavo:ToggleUI()
    local gui = game.CoreGui:FindFirstChild(LibName)
    if gui then
        gui.Enabled = not gui.Enabled
    end
end

-- ─── CreateLib ────────────────────────────────────────────────────────────────
function Kavo.CreateLib(kavName, themeList)
    if not themeList then themeList = themes end

    -- Resolve theme string
    if type(themeList) == "string" then
        themeList = themeStyles[themeList] or themes
    else
        themeList.SchemeColor  = themeList.SchemeColor  or Color3.fromRGB(74,99,135)
        themeList.Background   = themeList.Background   or Color3.fromRGB(36,37,43)
        themeList.Header       = themeList.Header       or Color3.fromRGB(28,29,34)
        themeList.TextColor    = themeList.TextColor    or Color3.fromRGB(255,255,255)
        themeList.ElementColor = themeList.ElementColor or Color3.fromRGB(32,32,38)
    end

    kavName = kavName or "Library"

    -- Xóa GUI cũ cùng tên
    for _, v in ipairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == LibName then v:Destroy() end
    end

    -- ── Tạo GUI ──────────────────────────────────────────────────────────────
    local ScreenGui   = Instance.new("ScreenGui")
    local Main        = Instance.new("Frame")
    local MainCorner  = Instance.new("UICorner")
    local MainHeader  = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup     = Instance.new("Frame")
    local title       = Instance.new("TextLabel")
    local close       = Instance.new("ImageButton")
    local minimize    = Instance.new("ImageButton")
    local MainSide    = Instance.new("Frame")
    local sideCorner  = Instance.new("UICorner")
    local coverup_2   = Instance.new("Frame")
    local tabFrames   = Instance.new("Frame")
    local tabListing  = Instance.new("UIListLayout")
    local pages       = Instance.new("Frame")
    local Pages       = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")
    local blurFrame   = Instance.new("Frame")

    Kavo:DraggingEnabled(MainHeader, Main)

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Animasi masuk: scale dari 0
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)   -- start 0 for open anim

    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = Main

    -- Open animation
    tween:Create(Main, EASE.Bounce, {Size = UDim2.new(0, 525, 0, 318)}):Play()

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(0, 525, 0, 29)

    headerCover.CornerRadius = UDim.new(0, 6)
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
    title.Size = UDim2.new(0, 204, 0, 8)
    title.Font = Enum.Font.GothamBold
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- ── Close button ──────────────────────────────────────────────────────────
    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1
    close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
    close.Size = UDim2.new(0, 21, 0, 21)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)

    close.MouseEnter:Connect(function()
        tween:Create(close, EASE.Fast, {ImageColor3 = Color3.fromRGB(255,80,80)}):Play()
    end)
    close.MouseLeave:Connect(function()
        tween:Create(close, EASE.Fast, {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    close.MouseButton1Click:Connect(function()
        -- Animasi tutup: shrink ke tengah
        tween:Create(Main, EASE.Medium, {
            Size     = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(
                0, Main.AbsolutePosition.X + Main.AbsoluteSize.X / 2,
                0, Main.AbsolutePosition.Y + Main.AbsoluteSize.Y / 2
            ),
        }):Play()
        tween:Create(Main, EASE.Fast, {BackgroundTransparency = 1}):Play()
        task.wait(0.4)
        ScreenGui:Destroy()
    end)

    -- ── Minimize button ───────────────────────────────────────────────────────
    minimize.Name = "minimize"
    minimize.Parent = MainHeader
    minimize.BackgroundTransparency = 1
    minimize.Position = UDim2.new(0.905, 0, 0.137999997, 0)
    minimize.Size = UDim2.new(0, 21, 0, 21)
    minimize.ZIndex = 2
    minimize.Image = "rbxassetid://3926305904"
    minimize.ImageRectOffset = Vector2.new(164, 284)
    minimize.ImageRectSize = Vector2.new(36, 36)

    local minimized = false
    minimize.MouseEnter:Connect(function()
        tween:Create(minimize, EASE.Fast, {ImageColor3 = Color3.fromRGB(255,220,60)}):Play()
    end)
    minimize.MouseLeave:Connect(function()
        tween:Create(minimize, EASE.Fast, {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween:Create(Main, EASE.Medium, {Size = UDim2.new(0, 525, 0, 29)}):Play()
        else
            tween:Create(Main, EASE.Bounce, {Size = UDim2.new(0, 525, 0, 318)}):Play()
        end
    end)

    -- ── Side panel ───────────────────────────────────────────────────────────
    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(0, 0, 0.0911949649, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 6)
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    tabListing.Padding = UDim.new(0, 3)

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundTransparency = 1
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
    blurFrame.Size = UDim2.new(0, 376, 0, 289)
    blurFrame.ZIndex = 999

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundTransparency = 1
    infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
    infoContainer.Size = UDim2.new(0, 368, 0, 33)

    -- Live theme update loop
    coroutine.wrap(function()
        while task.wait() do
            Main.BackgroundColor3      = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3   = themeList.Header
            MainSide.BackgroundColor3  = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
        end
    end)()

    function Kavo:ChangeColor(prop, color)
        local map = {Background="Background", SchemeColor="SchemeColor", Header="Header", TextColor="TextColor", ElementColor="ElementColor"}
        if map[prop] then themeList[prop] = color end
    end

    -- ═══════════════════════════════════════════════════════════════════
    local Tabs = {}
    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton  = Instance.new("TextButton")
        local UICorner   = Instance.new("UICorner")
        local tabDot     = Instance.new("Frame")       -- ← indikator aktif
        local page       = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            tween:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
            }):Play()
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, 0, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 4
        page.Visible = false
        page.ScrollBarImageColor3 = themeList.SchemeColor

        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = "  " .. tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 13
        tabButton.BackgroundTransparency = 1
        tabButton.TextXAlignment = Enum.TextXAlignment.Left

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton

        -- Active dot
        tabDot.Name = "activeDot"
        tabDot.Parent = tabButton
        tabDot.Size = UDim2.new(0, 3, 0, 16)
        tabDot.Position = UDim2.new(0, 0, 0.5, -8)
        tabDot.BackgroundColor3 = themeList.SchemeColor
        tabDot.BorderSizePixel = 0
        tabDot.BackgroundTransparency = 1
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = tabDot

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0.85
            tween:Create(tabDot, EASE.Fast, {BackgroundTransparency = 0}):Play()
            UpdateSize()
        end

        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            -- Sembunyikan semua page
            for _, v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            -- Reset semua tab style
            for _, v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    tween:Create(v, EASE.Fast, {BackgroundTransparency = 1}):Play()
                    local dot = v:FindFirstChild("activeDot")
                    if dot then tween:Create(dot, EASE.Fast, {BackgroundTransparency = 1}):Play() end
                end
            end
            -- Aktifkan tab ini
            tween:Create(tabButton, EASE.Fast, {BackgroundTransparency = 0.85}):Play()
            tween:Create(tabDot, EASE.Fast, {BackgroundTransparency = 0}):Play()
        end)

        tabButton.MouseEnter:Connect(function()
            if tabButton.BackgroundTransparency > 0.5 then
                tween:Create(tabButton, EASE.Fast, {BackgroundTransparency = 0.93}):Play()
            end
        end)
        tabButton.MouseLeave:Connect(function()
            if tabButton.BackgroundTransparency < 0.5 then return end
            tween:Create(tabButton, EASE.Fast, {BackgroundTransparency = 1}):Play()
        end)

        coroutine.wrap(function()
            while task.wait() do
                page.BackgroundColor3 = themeList.Background
                page.ScrollBarImageColor3 = themeList.SchemeColor
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
                tabDot.BackgroundColor3 = themeList.SchemeColor
            end
        end)()

        local Sections = {}
        local focusing = false
        local viewDe   = false

        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            hidden  = hidden  or false
            local sectionFunctions = {}

            local sectionFrame    = Instance.new("Frame")
            local sectionList     = Instance.new("UIListLayout")
            local sectionHead     = Instance.new("Frame")
            local sHeadCorner     = Instance.new("UICorner")
            local sectionName     = Instance.new("TextLabel")
            local sectionInners   = Instance.new("Frame")
            local sectionElList   = Instance.new("UIListLayout")

            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background
            sectionFrame.BorderSizePixel = 0

            sectionList.Parent = sectionFrame
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 5)

            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            sectionHead.Size = UDim2.new(0, 352, 0, 33)
            sectionHead.Visible = not hidden

            sHeadCorner.CornerRadius = UDim.new(0, 5)
            sHeadCorner.Parent = sectionHead

            sectionName.Parent = sectionHead
            sectionName.BackgroundTransparency = 1
            sectionName.Position = UDim2.new(0.02, 0, 0, 0)
            sectionName.Size = UDim2.new(0.98, 0, 1, 0)
            sectionName.Font = Enum.Font.GothamBold
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            sectionName.TextSize = 13
            sectionName.TextXAlignment = Enum.TextXAlignment.Left

            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundTransparency = 1
            sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

            sectionElList.Parent = sectionInners
            sectionElList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElList.Padding = UDim.new(0, 3)

            coroutine.wrap(function()
                while task.wait() do
                    sectionFrame.BackgroundColor3 = themeList.Background
                    sectionHead.BackgroundColor3  = themeList.SchemeColor
                    sectionName.TextColor3        = themeList.TextColor
                end
            end)()

            local function updateSectionFrame()
                local innerSc = sectionElList.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionList.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
            updateSectionFrame()
            UpdateSize()

            -- ─── Elements ──────────────────────────────────────────────────────
            local Elements = {}

            -- Helper: ripple effect
            local function makeRipple(btn, ms, themeL)
                local c = Instance.new("ImageLabel")
                c.BackgroundTransparency = 1
                c.Image = "http://www.roblox.com/asset/?id=4560909609"
                c.ImageColor3 = themeL.SchemeColor
                c.ImageTransparency = 0.55
                c.Parent = btn
                local x = ms.X - btn.AbsolutePosition.X
                local y = ms.Y - btn.AbsolutePosition.Y
                c.Position = UDim2.new(0, x, 0, y)
                local size = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.6
                c:TweenSizeAndPosition(UDim2.new(0,size,0,size), UDim2.new(0.5,-size/2,0.5,-size/2),"Out","Quad",0.35,true)
                for _ = 1, 10 do c.ImageTransparency = c.ImageTransparency + 0.04; task.wait(0.035/10) end
                c:Destroy()
            end

            -- Helper: tooltip info
            local function makeTooltip(tipText)
                local moreInfo = Instance.new("TextLabel")
                local uic      = Instance.new("UICorner")
                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.SchemeColor.R*255-14,0,255),
                    math.clamp(themeList.SchemeColor.G*255-17,0,255),
                    math.clamp(themeList.SchemeColor.B*255-13,0,255)
                )
                moreInfo.Position = UDim2.new(0,0,2,0)
                moreInfo.Size = UDim2.new(0,353,0,33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  " .. tipText
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 13
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                uic.CornerRadius = UDim.new(0,5)
                uic.Parent = moreInfo
                return moreInfo
            end

            local function handleViewInfo(viewInfo, moreInfo, elementBtn)
                viewInfo.MouseButton1Click:Connect(function()
                    if viewDe then return end
                    viewDe = true
                    focusing = true
                    for _,v in next, infoContainer:GetChildren() do
                        if v ~= moreInfo then tween:Create(v, EASE.Fast, {Position = UDim2.new(0,0,2,0)}):Play() end
                    end
                    tween:Create(moreInfo, EASE.Bounce, {Position = UDim2.new(0,0,0,0)}):Play()
                    tween:Create(blurFrame, EASE.Fast, {BackgroundTransparency = 0.5}):Play()
                    task.wait(1.8)
                    focusing = false
                    tween:Create(moreInfo, EASE.Fast, {Position = UDim2.new(0,0,2,0)}):Play()
                    tween:Create(blurFrame, EASE.Fast, {BackgroundTransparency = 1}):Play()
                    task.wait(0.01)
                    viewDe = false
                end)
            end

            -- ── Button ─────────────────────────────────────────────────────────
            function Elements:NewButton(bname, tipInf, callback)
                local BtnFunc = {}
                bname    = bname    or "Button"
                tipInf   = tipInf   or "Click to trigger"
                callback = callback or function() end

                local btn      = Instance.new("TextButton")
                local uic      = Instance.new("UICorner")
                local btnInfo  = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch    = Instance.new("ImageLabel")
                local moreInfo = makeTooltip(tipInf)

                btn.Name = bname
                btn.Parent = sectionInners
                btn.BackgroundColor3 = themeList.ElementColor
                btn.ClipsDescendants = true
                btn.Size = UDim2.new(0, 352, 0, 33)
                btn.AutoButtonColor = false
                btn.Font = Enum.Font.SourceSans
                btn.Text = ""

                uic.CornerRadius = UDim.new(0,5); uic.Parent = btn

                viewInfo.Parent = btn; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                touch.Parent = btn; touch.BackgroundTransparency = 1
                touch.Position = UDim2.new(0.02,0,0.18,0); touch.Size = UDim2.new(0,21,0,21)
                touch.Image = "rbxassetid://3926305904"; touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(84,204); touch.ImageRectSize = Vector2.new(36,36)

                btnInfo.Parent = btn; btnInfo.BackgroundTransparency = 1
                btnInfo.Position = UDim2.new(0.097,0,0.273,0); btnInfo.Size = UDim2.new(0,314,0,14)
                btnInfo.Font = Enum.Font.GothamSemibold; btnInfo.Text = bname; btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor; btnInfo.TextSize = 13
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, btn)

                local hovering = false
                btn.MouseEnter:Connect(function()
                    if focusing then return end
                    tween:Create(btn, EASE.Fast, {BackgroundColor3 = Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering = true
                end)
                btn.MouseLeave:Connect(function()
                    if focusing then return end
                    tween:Create(btn, EASE.Fast, {BackgroundColor3 = themeList.ElementColor}):Play(); hovering = false
                end)
                local ms = game.Players.LocalPlayer:GetMouse()
                btn.MouseButton1Click:Connect(function()
                    if focusing then
                        for _,v in next, infoContainer:GetChildren() do tween:Create(v,EASE.Fast,{Position=UDim2.new(0,0,2,0)}):Play() end
                        tween:Create(blurFrame,EASE.Fast,{BackgroundTransparency=1}):Play()
                        focusing = false; return
                    end
                    pcall(callback)
                    makeRipple(btn, ms, themeList)
                end)
                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then btn.BackgroundColor3 = themeList.ElementColor end
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        touch.ImageColor3    = themeList.SchemeColor
                        btnInfo.TextColor3   = themeList.TextColor
                        moreInfo.TextColor3  = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()
                function BtnFunc:UpdateButton(t) btnInfo.Text = t end
                return BtnFunc
            end

            -- ── Toggle ─────────────────────────────────────────────────────────
            function Elements:NewToggle(tname, nTip, callback)
                local TogFunc = {}
                tname    = tname    or "Toggle"
                nTip     = nTip     or "Toggle tip"
                callback = callback or function() end
                local toggled = false

                local toggleEl   = Instance.new("TextButton")
                local uic        = Instance.new("UICorner")
                local togDisabled = Instance.new("ImageLabel")
                local togEnabled  = Instance.new("ImageLabel")
                local togName    = Instance.new("TextLabel")
                local viewInfo   = Instance.new("ImageButton")
                local moreInfo   = makeTooltip(nTip)

                toggleEl.Parent = sectionInners; toggleEl.BackgroundColor3 = themeList.ElementColor
                toggleEl.ClipsDescendants = true; toggleEl.Size = UDim2.new(0,352,0,33)
                toggleEl.AutoButtonColor = false; toggleEl.Font = Enum.Font.SourceSans; toggleEl.Text = ""

                uic.CornerRadius = UDim.new(0,5); uic.Parent = toggleEl

                togDisabled.Parent = toggleEl; togDisabled.BackgroundTransparency = 1
                togDisabled.Position = UDim2.new(0.02,0,0.18,0); togDisabled.Size = UDim2.new(0,21,0,21)
                togDisabled.Image = "rbxassetid://3926309567"; togDisabled.ImageColor3 = themeList.SchemeColor
                togDisabled.ImageRectOffset = Vector2.new(628,420); togDisabled.ImageRectSize = Vector2.new(48,48)

                togEnabled.Parent = toggleEl; togEnabled.BackgroundTransparency = 1
                togEnabled.Position = UDim2.new(0.02,0,0.18,0); togEnabled.Size = UDim2.new(0,21,0,21)
                togEnabled.Image = "rbxassetid://3926309567"; togEnabled.ImageColor3 = themeList.SchemeColor
                togEnabled.ImageRectOffset = Vector2.new(784,420); togEnabled.ImageRectSize = Vector2.new(48,48)
                togEnabled.ImageTransparency = 1

                togName.Parent = toggleEl; togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0.097,0,0.273,0); togName.Size = UDim2.new(0,288,0,14)
                togName.Font = Enum.Font.GothamSemibold; togName.Text = tname; togName.RichText = true
                togName.TextColor3 = themeList.TextColor; togName.TextSize = 13
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Parent = toggleEl; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, toggleEl)

                local ms = game.Players.LocalPlayer:GetMouse()
                local hovering = false
                toggleEl.MouseEnter:Connect(function()
                    if focusing then return end
                    tween:Create(toggleEl, EASE.Fast, {BackgroundColor3 = Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering = true
                end)
                toggleEl.MouseLeave:Connect(function()
                    if focusing then return end
                    tween:Create(toggleEl, EASE.Fast, {BackgroundColor3 = themeList.ElementColor}):Play(); hovering = false
                end)
                toggleEl.MouseButton1Click:Connect(function()
                    if focusing then
                        for _,v in next, infoContainer:GetChildren() do tween:Create(v,EASE.Fast,{Position=UDim2.new(0,0,2,0)}):Play() end
                        tween:Create(blurFrame,EASE.Fast,{BackgroundTransparency=1}):Play()
                        focusing = false; return
                    end
                    toggled = not toggled
                    tween:Create(togEnabled, EASE.Fast, {ImageTransparency = toggled and 0 or 1}):Play()
                    pcall(callback, toggled)
                    makeRipple(toggleEl, ms, themeList)
                end)
                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then toggleEl.BackgroundColor3 = themeList.ElementColor end
                        togDisabled.ImageColor3 = themeList.SchemeColor
                        togEnabled.ImageColor3  = themeList.SchemeColor
                        togName.TextColor3      = themeList.TextColor
                        viewInfo.ImageColor3    = themeList.SchemeColor
                        moreInfo.TextColor3     = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()
                function TogFunc:UpdateToggle(newText, isOn)
                    if newText and typeof(newText)=="string" then togName.Text = newText end
                    if isOn ~= nil then
                        toggled = isOn
                        tween:Create(togEnabled, EASE.Fast, {ImageTransparency = isOn and 0 or 1}):Play()
                        pcall(callback, toggled)
                    end
                end
                return TogFunc
            end

            -- ── Slider ─────────────────────────────────────────────────────────
            function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
                slidInf  = slidInf  or "Slider"
                slidTip  = slidTip  or "Slider tip"
                maxvalue = maxvalue or 100
                minvalue = minvalue or 0
                callback = callback or function() end

                local sliderEl  = Instance.new("TextButton")
                local uic       = Instance.new("UICorner")
                local togName   = Instance.new("TextLabel")
                local viewInfo  = Instance.new("ImageButton")
                local sliderBtn = Instance.new("TextButton")
                local uic2      = Instance.new("UICorner")
                local sliderDrag = Instance.new("Frame")
                local uic3      = Instance.new("UICorner")
                local write     = Instance.new("ImageLabel")
                local val       = Instance.new("TextLabel")
                local moreInfo  = makeTooltip(slidTip)

                sliderEl.Parent = sectionInners; sliderEl.BackgroundColor3 = themeList.ElementColor
                sliderEl.ClipsDescendants = true; sliderEl.Size = UDim2.new(0,352,0,33)
                sliderEl.AutoButtonColor = false; sliderEl.Text = ""

                uic.CornerRadius = UDim.new(0,5); uic.Parent = sliderEl

                togName.Parent = sliderEl; togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0.097,0,0.273,0); togName.Size = UDim2.new(0,138,0,14)
                togName.Font = Enum.Font.GothamSemibold; togName.Text = slidInf; togName.RichText = true
                togName.TextColor3 = themeList.TextColor; togName.TextSize = 13
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Parent = sliderEl; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                sliderBtn.Parent = sliderEl; sliderBtn.BorderSizePixel = 0
                sliderBtn.Position = UDim2.new(0.489,0,0.394,0); sliderBtn.Size = UDim2.new(0,149,0,6)
                sliderBtn.AutoButtonColor = false; sliderBtn.Text = ""
                sliderBtn.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255+8,0,255),
                    math.clamp(themeList.ElementColor.G*255+8,0,255),
                    math.clamp(themeList.ElementColor.B*255+8,0,255)
                )
                uic2.CornerRadius = UDim.new(1,0); uic2.Parent = sliderBtn

                sliderDrag.Parent = sliderBtn; sliderDrag.BorderSizePixel = 0
                sliderDrag.BackgroundColor3 = themeList.SchemeColor
                sliderDrag.Size = UDim2.new(0.3, 0, 1, 0)
                uic3.CornerRadius = UDim.new(1,0); uic3.Parent = sliderDrag

                write.Parent = sliderEl; write.BackgroundTransparency = 1
                write.Position = UDim2.new(0.02,0,0.18,0); write.Size = UDim2.new(0,21,0,21)
                write.Image = "rbxassetid://3926307971"; write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(404,164); write.ImageRectSize = Vector2.new(36,36)

                val.Parent = sliderEl; val.BackgroundTransparency = 1
                val.Position = UDim2.new(0.352,0,0.273,0); val.Size = UDim2.new(0,41,0,14)
                val.Font = Enum.Font.GothamSemibold; val.Text = tostring(minvalue)
                val.TextColor3 = themeList.TextColor; val.TextSize = 13; val.TextTransparency = 1
                val.TextXAlignment = Enum.TextXAlignment.Right

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, sliderEl)

                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis   = game:GetService("UserInputService")
                local hovering = false

                sliderEl.MouseEnter:Connect(function()
                    if focusing then return end
                    tween:Create(sliderEl,EASE.Fast,{BackgroundColor3=Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering=true
                end)
                sliderEl.MouseLeave:Connect(function()
                    if focusing then return end
                    tween:Create(sliderEl,EASE.Fast,{BackgroundColor3=themeList.ElementColor}):Play(); hovering=false
                end)

                local moveConn, relConn
                sliderBtn.MouseButton1Down:Connect(function()
                    if focusing then return end
                    tween:Create(val,EASE.Fast,{TextTransparency=0}):Play()
                    local function compute()
                        return math.floor((((maxvalue-minvalue)/149)*sliderDrag.AbsoluteSize.X)+minvalue)
                    end
                    sliderDrag:TweenSize(UDim2.new(0,math.clamp(mouse.X-sliderDrag.AbsolutePosition.X,0,149),1,0),"Out","Quint",0.05,true)
                    moveConn = mouse.Move:Connect(function()
                        local v = compute()
                        val.Text = tostring(v)
                        pcall(callback, v)
                        sliderDrag:TweenSize(UDim2.new(0,math.clamp(mouse.X-sliderDrag.AbsolutePosition.X,0,149),1,0),"Out","Quint",0.05,true)
                    end)
                    relConn = uis.InputEnded:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                            val.Text = tostring(compute())
                            pcall(callback, compute())
                            tween:Create(val,EASE.Fast,{TextTransparency=1}):Play()
                            moveConn:Disconnect(); relConn:Disconnect()
                        end
                    end)
                end)

                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then sliderEl.BackgroundColor3 = themeList.ElementColor end
                        togName.TextColor3    = themeList.TextColor
                        val.TextColor3        = themeList.TextColor
                        write.ImageColor3     = themeList.SchemeColor
                        viewInfo.ImageColor3  = themeList.SchemeColor
                        sliderDrag.BackgroundColor3 = themeList.SchemeColor
                        moreInfo.TextColor3   = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()
            end

            -- ── Dropdown ───────────────────────────────────────────────────────
            function Elements:NewDropdown(dropname, dropinf, list, callback)
                local DropFunc = {}
                dropname = dropname or "Dropdown"
                list     = list     or {}
                dropinf  = dropinf  or "Dropdown info"
                callback = callback or function() end
                local opened = false

                local dropFrame  = Instance.new("Frame")
                local dropOpen   = Instance.new("TextButton")
                local listImg    = Instance.new("ImageLabel")
                local itemTb     = Instance.new("TextLabel")
                local viewInfo   = Instance.new("ImageButton")
                local uic        = Instance.new("UICorner")
                local uiList     = Instance.new("UIListLayout")
                local moreInfo   = makeTooltip(dropinf)
                local ms         = game.Players.LocalPlayer:GetMouse()

                dropFrame.Parent = sectionInners; dropFrame.BackgroundColor3 = themeList.Background
                dropFrame.BorderSizePixel = 0; dropFrame.Size = UDim2.new(0,352,0,33); dropFrame.ClipsDescendants = true

                dropOpen.Parent = dropFrame; dropOpen.BackgroundColor3 = themeList.ElementColor
                dropOpen.Size = UDim2.new(0,352,0,33); dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans; dropOpen.Text = ""; dropOpen.ClipsDescendants = true

                listImg.Parent = dropOpen; listImg.BackgroundTransparency = 1
                listImg.Position = UDim2.new(0.02,0,0.18,0); listImg.Size = UDim2.new(0,21,0,21)
                listImg.Image = "rbxassetid://3926305904"; listImg.ImageColor3 = themeList.SchemeColor
                listImg.ImageRectOffset = Vector2.new(644,364); listImg.ImageRectSize = Vector2.new(36,36)

                itemTb.Parent = dropOpen; itemTb.BackgroundTransparency = 1
                itemTb.Position = UDim2.new(0.097,0,0.273,0); itemTb.Size = UDim2.new(0,138,0,14)
                itemTb.Font = Enum.Font.GothamSemibold; itemTb.Text = dropname; itemTb.RichText = true
                itemTb.TextColor3 = themeList.TextColor; itemTb.TextSize = 13
                itemTb.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Parent = dropOpen; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                uic.CornerRadius = UDim.new(0,5); uic.Parent = dropOpen
                uiList.Parent = dropFrame; uiList.SortOrder = Enum.SortOrder.LayoutOrder; uiList.Padding = UDim.new(0,3)

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, dropOpen)

                local hovering = false
                dropOpen.MouseEnter:Connect(function()
                    if focusing then return end
                    tween:Create(dropOpen,EASE.Fast,{BackgroundColor3=Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering=true
                end)
                dropOpen.MouseLeave:Connect(function()
                    if focusing then return end
                    tween:Create(dropOpen,EASE.Fast,{BackgroundColor3=themeList.ElementColor}):Play(); hovering=false
                end)
                dropOpen.MouseButton1Click:Connect(function()
                    if focusing then return end
                    opened = not opened
                    if opened then
                        dropFrame:TweenSize(UDim2.new(0,352,0,uiList.AbsoluteContentSize.Y),"Out","Quint",0.15,true)
                    else
                        dropFrame:TweenSize(UDim2.new(0,352,0,33),"Out","Quint",0.15)
                    end
                    task.wait(0.17); updateSectionFrame(); UpdateSize()
                    makeRipple(dropOpen, ms, themeList)
                end)

                local function addOption(v)
                    local opt    = Instance.new("TextButton")
                    local ouic   = Instance.new("UICorner")
                    opt.Parent = dropFrame; opt.BackgroundColor3 = themeList.ElementColor
                    opt.Size = UDim2.new(0,352,0,30); opt.AutoButtonColor = false
                    opt.Font = Enum.Font.GothamSemibold; opt.Text = "  "..v; opt.RichText = true
                    opt.TextColor3 = themeList.TextColor; opt.TextSize = 12
                    opt.TextXAlignment = Enum.TextXAlignment.Left; opt.ClipsDescendants = true
                    ouic.CornerRadius = UDim.new(0,4); ouic.Parent = opt
                    local oHover = false
                    opt.MouseEnter:Connect(function() tween:Create(opt,EASE.Fast,{BackgroundColor3=Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); oHover=true end)
                    opt.MouseLeave:Connect(function() tween:Create(opt,EASE.Fast,{BackgroundColor3=themeList.ElementColor}):Play(); oHover=false end)
                    opt.MouseButton1Click:Connect(function()
                        if focusing then return end
                        opened = false; callback(v); itemTb.Text = v
                        dropFrame:TweenSize(UDim2.new(0,352,0,33),"Out","Quint",0.15)
                        task.wait(0.17); updateSectionFrame(); UpdateSize()
                        makeRipple(opt, ms, themeList)
                    end)
                    coroutine.wrap(function()
                        while task.wait() do
                            if not oHover then opt.BackgroundColor3 = themeList.ElementColor end
                            opt.TextColor3 = themeList.TextColor
                        end
                    end)()
                end

                for _,v in next, list do addOption(v) end

                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then dropOpen.BackgroundColor3 = themeList.ElementColor end
                        dropFrame.BackgroundColor3 = themeList.Background
                        listImg.ImageColor3  = themeList.SchemeColor
                        itemTb.TextColor3    = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.TextColor3  = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()

                function DropFunc:Refresh(newList)
                    for _,v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" or v:IsA("TextButton") and v ~= dropOpen then v:Destroy() end
                    end
                    for _,v in next, (newList or {}) do addOption(v) end
                    if opened then
                        dropFrame:TweenSize(UDim2.new(0,352,0,uiList.AbsoluteContentSize.Y),"Out","Quint",0.15,true)
                    else
                        dropFrame:TweenSize(UDim2.new(0,352,0,33),"Out","Quint",0.15)
                    end
                    task.wait(0.17); updateSectionFrame(); UpdateSize()
                end
                return DropFunc
            end

            -- ── Label ──────────────────────────────────────────────────────────
            function Elements:NewLabel(labelTitle)
                local LblFunc = {}
                local lbl = Instance.new("TextLabel")
                local uic = Instance.new("UICorner")
                lbl.Parent = sectionInners; lbl.BackgroundColor3 = themeList.SchemeColor
                lbl.BorderSizePixel = 0; lbl.ClipsDescendants = true
                lbl.Size = UDim2.new(0,352,0,33)
                lbl.Font = Enum.Font.Gotham; lbl.Text = "  "..labelTitle; lbl.RichText = true
                lbl.TextColor3 = themeList.TextColor; lbl.TextSize = 13
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                uic.CornerRadius = UDim.new(0,5); uic.Parent = lbl
                coroutine.wrap(function()
                    while task.wait() do
                        lbl.BackgroundColor3 = themeList.SchemeColor
                        lbl.TextColor3 = themeList.TextColor
                    end
                end)()
                updateSectionFrame(); UpdateSize()
                function LblFunc:UpdateLabel(t) lbl.Text = "  "..t end
                return LblFunc
            end

            -- ── TextBox ────────────────────────────────────────────────────────
            function Elements:NewTextBox(tname, tTip, callback)
                tname    = tname    or "Textbox"
                tTip     = tTip     or "Enter a value"
                callback = callback or function() end

                local tbEl    = Instance.new("TextButton")
                local uic     = Instance.new("UICorner")
                local viewInfo = Instance.new("ImageButton")
                local write   = Instance.new("ImageLabel")
                local tb      = Instance.new("TextBox")
                local uic2    = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local moreInfo = makeTooltip(tTip)

                tbEl.Parent = sectionInners; tbEl.BackgroundColor3 = themeList.ElementColor
                tbEl.ClipsDescendants = true; tbEl.Size = UDim2.new(0,352,0,33)
                tbEl.AutoButtonColor = false; tbEl.Text = ""
                uic.CornerRadius = UDim.new(0,5); uic.Parent = tbEl

                write.Parent = tbEl; write.BackgroundTransparency = 1
                write.Position = UDim2.new(0.02,0,0.18,0); write.Size = UDim2.new(0,21,0,21)
                write.Image = "rbxassetid://3926305904"; write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(324,604); write.ImageRectSize = Vector2.new(36,36)

                togName.Parent = tbEl; togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0.097,0,0.273,0); togName.Size = UDim2.new(0,138,0,14)
                togName.Font = Enum.Font.GothamSemibold; togName.Text = tname; togName.RichText = true
                togName.TextColor3 = themeList.TextColor; togName.TextSize = 13
                togName.TextXAlignment = Enum.TextXAlignment.Left

                tb.Parent = tbEl; tb.BorderSizePixel = 0; tb.ClipsDescendants = true
                tb.Position = UDim2.new(0.489,0,0.212,0); tb.Size = UDim2.new(0,150,0,18); tb.ZIndex = 99
                tb.ClearTextOnFocus = false; tb.Font = Enum.Font.Gotham
                tb.PlaceholderText = "Type here!"; tb.Text = ""; tb.TextSize = 12
                tb.TextColor3 = themeList.SchemeColor; tb.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255-6,0,255),
                    math.clamp(themeList.ElementColor.G*255-6,0,255),
                    math.clamp(themeList.ElementColor.B*255-7,0,255)
                )
                uic2.CornerRadius = UDim.new(0,4); uic2.Parent = tb

                viewInfo.Parent = tbEl; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, tbEl)

                local hovering = false
                tbEl.MouseEnter:Connect(function()
                    if focusing then return end
                    tween:Create(tbEl,EASE.Fast,{BackgroundColor3=Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering=true
                end)
                tbEl.MouseLeave:Connect(function()
                    if focusing then return end
                    tween:Create(tbEl,EASE.Fast,{BackgroundColor3=themeList.ElementColor}):Play(); hovering=false
                end)
                tb.FocusLost:Connect(function(enter)
                    if enter then callback(tb.Text); task.wait(0.18); tb.Text = "" end
                end)

                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then tbEl.BackgroundColor3 = themeList.ElementColor end
                        tb.TextColor3 = themeList.SchemeColor
                        tb.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255-6,0,255),
                            math.clamp(themeList.ElementColor.G*255-6,0,255),
                            math.clamp(themeList.ElementColor.B*255-7,0,255)
                        )
                        write.ImageColor3   = themeList.SchemeColor
                        togName.TextColor3  = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.TextColor3  = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()
            end

            -- ── Keybind ────────────────────────────────────────────────────────
            function Elements:NewKeybind(keytext, keyinf, firstKey, callback)
                keytext  = keytext  or "Keybind"
                keyinf   = keyinf   or "Keybind info"
                callback = callback or function() end
                local oldKey = firstKey and firstKey.Name or "F"

                local kbEl    = Instance.new("TextButton")
                local uic     = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local keyDisp = Instance.new("TextLabel")
                local touch   = Instance.new("ImageLabel")
                local viewInfo = Instance.new("ImageButton")
                local moreInfo = makeTooltip(keyinf)
                local ms       = game.Players.LocalPlayer:GetMouse()
                local uis      = game:GetService("UserInputService")

                kbEl.Parent = sectionInners; kbEl.BackgroundColor3 = themeList.ElementColor
                kbEl.ClipsDescendants = true; kbEl.Size = UDim2.new(0,352,0,33)
                kbEl.AutoButtonColor = false; kbEl.Text = ""
                uic.CornerRadius = UDim.new(0,5); uic.Parent = kbEl

                touch.Parent = kbEl; touch.BackgroundTransparency = 1
                touch.Position = UDim2.new(0.02,0,0.18,0); touch.Size = UDim2.new(0,21,0,21)
                touch.Image = "rbxassetid://3926305904"; touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(364,284); touch.ImageRectSize = Vector2.new(36,36)

                togName.Parent = kbEl; togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0.097,0,0.273,0); togName.Size = UDim2.new(0,222,0,14)
                togName.Font = Enum.Font.GothamSemibold; togName.Text = keytext; togName.RichText = true
                togName.TextColor3 = themeList.TextColor; togName.TextSize = 13
                togName.TextXAlignment = Enum.TextXAlignment.Left

                keyDisp.Parent = kbEl; keyDisp.BackgroundTransparency = 1
                keyDisp.Position = UDim2.new(0.727,0,0.273,0); keyDisp.Size = UDim2.new(0,70,0,14)
                keyDisp.Font = Enum.Font.GothamSemibold; keyDisp.Text = oldKey
                keyDisp.TextColor3 = themeList.SchemeColor; keyDisp.TextSize = 13
                keyDisp.TextXAlignment = Enum.TextXAlignment.Right

                viewInfo.Parent = kbEl; viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(0.93,0,0.15,0); viewInfo.Size = UDim2.new(0,23,0,23); viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"; viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764,764); viewInfo.ImageRectSize = Vector2.new(36,36)

                updateSectionFrame(); UpdateSize()
                handleViewInfo(viewInfo, moreInfo, kbEl)

                kbEl.MouseButton1Click:connect(function()
                    if focusing then return end
                    keyDisp.Text = ". . ."
                    local a = uis.InputBegan:wait()
                    if a.KeyCode.Name ~= "Unknown" then
                        oldKey = a.KeyCode.Name
                        keyDisp.Text = oldKey
                    else
                        keyDisp.Text = oldKey
                    end
                    makeRipple(kbEl, ms, themeList)
                end)
                uis.InputBegan:connect(function(cur, gp)
                    if not gp and cur.KeyCode.Name == oldKey then pcall(callback) end
                end)

                local hovering = false
                kbEl.MouseEnter:Connect(function() if focusing then return end
                    tween:Create(kbEl,EASE.Fast,{BackgroundColor3=Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255+10,0,255),
                        math.clamp(themeList.ElementColor.G*255+11,0,255),
                        math.clamp(themeList.ElementColor.B*255+12,0,255)
                    )}):Play(); hovering=true end)
                kbEl.MouseLeave:Connect(function() if focusing then return end
                    tween:Create(kbEl,EASE.Fast,{BackgroundColor3=themeList.ElementColor}):Play(); hovering=false end)

                coroutine.wrap(function()
                    while task.wait() do
                        if not hovering then kbEl.BackgroundColor3 = themeList.ElementColor end
                        touch.ImageColor3   = themeList.SchemeColor
                        keyDisp.TextColor3  = themeList.SchemeColor
                        togName.TextColor3  = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.TextColor3  = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255)
                        )
                    end
                end)()
            end

            return Elements
        end
        return Sections
    end
    return Tabs
