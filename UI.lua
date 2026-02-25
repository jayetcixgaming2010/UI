local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

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

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

-- ══════════════════════════════════════════
--  THEME DEFINITIONS  (updated defaults)
-- ══════════════════════════════════════════
local themes = {
    SchemeColor  = Color3.fromRGB(99, 125, 255),   -- blue accent
    Background   = Color3.fromRGB(20, 21, 28),      -- very dark bg
    Header       = Color3.fromRGB(14, 15, 20),      -- darker header
    TextColor    = Color3.fromRGB(220, 220, 235),   -- soft white text
    ElementColor = Color3.fromRGB(28, 30, 40),      -- element bg
}

local themeStyles = {
    DarkTheme = {
        SchemeColor  = Color3.fromRGB(64, 64, 64),
        Background   = Color3.fromRGB(0, 0, 0),
        Header       = Color3.fromRGB(0, 0, 0),
        TextColor    = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor  = Color3.fromRGB(130, 130, 200),
        Background   = Color3.fromRGB(240,240,248),
        Header       = Color3.fromRGB(200, 200, 215),
        TextColor    = Color3.fromRGB(20,20,40),
        ElementColor = Color3.fromRGB(210, 210, 228)
    },
    BloodTheme = {
        SchemeColor  = Color3.fromRGB(220, 30, 30),
        Background   = Color3.fromRGB(10, 8, 8),
        Header       = Color3.fromRGB(5, 4, 4),
        TextColor    = Color3.fromRGB(255,220,220),
        ElementColor = Color3.fromRGB(22, 14, 14)
    },
    GrapeTheme = {
        SchemeColor  = Color3.fromRGB(170, 80, 220),
        Background   = Color3.fromRGB(44, 34, 52),
        Header       = Color3.fromRGB(28, 20, 36),
        TextColor    = Color3.fromRGB(240,215,255),
        ElementColor = Color3.fromRGB(58, 44, 70)
    },
    Ocean = {
        SchemeColor  = Color3.fromRGB(80, 140, 255),
        Background   = Color3.fromRGB(12, 22, 48),
        Header       = Color3.fromRGB(18, 30, 60),
        TextColor    = Color3.fromRGB(190, 210, 255),
        ElementColor = Color3.fromRGB(22, 38, 70)
    },
    Midnight = {
        SchemeColor  = Color3.fromRGB(30, 200, 170),
        Background   = Color3.fromRGB(22, 34, 48),
        Header       = Color3.fromRGB(30, 44, 60),
        TextColor    = Color3.fromRGB(200, 240, 235),
        ElementColor = Color3.fromRGB(34, 50, 68)
    },
    Sentinel = {
        SchemeColor  = Color3.fromRGB(230, 40, 75),
        Background   = Color3.fromRGB(26, 26, 26),
        Header       = Color3.fromRGB(18, 18, 18),
        TextColor    = Color3.fromRGB(120, 215, 145),
        ElementColor = Color3.fromRGB(22, 22, 22)
    },
    Synapse = {
        SchemeColor  = Color3.fromRGB(50, 52, 46),
        Background   = Color3.fromRGB(10, 12, 9),
        Header       = Color3.fromRGB(32, 34, 30),
        TextColor    = Color3.fromRGB(155, 105, 60),
        ElementColor = Color3.fromRGB(22, 22, 22)
    },
    Serpent = {
        SchemeColor  = Color3.fromRGB(0, 190, 70),
        Background   = Color3.fromRGB(20, 32, 26),
        Header       = Color3.fromRGB(12, 20, 16),
        TextColor    = Color3.fromRGB(200, 255, 215),
        ElementColor = Color3.fromRGB(18, 28, 22)
    },
    -- ✦ NEW THEMES ✦
    Neon = {
        SchemeColor  = Color3.fromRGB(0, 255, 200),
        Background   = Color3.fromRGB(8, 8, 14),
        Header       = Color3.fromRGB(5, 5, 10),
        TextColor    = Color3.fromRGB(200, 255, 245),
        ElementColor = Color3.fromRGB(14, 18, 28)
    },
    Rose = {
        SchemeColor  = Color3.fromRGB(255, 100, 160),
        Background   = Color3.fromRGB(24, 14, 20),
        Header       = Color3.fromRGB(16, 9, 14),
        TextColor    = Color3.fromRGB(255, 220, 235),
        ElementColor = Color3.fromRGB(36, 20, 30)
    },
    SapiDefault = {
        SchemeColor  = Color3.fromRGB(99, 125, 255),
        Background   = Color3.fromRGB(20, 21, 28),
        Header       = Color3.fromRGB(14, 15, 20),
        TextColor    = Color3.fromRGB(220, 220, 235),
        ElementColor = Color3.fromRGB(28, 30, 40)
    },
}

local SettingsT = {}
local Name = "KavoConfig.JSON"

pcall(function()
    if not pcall(function() readfile(Name) end) then
        writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
    end
    Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Kavo:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

-- ══════════════════════════════════════════
--  HELPER: glow stroke on element
-- ══════════════════════════════════════════
local function addStroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(99,125,255)
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.7
    s.Parent = parent
    return s
end

-- ══════════════════════════════════════════
--  MAIN CREATE FUNCTION
-- ══════════════════════════════════════════
function Kavo.CreateLib(kavName, themeList)
    if not themeList then themeList = themes end
    if type(themeList) == "string" then
        themeList = themeStyles[themeList] or themes
    else
        themeList.SchemeColor  = themeList.SchemeColor  or Color3.fromRGB(99,125,255)
        themeList.Background   = themeList.Background   or Color3.fromRGB(20,21,28)
        themeList.Header       = themeList.Header       or Color3.fromRGB(14,15,20)
        themeList.TextColor    = themeList.TextColor    or Color3.fromRGB(220,220,235)
        themeList.ElementColor = themeList.ElementColor or Color3.fromRGB(28,30,40)
    end

    local selectedTab
    kavName = kavName or "Library"
    table.insert(Kavo, kavName)

    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then v:Destroy() end
    end

    -- ── ScreenGui ──────────────────────────────
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = LibName
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- ── Main window  (bigger: 600×360) ─────────
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 600, 0, 360)
    -- entry animation
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5,0,0.5,0)
    tween:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0,600,0,360)
    }):Play()

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = Main

    -- outer glow stroke on main window
    addStroke(Main, themeList.SchemeColor, 1.5, 0.55)

    -- ── Header (32 px) ──────────────────────────
    local MainHeader = Instance.new("Frame")
    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(0, 600, 0, 32)

    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0, 8)
    hCorner.Parent = MainHeader

    local hCover = Instance.new("Frame") -- fill bottom gap of rounded corner
    hCover.Name = "coverup"
    hCover.Parent = MainHeader
    hCover.BackgroundColor3 = themeList.Header
    hCover.BorderSizePixel = 0
    hCover.Position = UDim2.new(0, 0, 0.75, 0)
    hCover.Size = UDim2.new(1, 0, 0, 8)

    -- accent line under header
    local accentLine = Instance.new("Frame")
    accentLine.Name = "accentLine"
    accentLine.Parent = MainHeader
    accentLine.BackgroundColor3 = themeList.SchemeColor
    accentLine.BorderSizePixel = 0
    accentLine.Position = UDim2.new(0, 0, 1, -2)
    accentLine.Size = UDim2.new(1, 0, 0, 2)

    -- dot decorations left side of header
    local dot1 = Instance.new("Frame")
    dot1.Size = UDim2.new(0,8,0,8)
    dot1.Position = UDim2.new(0,10,0.5,-4)
    dot1.BackgroundColor3 = Color3.fromRGB(255,95,87)
    dot1.BorderSizePixel = 0
    dot1.Parent = MainHeader
    Instance.new("UICorner").Parent = dot1
    local dot2 = Instance.new("Frame")
    dot2.Size = UDim2.new(0,8,0,8)
    dot2.Position = UDim2.new(0,24,0.5,-4)
    dot2.BackgroundColor3 = Color3.fromRGB(255,189,46)
    dot2.BorderSizePixel = 0
    dot2.Parent = MainHeader
    Instance.new("UICorner").Parent = dot2
    local dot3 = Instance.new("Frame")
    dot3.Size = UDim2.new(0,8,0,8)
    dot3.Position = UDim2.new(0,38,0.5,-4)
    dot3.BackgroundColor3 = Color3.fromRGB(39,201,63)
    dot3.BorderSizePixel = 0
    dot3.Parent = MainHeader
    Instance.new("UICorner").Parent = dot3

    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 60, 0, 0)
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left

    local close = Instance.new("ImageButton")
    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1
    close.Position = UDim2.new(1,-28,0.5,-10)
    close.Size = UDim2.new(0,20,0,20)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    close.ImageColor3 = Color3.fromRGB(255,80,80)
    close.MouseButton1Click:Connect(function()
        tween:Create(close, TweenInfo.new(0.1), {ImageTransparency=1}):Play()
        tween:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0,0,0,0),
            Position = UDim2.new(0.5,0,0.5,0)
        }):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)

    Kavo:DraggingEnabled(MainHeader, Main)

    -- ── Sidebar (170 px wide) ───────────────────
    local MainSide = Instance.new("Frame")
    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(0, 0, 0, 32)
    MainSide.Size = UDim2.new(0, 170, 1, -32)

    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 8)
    sideCorner.Parent = MainSide

    local sideCover = Instance.new("Frame")
    sideCover.BackgroundColor3 = themeList.Header
    sideCover.BorderSizePixel = 0
    sideCover.Position = UDim2.new(1,-8,0,0)
    sideCover.Size = UDim2.new(0,8,1,0)
    sideCover.Parent = MainSide

    -- sidebar label
    local sideLabel = Instance.new("TextLabel")
    sideLabel.Parent = MainSide
    sideLabel.BackgroundTransparency = 1
    sideLabel.Position = UDim2.new(0,10,0,8)
    sideLabel.Size = UDim2.new(1,-10,0,16)
    sideLabel.Font = Enum.Font.GothamBold
    sideLabel.Text = "NAVIGATION"
    sideLabel.TextColor3 = Color3.fromRGB(themeList.SchemeColor.R*255, themeList.SchemeColor.G*255, themeList.SchemeColor.B*255)
    sideLabel.TextSize = 10
    sideLabel.TextXAlignment = Enum.TextXAlignment.Left
    sideLabel.TextTransparency = 0.3

    local tabFrames = Instance.new("Frame")
    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1
    tabFrames.Position = UDim2.new(0, 8, 0, 30)
    tabFrames.Size = UDim2.new(1, -16, 1, -35)

    local tabListing = Instance.new("UIListLayout")
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    tabListing.Padding = UDim.new(0,4)

    -- ── Pages area ──────────────────────────────
    local pages = Instance.new("Frame")
    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundTransparency = 1
    pages.Position = UDim2.new(0, 178, 0, 36)
    pages.Size = UDim2.new(1, -186, 1, -44)

    local Pages = Instance.new("Folder")
    Pages.Name = "Pages"
    Pages.Parent = pages

    local blurFrame = Instance.new("Frame")
    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Size = UDim2.new(1,0,1,0)
    blurFrame.ZIndex = 999

    local infoContainer = Instance.new("Frame")
    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundTransparency = 1
    infoContainer.Position = UDim2.new(0, 178, 1, -36)
    infoContainer.Size = UDim2.new(1, -186, 0, 33)
    infoContainer.ClipsDescendants = true

    -- theme loop
    coroutine.wrap(function()
        while wait() do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            hCover.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            sideCover.BackgroundColor3 = themeList.Header
            accentLine.BackgroundColor3 = themeList.SchemeColor
            sideLabel.TextColor3 = themeList.SchemeColor
            title.TextColor3 = themeList.TextColor
        end
    end)()

    function Kavo:ChangeColor(prope, color)
        if prope == "Background"   then themeList.Background   = color
        elseif prope == "SchemeColor" then themeList.SchemeColor  = color
        elseif prope == "Header"   then themeList.Header       = color
        elseif prope == "TextColor"   then themeList.TextColor    = color
        elseif prope == "ElementColor"then themeList.ElementColor = color
        end
    end

    local Tabs = {}
    local first = true

    -- ════════════════════════════════════════
    --  NewTab
    -- ════════════════════════════════════════
    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"

        -- page scroll frame
        local page = Instance.new("ScrollingFrame")
        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.Size = UDim2.new(1,0,1,0)
        page.ScrollBarThickness = 4
        page.Visible = false
        page.ScrollBarImageColor3 = themeList.SchemeColor
        page.CanvasSize = UDim2.new(0,0,0,0)

        local pageListing = Instance.new("UIListLayout")
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0,6)

        local pagePad = Instance.new("UIPadding")
        pagePad.PaddingTop = UDim.new(0,4)
        pagePad.Parent = page

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            page.CanvasSize = UDim2.new(0,0,0,cS.Y+10)
        end

        -- tab button (sidebar)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.ElementColor
        tabButton.Size = UDim2.new(1,0,0,32)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = "  "..tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 13
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.BackgroundTransparency = 1

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0,6)
        tabCorner.Parent = tabButton

        -- left accent bar (visible when active)
        local tabAccent = Instance.new("Frame")
        tabAccent.Name = "tabAccent"
        tabAccent.Parent = tabButton
        tabAccent.BackgroundColor3 = themeList.SchemeColor
        tabAccent.BorderSizePixel = 0
        tabAccent.Position = UDim2.new(0,0,0.15,0)
        tabAccent.Size = UDim2.new(0,3,0.7,0)
        tabAccent.BackgroundTransparency = 1

        local acCorner = Instance.new("UICorner")
        acCorner.CornerRadius = UDim.new(0,4)
        acCorner.Parent = tabAccent

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            tabAccent.BackgroundTransparency = 0
            UpdateSize()
        end

        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for _,v in next, Pages:GetChildren() do v.Visible = false end
            page.Visible = true
            for _,v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    tween:Create(v, TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
                    if v:FindFirstChild("tabAccent") then
                        tween:Create(v.tabAccent, TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
                    end
                end
            end
            tween:Create(tabButton, TweenInfo.new(0.15), {BackgroundTransparency=0}):Play()
            tween:Create(tabAccent, TweenInfo.new(0.15), {BackgroundTransparency=0}):Play()
        end)

        -- hover effect
        tabButton.MouseEnter:Connect(function()
            if tabButton.BackgroundTransparency ~= 0 then
                tween:Create(tabButton, TweenInfo.new(0.1), {BackgroundTransparency=0.6}):Play()
            end
        end)
        tabButton.MouseLeave:Connect(function()
            if tabButton.BackgroundTransparency ~= 0 then
                tween:Create(tabButton, TweenInfo.new(0.1), {BackgroundTransparency=1}):Play()
            end
        end)

        coroutine.wrap(function()
            while wait() do
                page.ScrollBarImageColor3 = themeList.SchemeColor
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.ElementColor
                tabAccent.BackgroundColor3 = themeList.SchemeColor
            end
        end)()

        -- ════════════════════════════════════════
        --  NewSection
        -- ════════════════════════════════════════
        local Sections = {}
        local focusing = false
        local viewDe = false

        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            hidden = hidden or false

            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.BorderSizePixel = 0

            local sectionlistoknvm = Instance.new("UIListLayout")
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0,4)

            -- section header
            local sectionHead = Instance.new("Frame")
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.ElementColor
            sectionHead.Size = UDim2.new(1,0,0,30)
            sectionHead.Visible = not hidden

            local shCorner = Instance.new("UICorner")
            shCorner.CornerRadius = UDim.new(0,6)
            shCorner.Parent = sectionHead

            -- left accent on section header
            local shAccent = Instance.new("Frame")
            shAccent.BackgroundColor3 = themeList.SchemeColor
            shAccent.BorderSizePixel = 0
            shAccent.Position = UDim2.new(0,0,0.2,0)
            shAccent.Size = UDim2.new(0,3,0.6,0)
            shAccent.Parent = sectionHead
            Instance.new("UICorner").Parent = shAccent

            addStroke(sectionHead, themeList.SchemeColor, 1, 0.75)

            local sectionName = Instance.new("TextLabel")
            sectionName.Parent = sectionHead
            sectionName.BackgroundTransparency = 1
            sectionName.Position = UDim2.new(0, 12, 0, 0)
            sectionName.Size = UDim2.new(1,-12,1,0)
            sectionName.Font = Enum.Font.GothamBold
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            sectionName.TextSize = 13
            sectionName.TextXAlignment = Enum.TextXAlignment.Left

            local sectionInners = Instance.new("Frame")
            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundTransparency = 1
            sectionInners.Position = UDim2.new(0,0,0,0)

            local sectionElListing = Instance.new("UIListLayout")
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0,3)

            coroutine.wrap(function()
                while wait() do
                    sectionHead.BackgroundColor3 = themeList.ElementColor
                    shAccent.BackgroundColor3 = themeList.SchemeColor
                    sectionName.TextColor3 = themeList.TextColor
                end
            end)()

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1,0,0,innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(1,0,0,frameSc.Y)
            end
            updateSectionFrame()
            UpdateSize()

            -- ════════════════════
            --  ELEMENTS
            -- ════════════════════
            local Elements = {}

            -- ── shared helper: moreInfo tooltip ───
            local function makeMoreInfo(tipText)
                local mi = Instance.new("TextLabel")
                mi.Name = "TipMore"
                mi.Parent = infoContainer
                mi.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.SchemeColor.R*255-14,0,255),
                    math.clamp(themeList.SchemeColor.G*255-17,0,255),
                    math.clamp(themeList.SchemeColor.B*255-13,0,255))
                mi.Position = UDim2.new(0,0,2,0)
                mi.Size = UDim2.new(1,0,0,33)
                mi.ZIndex = 9
                mi.Font = Enum.Font.GothamSemibold
                mi.Text = "  "..tipText
                mi.RichText = true
                mi.TextColor3 = themeList.TextColor
                mi.TextSize = 13
                mi.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner").Parent = mi
                return mi
            end

            -- ── shared helper: viewInfo btn ────────
            local function makeViewInfo(parent)
                local vi = Instance.new("ImageButton")
                vi.Name = "viewInfo"
                vi.Parent = parent
                vi.BackgroundTransparency = 1
                vi.Position = UDim2.new(1,-26,0.5,-11)
                vi.Size = UDim2.new(0,22,0,22)
                vi.ZIndex = 2
                vi.Image = "rbxassetid://3926305904"
                vi.ImageColor3 = themeList.SchemeColor
                vi.ImageRectOffset = Vector2.new(764,764)
                vi.ImageRectSize = Vector2.new(36,36)
                return vi
            end

            -- ── shared: hover effect on element ───
            local function hookHover(elem, focusRef)
                local hovering = false
                elem.MouseEnter:Connect(function()
                    if not focusing then
                        tween:Create(elem, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3.fromRGB(
                                math.clamp(themeList.ElementColor.R*255+12,0,255),
                                math.clamp(themeList.ElementColor.G*255+12,0,255),
                                math.clamp(themeList.ElementColor.B*255+14,0,255))
                        }):Play()
                        hovering = true
                    end
                end)
                elem.MouseLeave:Connect(function()
                    if not focusing then
                        tween:Create(elem, TweenInfo.new(0.1), {BackgroundColor3=themeList.ElementColor}):Play()
                        hovering = false
                    end
                end)
                return function() return hovering end
            end

            -- ── shared: ripple sample effect ──────
            local function ripple(elem, ms)
                local Sample = Instance.new("ImageLabel")
                Sample.Parent = elem
                Sample.BackgroundTransparency = 1
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.6
                local x = ms.X - Sample.AbsolutePosition.X
                local y = ms.Y - Sample.AbsolutePosition.Y
                Sample.Position = UDim2.new(0,x,0,y)
                local size = math.max(elem.AbsoluteSize.X, elem.AbsoluteSize.Y) * 1.5
                Sample:TweenSizeAndPosition(
                    UDim2.new(0,size,0,size),
                    UDim2.new(0.5,(-size/2),0.5,(-size/2)),
                    'Out','Quad',0.35,true)
                for i=1,10 do
                    Sample.ImageTransparency = Sample.ImageTransparency + 0.05
                    wait(0.35/12)
                end
                Sample:Destroy()
            end

            -- ── shared: viewInfo click ─────────────
            local function hookViewInfo(vi, moreInfo, elem)
                vi.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo,{Position=UDim2.new(0,0,0,0)},0.2)
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=0.5},0.2)
                        if elem then Utility:TweenObject(elem,{BackgroundColor3=themeList.ElementColor},0.2) end
                        wait(1.8)
                        focusing = false
                        Utility:TweenObject(moreInfo,{Position=UDim2.new(0,0,2,0)},0.2)
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                        wait(0)
                        viewDe = false
                    end
                end)
            end

            -- ────────────────────────────────────────
            --  NewButton
            -- ────────────────────────────────────────
            function Elements:NewButton(bname, tipINf, callback)
                local BtnFunc = {}
                bname    = bname    or "Button"
                tipINf   = tipINf   or "Click this button"
                callback = callback or function() end

                local btn = Instance.new("TextButton")
                btn.Name = bname
                btn.Parent = sectionInners
                btn.BackgroundColor3 = themeList.ElementColor
                btn.ClipsDescendants = true
                btn.Size = UDim2.new(1,0,0,34)
                btn.AutoButtonColor = false
                btn.Font = Enum.Font.SourceSans
                btn.Text = ""
                Instance.new("UICorner").Parent = btn
                addStroke(btn, themeList.SchemeColor, 1, 0.85)

                local icon = Instance.new("ImageLabel")
                icon.Parent = btn
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926305904"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(84,204)
                icon.ImageRectSize = Vector2.new(36,36)

                local label = Instance.new("TextLabel")
                label.Parent = btn
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0,34,0,0)
                label.Size = UDim2.new(1,-60,1,0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = bname
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left

                local vi = makeViewInfo(btn)
                local mi = makeMoreInfo(tipINf)
                hookViewInfo(vi, mi, btn)
                hookHover(btn, focusing)

                local ms = game.Players.LocalPlayer:GetMouse()
                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        ripple(btn, ms)
                    else
                        for _,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                    end
                end)

                coroutine.wrap(function()
                    while wait() do
                        btn.BackgroundColor3 = themeList.ElementColor
                        icon.ImageColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                updateSectionFrame(); UpdateSize()

                function BtnFunc:UpdateButton(newTitle)
                    label.Text = newTitle
                end
                return BtnFunc
            end

            -- ────────────────────────────────────────
            --  NewToggle
            -- ────────────────────────────────────────
            function Elements:NewToggle(tname, nTip, callback)
                local TogFunc = {}
                tname    = tname    or "Toggle"
                nTip     = nTip     or "Toggle this feature"
                callback = callback or function() end
                local toggled = false
                table.insert(SettingsT, tname)

                local elem = Instance.new("TextButton")
                elem.Name = "toggleElement"
                elem.Parent = sectionInners
                elem.BackgroundColor3 = themeList.ElementColor
                elem.ClipsDescendants = true
                elem.Size = UDim2.new(1,0,0,34)
                elem.AutoButtonColor = false
                elem.Font = Enum.Font.SourceSans
                elem.Text = ""
                Instance.new("UICorner").Parent = elem
                addStroke(elem, themeList.SchemeColor, 1, 0.85)

                -- toggle track
                local track = Instance.new("Frame")
                track.Parent = elem
                track.BackgroundColor3 = Color3.fromRGB(50,52,60)
                track.Position = UDim2.new(1,-50,0.5,-8)
                track.Size = UDim2.new(0,36,0,16)
                track.BorderSizePixel = 0
                local trCorner = Instance.new("UICorner")
                trCorner.CornerRadius = UDim.new(1,0)
                trCorner.Parent = track

                -- toggle knob
                local knob = Instance.new("Frame")
                knob.Parent = track
                knob.BackgroundColor3 = Color3.fromRGB(160,165,180)
                knob.Position = UDim2.new(0,2,0.5,-6)
                knob.Size = UDim2.new(0,12,0,12)
                knob.BorderSizePixel = 0
                local knobCorner = Instance.new("UICorner")
                knobCorner.CornerRadius = UDim.new(1,0)
                knobCorner.Parent = knob

                -- disabled icon (left side)
                local icon = Instance.new("ImageLabel")
                icon.Parent = elem
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926309567"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(628,420)
                icon.ImageRectSize = Vector2.new(48,48)

                local label = Instance.new("TextLabel")
                label.Parent = elem
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0,34,0,0)
                label.Size = UDim2.new(1,-90,1,0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = tname
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left

                local vi = makeViewInfo(elem)
                vi.Position = UDim2.new(1,-26,0.5,-11) -- keep inside track area
                local mi = makeMoreInfo(nTip)
                hookViewInfo(vi, mi, elem)
                hookHover(elem, focusing)

                local ms = game.Players.LocalPlayer:GetMouse()

                local function setToggleVisual(state)
                    if state then
                        tween:Create(track, TweenInfo.new(0.2), {BackgroundColor3=themeList.SchemeColor}):Play()
                        tween:Create(knob, TweenInfo.new(0.2), {
                            Position=UDim2.new(1,-14,0.5,-6),
                            BackgroundColor3=Color3.fromRGB(255,255,255)
                        }):Play()
                    else
                        tween:Create(track, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(50,52,60)}):Play()
                        tween:Create(knob, TweenInfo.new(0.2), {
                            Position=UDim2.new(0,2,0.5,-6),
                            BackgroundColor3=Color3.fromRGB(160,165,180)
                        }):Play()
                    end
                end

                elem.MouseButton1Click:Connect(function()
                    if not focusing then
                        toggled = not toggled
                        setToggleVisual(toggled)
                        ripple(elem, ms)
                        pcall(callback, toggled)
                    else
                        for _,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                    end
                end)

                coroutine.wrap(function()
                    while wait() do
                        elem.BackgroundColor3 = themeList.ElementColor
                        icon.ImageColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                        if toggled then
                            track.BackgroundColor3 = themeList.SchemeColor
                        end
                    end
                end)()

                updateSectionFrame(); UpdateSize()

                function TogFunc:UpdateToggle(newText, isTogOn)
                    if newText ~= nil and type(newText)=="string" then
                        label.Text = newText
                    end
                    if isTogOn ~= nil then
                        toggled = isTogOn
                        setToggleVisual(toggled)
                        pcall(callback, toggled)
                    end
                end
                return TogFunc
            end

            -- ────────────────────────────────────────
            --  NewTextBox
            -- ────────────────────────────────────────
            function Elements:NewTextBox(tname, tTip, callback)
                tname    = tname    or "Textbox"
                tTip     = tTip     or "Enter a value"
                callback = callback or function() end

                local elem = Instance.new("TextButton")
                elem.Name = "textboxElement"
                elem.Parent = sectionInners
                elem.BackgroundColor3 = themeList.ElementColor
                elem.ClipsDescendants = true
                elem.Size = UDim2.new(1,0,0,34)
                elem.AutoButtonColor = false
                elem.Font = Enum.Font.SourceSans
                elem.Text = ""
                Instance.new("UICorner").Parent = elem
                addStroke(elem, themeList.SchemeColor, 1, 0.85)

                local icon = Instance.new("ImageLabel")
                icon.Parent = elem
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926305904"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(324,604)
                icon.ImageRectSize = Vector2.new(36,36)

                local label = Instance.new("TextLabel")
                label.Parent = elem
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0,34,0,0)
                label.Size = UDim2.new(0.4,0,1,0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = tname
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left

                local tb = Instance.new("TextBox")
                tb.Parent = elem
                tb.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255-8,0,255),
                    math.clamp(themeList.ElementColor.G*255-8,0,255),
                    math.clamp(themeList.ElementColor.B*255-9,0,255))
                tb.BorderSizePixel = 0
                tb.Position = UDim2.new(0.5,4,0.5,-9)
                tb.Size = UDim2.new(0.44,0,0,18)
                tb.ZIndex = 99
                tb.ClearTextOnFocus = false
                tb.Font = Enum.Font.Gotham
                tb.PlaceholderColor3 = Color3.fromRGB(100,100,120)
                tb.PlaceholderText = "Type here!"
                tb.Text = ""
                tb.TextColor3 = themeList.SchemeColor
                tb.TextSize = 12
                Instance.new("UICorner").Parent = tb
                addStroke(tb, themeList.SchemeColor, 1, 0.6)

                local vi = makeViewInfo(elem)
                local mi = makeMoreInfo(tTip)
                hookViewInfo(vi, mi, elem)
                hookHover(elem, focusing)

                tb.FocusLost:Connect(function(enter)
                    if enter then
                        callback(tb.Text)
                        wait(0.18)
                        tb.Text = ""
                    end
                end)

                elem.MouseButton1Click:Connect(function()
                    if focusing then
                        for _,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                    end
                end)

                coroutine.wrap(function()
                    while wait() do
                        elem.BackgroundColor3 = themeList.ElementColor
                        icon.ImageColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                        tb.TextColor3 = themeList.SchemeColor
                        tb.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255-8,0,255),
                            math.clamp(themeList.ElementColor.G*255-8,0,255),
                            math.clamp(themeList.ElementColor.B*255-9,0,255))
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                updateSectionFrame(); UpdateSize()
            end

            -- ────────────────────────────────────────
            --  NewDropdown
            -- ────────────────────────────────────────
            function Elements:NewDropdown(dropname, dropinf, list, callback)
                local DropFunc = {}
                dropname = dropname or "Dropdown"
                list     = list     or {}
                dropinf  = dropinf  or "Select an option"
                callback = callback or function() end
                local opened = false

                local dropFrame = Instance.new("Frame")
                dropFrame.Name = "dropFrame"
                dropFrame.Parent = sectionInners
                dropFrame.BackgroundColor3 = themeList.Background
                dropFrame.BorderSizePixel = 0
                dropFrame.Size = UDim2.new(1,0,0,34)
                dropFrame.ClipsDescendants = true

                local dropOpen = Instance.new("TextButton")
                dropOpen.Name = "dropOpen"
                dropOpen.Parent = dropFrame
                dropOpen.BackgroundColor3 = themeList.ElementColor
                dropOpen.Size = UDim2.new(1,0,0,34)
                dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans
                dropOpen.Text = ""
                dropOpen.ClipsDescendants = true
                Instance.new("UICorner").Parent = dropOpen
                addStroke(dropOpen, themeList.SchemeColor, 1, 0.85)

                local arrowIcon = Instance.new("ImageLabel")
                arrowIcon.Parent = dropOpen
                arrowIcon.BackgroundTransparency = 1
                arrowIcon.Position = UDim2.new(0,8,0.5,-10)
                arrowIcon.Size = UDim2.new(0,20,0,20)
                arrowIcon.Image = "rbxassetid://3926305904"
                arrowIcon.ImageColor3 = themeList.SchemeColor
                arrowIcon.ImageRectOffset = Vector2.new(644,364)
                arrowIcon.ImageRectSize = Vector2.new(36,36)

                local selectedLabel = Instance.new("TextLabel")
                selectedLabel.Parent = dropOpen
                selectedLabel.BackgroundTransparency = 1
                selectedLabel.Position = UDim2.new(0,34,0,0)
                selectedLabel.Size = UDim2.new(1,-60,1,0)
                selectedLabel.Font = Enum.Font.GothamSemibold
                selectedLabel.Text = dropname
                selectedLabel.RichText = true
                selectedLabel.TextColor3 = themeList.TextColor
                selectedLabel.TextSize = 13
                selectedLabel.TextXAlignment = Enum.TextXAlignment.Left

                local vi = makeViewInfo(dropOpen)
                local mi = makeMoreInfo(dropinf)
                hookViewInfo(vi, mi, dropOpen)
                hookHover(dropOpen, focusing)

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Parent = dropFrame
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0,2)

                local ms = game.Players.LocalPlayer:GetMouse()

                local function closeDropdown()
                    opened = false
                    dropFrame:TweenSize(UDim2.new(1,0,0,34),"InOut","Linear",0.1)
                    wait(0.12)
                    updateSectionFrame(); UpdateSize()
                end
                local function openDropdown()
                    opened = true
                    dropFrame:TweenSize(UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y),"InOut","Linear",0.1,true)
                    wait(0.12)
                    updateSectionFrame(); UpdateSize()
                end

                dropOpen.MouseButton1Click:Connect(function()
                    if not focusing then
                        if opened then closeDropdown() else openDropdown() end
                        ripple(dropOpen, ms)
                    else
                        for _,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                    end
                end)

                local function makeOption(v)
                    local opt = Instance.new("TextButton")
                    opt.Name = "optionSelect"
                    opt.Parent = dropFrame
                    opt.BackgroundColor3 = Color3.fromRGB(
                        math.clamp(themeList.ElementColor.R*255-4,0,255),
                        math.clamp(themeList.ElementColor.G*255-4,0,255),
                        math.clamp(themeList.ElementColor.B*255-4,0,255))
                    opt.Size = UDim2.new(1,0,0,30)
                    opt.AutoButtonColor = false
                    opt.Font = Enum.Font.GothamSemibold
                    opt.Text = "  "..v
                    opt.TextColor3 = themeList.TextColor
                    opt.TextSize = 13
                    opt.TextXAlignment = Enum.TextXAlignment.Left
                    opt.ClipsDescendants = true
                    Instance.new("UICorner").Parent = opt

                    local Sample = Instance.new("ImageLabel")
                    Sample.Parent = opt
                    Sample.BackgroundTransparency = 1
                    Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample.ImageColor3 = themeList.SchemeColor
                    Sample.ImageTransparency = 0.6

                    opt.MouseButton1Click:Connect(function()
                        if not focusing then
                            closeDropdown()
                            callback(v)
                            selectedLabel.Text = v
                            ripple(opt, ms)
                        else
                            for _,vv in next, infoContainer:GetChildren() do
                                Utility:TweenObject(vv,{Position=UDim2.new(0,0,2,0)},0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                        end
                    end)

                    local oh = false
                    opt.MouseEnter:Connect(function()
                        if not focusing then
                            tween:Create(opt,TweenInfo.new(0.1),{
                                BackgroundColor3=Color3.fromRGB(
                                    math.clamp(themeList.ElementColor.R*255+8,0,255),
                                    math.clamp(themeList.ElementColor.G*255+8,0,255),
                                    math.clamp(themeList.ElementColor.B*255+10,0,255))
                            }):Play()
                            oh = true
                        end
                    end)
                    opt.MouseLeave:Connect(function()
                        tween:Create(opt,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255-4,0,255),
                            math.clamp(themeList.ElementColor.G*255-4,0,255),
                            math.clamp(themeList.ElementColor.B*255-4,0,255))}):Play()
                        oh = false
                    end)
                    coroutine.wrap(function()
                        while wait() do
                            if not oh then
                                opt.BackgroundColor3 = Color3.fromRGB(
                                    math.clamp(themeList.ElementColor.R*255-4,0,255),
                                    math.clamp(themeList.ElementColor.G*255-4,0,255),
                                    math.clamp(themeList.ElementColor.B*255-4,0,255))
                            end
                            opt.TextColor3 = themeList.TextColor
                            Sample.ImageColor3 = themeList.SchemeColor
                        end
                    end)()
                end

                for _,v in next, list do makeOption(v) end

                coroutine.wrap(function()
                    while wait() do
                        dropOpen.BackgroundColor3 = themeList.ElementColor
                        dropFrame.BackgroundColor3 = themeList.Background
                        arrowIcon.ImageColor3 = themeList.SchemeColor
                        selectedLabel.TextColor3 = themeList.TextColor
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                updateSectionFrame(); UpdateSize()

                function DropFunc:Refresh(newList, keepSelected)
                    newList = newList or {}
                    for _,v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" then v:Destroy() end
                    end
                    for _,v in next, newList do makeOption(v) end
                    if opened then
                        dropFrame:TweenSize(UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y),"InOut","Linear",0.08,true)
                    else
                        dropFrame:TweenSize(UDim2.new(1,0,0,34),"InOut","Linear",0.08)
                    end
                    wait(0.1)
                    updateSectionFrame(); UpdateSize()
                end
                return DropFunc
            end

            -- ────────────────────────────────────────
            --  NewLabel
            -- ────────────────────────────────────────
            function Elements:NewLabel(titleText)
                local LabelFunc = {}
                local lbl = Instance.new("TextLabel")
                lbl.Name = "label"
                lbl.Parent = sectionInners
                lbl.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255-2,0,255),
                    math.clamp(themeList.ElementColor.G*255-2,0,255),
                    math.clamp(themeList.ElementColor.B*255,0,255))
                lbl.BorderSizePixel = 0
                lbl.ClipsDescendants = true
                lbl.Size = UDim2.new(1,0,0,30)
                lbl.Font = Enum.Font.Gotham
                lbl.Text = "  "..titleText
                lbl.RichText = true
                lbl.TextColor3 = themeList.TextColor
                lbl.TextSize = 13
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner").Parent = lbl

                -- subtle left border
                local lb = Instance.new("Frame")
                lb.BackgroundColor3 = themeList.SchemeColor
                lb.BorderSizePixel = 0
                lb.Position = UDim2.new(0,0,0.2,0)
                lb.Size = UDim2.new(0,2,0.6,0)
                lb.Parent = lbl
                Instance.new("UICorner").Parent = lb

                coroutine.wrap(function()
                    while wait() do
                        lbl.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255-2,0,255),
                            math.clamp(themeList.ElementColor.G*255-2,0,255),
                            math.clamp(themeList.ElementColor.B*255,0,255))
                        lbl.TextColor3 = themeList.TextColor
                        lb.BackgroundColor3 = themeList.SchemeColor
                    end
                end)()

                updateSectionFrame(); UpdateSize()

                function LabelFunc:UpdateLabel(newText)
                    if lbl.Text ~= "  "..newText then
                        lbl.Text = "  "..newText
                    end
                end
                return LabelFunc
            end

            -- ────────────────────────────────────────
            --  NewSlider  (unchanged logic, updated style)
            -- ────────────────────────────────────────
            function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
                slidInf  = slidInf   or "Slider"
                slidTip  = slidTip   or "Adjust this value"
                maxvalue = maxvalue  or 500
                minvalue = minvalue  or 0
                callback = callback  or function() end

                local elem = Instance.new("TextButton")
                elem.Name = "sliderElement"
                elem.Parent = sectionInners
                elem.BackgroundColor3 = themeList.ElementColor
                elem.ClipsDescendants = true
                elem.Size = UDim2.new(1,0,0,34)
                elem.AutoButtonColor = false
                elem.Font = Enum.Font.SourceSans
                elem.Text = ""
                Instance.new("UICorner").Parent = elem
                addStroke(elem, themeList.SchemeColor, 1, 0.85)

                local icon = Instance.new("ImageLabel")
                icon.Parent = elem
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926307971"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(404,164)
                icon.ImageRectSize = Vector2.new(36,36)

                local label = Instance.new("TextLabel")
                label.Parent = elem
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0,34,0,0)
                label.Size = UDim2.new(0.35,0,1,0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = slidInf
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left

                -- track bg
                local trackBg = Instance.new("TextButton")
                trackBg.Parent = elem
                trackBg.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255+8,0,255),
                    math.clamp(themeList.ElementColor.G*255+8,0,255),
                    math.clamp(themeList.ElementColor.B*255+8,0,255))
                trackBg.BorderSizePixel = 0
                trackBg.Position = UDim2.new(0.42,0,0.5,-4)
                trackBg.Size = UDim2.new(0.45,0,0,8)
                trackBg.AutoButtonColor = false
                trackBg.Text = ""
                Instance.new("UICorner").Parent = trackBg

                local sliderDrag = Instance.new("Frame")
                sliderDrag.Name = "sliderDrag"
                sliderDrag.Parent = trackBg
                sliderDrag.BackgroundColor3 = themeList.SchemeColor
                sliderDrag.BorderSizePixel = 0
                sliderDrag.Size = UDim2.new(0.3,0,1,0)
                Instance.new("UICorner").Parent = sliderDrag

                local val = Instance.new("TextLabel")
                val.Parent = elem
                val.BackgroundTransparency = 1
                val.Position = UDim2.new(0.88,0,0,0)
                val.Size = UDim2.new(0.1,0,1,0)
                val.Font = Enum.Font.GothamSemibold
                val.Text = tostring(minvalue)
                val.TextColor3 = themeList.SchemeColor
                val.TextSize = 12
                val.TextTransparency = 1

                local vi = makeViewInfo(elem)
                local mi = makeMoreInfo(slidTip)
                hookViewInfo(vi, mi, elem)
                hookHover(elem, focusing)

                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis   = game:GetService("UserInputService")

                trackBg.MouseButton1Down:Connect(function()
                    if not focusing then
                        tween:Create(val,TweenInfo.new(0.1),{TextTransparency=0}):Play()
                        local mv, rc
                        mv = mouse.Move:Connect(function()
                            local x = math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, trackBg.AbsoluteSize.X)
                            local v = math.floor(((maxvalue-minvalue)/trackBg.AbsoluteSize.X)*x + minvalue)
                            val.Text = v
                            sliderDrag:TweenSize(UDim2.new(0,math.clamp(mouse.X-trackBg.AbsolutePosition.X,0,trackBg.AbsoluteSize.X),1,0),"InOut","Linear",0.05,true)
                            pcall(callback,v)
                        end)
                        rc = uis.InputEnded:Connect(function(inp)
                            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                                tween:Create(val,TweenInfo.new(0.1),{TextTransparency=1}):Play()
                                mv:Disconnect(); rc:Disconnect()
                            end
                        end)
                    end
                end)

                coroutine.wrap(function()
                    while wait() do
                        elem.BackgroundColor3 = themeList.ElementColor
                        icon.ImageColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                        val.TextColor3 = themeList.SchemeColor
                        trackBg.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255+8,0,255),
                            math.clamp(themeList.ElementColor.G*255+8,0,255),
                            math.clamp(themeList.ElementColor.B*255+8,0,255))
                        sliderDrag.BackgroundColor3 = themeList.SchemeColor
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                updateSectionFrame(); UpdateSize()
            end

            -- ────────────────────────────────────────
            --  NewKeybind  (style update, same logic)
            -- ────────────────────────────────────────
            function Elements:NewKeybind(keytext, keyinf, first, callback)
                keytext  = keytext  or "Keybind"
                keyinf   = keyinf   or "Press to rebind"
                callback = callback or function() end
                local oldKey = first and first.Name or "F"

                local elem = Instance.new("TextButton")
                elem.Name = "keybindElement"
                elem.Parent = sectionInners
                elem.BackgroundColor3 = themeList.ElementColor
                elem.ClipsDescendants = true
                elem.Size = UDim2.new(1,0,0,34)
                elem.AutoButtonColor = false
                elem.Font = Enum.Font.SourceSans
                elem.Text = ""
                Instance.new("UICorner").Parent = elem
                addStroke(elem, themeList.SchemeColor, 1, 0.85)

                local icon = Instance.new("ImageLabel")
                icon.Parent = elem
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926305904"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(364,284)
                icon.ImageRectSize = Vector2.new(36,36)

                local label = Instance.new("TextLabel")
                label.Parent = elem
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0,34,0,0)
                label.Size = UDim2.new(0.6,0,1,0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = keytext
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left

                local keyLabel = Instance.new("TextLabel")
                keyLabel.Parent = elem
                keyLabel.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.ElementColor.R*255-6,0,255),
                    math.clamp(themeList.ElementColor.G*255-6,0,255),
                    math.clamp(themeList.ElementColor.B*255-6,0,255))
                keyLabel.Position = UDim2.new(0.78,0,0.5,-10)
                keyLabel.Size = UDim2.new(0,54,0,20)
                keyLabel.Font = Enum.Font.GothamBold
                keyLabel.Text = oldKey
                keyLabel.TextColor3 = themeList.SchemeColor
                keyLabel.TextSize = 12
                Instance.new("UICorner").Parent = keyLabel
                addStroke(keyLabel, themeList.SchemeColor, 1, 0.5)

                local vi = makeViewInfo(elem)
                local mi = makeMoreInfo(keyinf)
                hookViewInfo(vi, mi, elem)
                hookHover(elem, focusing)

                local ms = game.Players.LocalPlayer:GetMouse()
                elem.MouseButton1Click:connect(function()
                    if not focusing then
                        keyLabel.Text = ". . ."
                        local a = game:GetService('UserInputService').InputBegan:wait()
                        if a.KeyCode.Name ~= "Unknown" then
                            keyLabel.Text = a.KeyCode.Name
                            oldKey = a.KeyCode.Name
                        end
                        ripple(elem, ms)
                    else
                        for _,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v,{Position=UDim2.new(0,0,2,0)},0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame,{BackgroundTransparency=1},0.2)
                    end
                end)
                game:GetService("UserInputService").InputBegan:connect(function(cur,ok)
                    if not ok and cur.KeyCode.Name == oldKey then callback() end
                end)

                coroutine.wrap(function()
                    while wait() do
                        elem.BackgroundColor3 = themeList.ElementColor
                        icon.ImageColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                        keyLabel.TextColor3 = themeList.SchemeColor
                        keyLabel.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.ElementColor.R*255-6,0,255),
                            math.clamp(themeList.ElementColor.G*255-6,0,255),
                            math.clamp(themeList.ElementColor.B*255-6,0,255))
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                updateSectionFrame(); UpdateSize()
            end

            -- ────────────────────────────────────────
            --  NewColorPicker  (kept from original)
            -- ────────────────────────────────────────
            function Elements:NewColorPicker(colText, colInf, defcolor, callback)
                colText  = colText  or "ColorPicker"
                colInf   = colInf   or "Pick a color"
                callback = callback or function() end
                defcolor = defcolor or Color3.fromRGB(255,255,255)
                local h,s,v = Color3.toHSV(defcolor)
                local ms = game.Players.LocalPlayer:GetMouse()
                local colorOpened = false

                local colorElement = Instance.new("TextButton")
                colorElement.Name = "colorElement"
                colorElement.Parent = sectionInners
                colorElement.BackgroundColor3 = themeList.ElementColor
                colorElement.BackgroundTransparency = 1
                colorElement.ClipsDescendants = true
                colorElement.Size = UDim2.new(1,0,0,34)
                colorElement.AutoButtonColor = false
                colorElement.Font = Enum.Font.SourceSans
                colorElement.Text = ""
                Instance.new("UICorner").Parent = colorElement

                local colorHeader = Instance.new("Frame")
                colorHeader.Name = "colorHeader"
                colorHeader.Parent = colorElement
                colorHeader.BackgroundColor3 = themeList.ElementColor
                colorHeader.Size = UDim2.new(1,0,0,34)
                colorHeader.ClipsDescendants = true
                Instance.new("UICorner").Parent = colorHeader
                addStroke(colorHeader, themeList.SchemeColor, 1, 0.85)

                local icon = Instance.new("ImageLabel")
                icon.Parent = colorHeader
                icon.BackgroundTransparency = 1
                icon.Position = UDim2.new(0,8,0.5,-10)
                icon.Size = UDim2.new(0,20,0,20)
                icon.Image = "rbxassetid://3926305904"
                icon.ImageColor3 = themeList.SchemeColor
                icon.ImageRectOffset = Vector2.new(44,964)
                icon.ImageRectSize = Vector2.new(36,36)

                local togName = Instance.new("TextLabel")
                togName.Parent = colorHeader
                togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0,34,0,0)
                togName.Size = UDim2.new(0.6,0,1,0)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = colText
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 13
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local colorCurrent = Instance.new("Frame")
                colorCurrent.Parent = colorHeader
                colorCurrent.BackgroundColor3 = defcolor
                colorCurrent.Position = UDim2.new(0.78,0,0.5,-10)
                colorCurrent.Size = UDim2.new(0,44,0,20)
                Instance.new("UICorner").Parent = colorCurrent

                local vi = makeViewInfo(colorHeader)
                local mi = makeMoreInfo(colInf)
                hookViewInfo(vi, mi, colorElement)

                local UIListLayout2 = Instance.new("UIListLayout")
                UIListLayout2.Parent = colorElement
                UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout2.Padding = UDim.new(0,3)

                local colorInners = Instance.new("Frame")
                colorInners.Parent = colorElement
                colorInners.BackgroundColor3 = themeList.ElementColor
                colorInners.Position = UDim2.new(0,0,0,37)
                colorInners.Size = UDim2.new(1,0,0,105)
                Instance.new("UICorner").Parent = colorInners

                local rgb = Instance.new("ImageButton")
                rgb.Parent = colorInners
                rgb.BackgroundTransparency = 1
                rgb.Position = UDim2.new(0.02,0,0.05,0)
                rgb.Size = UDim2.new(0,211,0,93)
                rgb.Image = "http://www.roblox.com/asset/?id=6523286724"
                Instance.new("UICorner").Parent = rgb

                local rbgcircle = Instance.new("ImageLabel")
                rbgcircle.Parent = rgb
                rbgcircle.BackgroundTransparency = 1
                rbgcircle.Size = UDim2.new(0,14,0,14)
                rbgcircle.Image = "rbxassetid://3926309567"
                rbgcircle.ImageColor3 = Color3.fromRGB(0,0,0)
                rbgcircle.ImageRectOffset = Vector2.new(628,420)
                rbgcircle.ImageRectSize = Vector2.new(48,48)

                local darkness = Instance.new("ImageButton")
                darkness.Parent = colorInners
                darkness.BackgroundTransparency = 1
                darkness.Position = UDim2.new(0.64,0,0.05,0)
                darkness.Size = UDim2.new(0,18,0,93)
                darkness.Image = "http://www.roblox.com/asset/?id=6523291212"
                Instance.new("UICorner").Parent = darkness

                local darkcircle = Instance.new("ImageLabel")
                darkcircle.Parent = darkness
                darkcircle.AnchorPoint = Vector2.new(0.5,0)
                darkcircle.BackgroundTransparency = 1
                darkcircle.Size = UDim2.new(0,14,0,14)
                darkcircle.Image = "rbxassetid://3926309567"
                darkcircle.ImageColor3 = Color3.fromRGB(0,0,0)
                darkcircle.ImageRectOffset = Vector2.new(628,420)
                darkcircle.ImageRectSize = Vector2.new(48,48)

                -- rainbow toggle
                local toggleDisabled = Instance.new("ImageLabel")
                toggleDisabled.Parent = colorInners
                toggleDisabled.BackgroundTransparency = 1
                toggleDisabled.Position = UDim2.new(0.71,0,0.07,0)
                toggleDisabled.Size = UDim2.new(0,21,0,21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628,420)
                toggleDisabled.ImageRectSize = Vector2.new(48,48)

                local toggleEnabled = Instance.new("ImageLabel")
                toggleEnabled.Parent = colorInners
                toggleEnabled.BackgroundTransparency = 1
                toggleEnabled.Position = UDim2.new(0.71,0,0.07,0)
                toggleEnabled.Size = UDim2.new(0,21,0,21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784,420)
                toggleEnabled.ImageRectSize = Vector2.new(48,48)
                toggleEnabled.ImageTransparency = 1

                local onrainbow = Instance.new("TextButton")
                onrainbow.Parent = toggleEnabled
                onrainbow.BackgroundTransparency = 1
                onrainbow.Size = UDim2.new(1,0,1,0)
                onrainbow.Font = Enum.Font.SourceSans
                onrainbow.Text = ""

                local togName2 = Instance.new("TextLabel")
                togName2.Parent = colorInners
                togName2.BackgroundTransparency = 1
                togName2.Position = UDim2.new(0.78,0,0.1,0)
                togName2.Size = UDim2.new(0.2,0,0,14)
                togName2.Font = Enum.Font.GothamSemibold
                togName2.Text = "Rainbow"
                togName2.TextColor3 = themeList.TextColor
                togName2.TextSize = 11

                colorElement.MouseButton1Click:Connect(function()
                    if not focusing then
                        if colorOpened then
                            colorOpened = false
                            colorElement:TweenSize(UDim2.new(1,0,0,34),"InOut","Linear",0.1)
                        else
                            colorOpened = true
                            colorElement:TweenSize(UDim2.new(1,0,0,145),"InOut","Linear",0.1,true)
                        end
                        wait(0.12); updateSectionFrame(); UpdateSize()
                    end
                end)

                coroutine.wrap(function()
                    while wait() do
                        colorHeader.BackgroundColor3 = themeList.ElementColor
                        colorInners.BackgroundColor3 = themeList.ElementColor
                        togName.TextColor3 = themeList.TextColor
                        togName2.TextColor3 = themeList.TextColor
                        icon.ImageColor3 = themeList.SchemeColor
                        toggleDisabled.ImageColor3 = themeList.SchemeColor
                        toggleEnabled.ImageColor3 = themeList.SchemeColor
                        vi.ImageColor3 = themeList.SchemeColor
                        mi.TextColor3 = themeList.TextColor
                        mi.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R*255-14,0,255),
                            math.clamp(themeList.SchemeColor.G*255-17,0,255),
                            math.clamp(themeList.SchemeColor.B*255-13,0,255))
                    end
                end)()

                local plr   = game.Players.LocalPlayer
                local mouse2 = plr:GetMouse()
                local uis2  = game:GetService("UserInputService")
                local rs2   = game:GetService("RunService")
                local colorpicker = false
                local darknesss   = false
                local color = {1,1,1}
                local rainbow = false
                local rainbowconnection
                local counter = 0
                local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end

                local function cp()
                    if colorpicker then
                        local x2 = math.clamp(mouse2.X-rgb.AbsolutePosition.X,0,rgb.AbsoluteSize.X)/rgb.AbsoluteSize.X
                        local y2 = math.clamp(mouse2.Y-rgb.AbsolutePosition.Y,0,rgb.AbsoluteSize.Y)/rgb.AbsoluteSize.Y
                        rbgcircle.Position = UDim2.new(x2,-7,y2,-7)
                        color = {1-x2,1-y2,color[3]}
                        local rc = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = rc; callback(rc)
                    end
                    if darknesss then
                        local y2 = math.clamp(mouse2.Y-darkness.AbsolutePosition.Y,0,darkness.AbsoluteSize.Y)/darkness.AbsoluteSize.Y
                        darkcircle.Position = UDim2.new(0.5,0,y2,-7)
                        darkcircle.ImageColor3 = Color3.fromHSV(0,0,y2)
                        color = {color[1],color[2],1-y2}
                        local rc = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = rc; callback(rc)
                    end
                end
                local function setrgbcolor(tbl)
                    color = {tbl[1],tbl[2],color[3]}
                    rbgcircle.Position = UDim2.new(color[1],-7,1-color[2],-7)
                    local rc = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = rc; callback(rc)
                end
                local function setcolor(tbl)
                    color = {tbl[1],tbl[2],tbl[3]}
                    rbgcircle.Position = UDim2.new(color[1],-7,1-color[2],-7)
                    darkcircle.Position = UDim2.new(0.5,0,1-color[3],-7)
                    colorCurrent.BackgroundColor3 = Color3.fromHSV(color[1],color[2],color[3])
                end
                local function togglerainbow()
                    if rainbow then
                        tween:Create(toggleEnabled,TweenInfo.new(0.1),{ImageTransparency=1}):Play()
                        rainbow = false
                        if rainbowconnection then rainbowconnection:Disconnect() end
                    else
                        tween:Create(toggleEnabled,TweenInfo.new(0.1),{ImageTransparency=0}):Play()
                        rainbow = true
                        rainbowconnection = rs2.RenderStepped:Connect(function()
                            setrgbcolor({zigzag(counter),1,1})
                            counter = counter + 0.01
                        end)
                    end
                end
                onrainbow.MouseButton1Click:Connect(togglerainbow)
                mouse2.Move:connect(cp)
                rgb.MouseButton1Down:connect(function() colorpicker=true end)
                darkness.MouseButton1Down:connect(function() darknesss=true end)
                uis2.InputEnded:Connect(function(inp2)
                    if inp2.UserInputType.Name=='MouseButton1' then
                        colorpicker=false; darknesss=false
                    end
                end)
                setcolor({h,s,v})
                updateSectionFrame(); UpdateSize()
            end

            return Elements
        end
        return Sections
    end
    return Tabs
end

return Kavo
