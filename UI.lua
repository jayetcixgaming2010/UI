local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

-- Improved dragging with smoothness
function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            parent.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

-- Enhanced themes with more options
local themes = {
    SchemeColor = Color3.fromRGB(108, 93, 211),
    Background = Color3.fromRGB(25, 25, 35),
    Header = Color3.fromRGB(20, 20, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(30, 30, 40)
}

local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(98, 114, 164),
        Background = Color3.fromRGB(18, 18, 24),
        Header = Color3.fromRGB(12, 12, 18),
        TextColor = Color3.fromRGB(220, 220, 240),
        ElementColor = Color3.fromRGB(22, 22, 30)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(100, 100, 100),
        Background = Color3.fromRGB(245, 245, 245),
        Header = Color3.fromRGB(230, 230, 230),
        TextColor = Color3.fromRGB(20, 20, 20),
        ElementColor = Color3.fromRGB(210, 210, 210)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(200, 40, 40),
        Background = Color3.fromRGB(15, 10, 10),
        Header = Color3.fromRGB(25, 15, 15),
        TextColor = Color3.fromRGB(255, 220, 220),
        ElementColor = Color3.fromRGB(30, 18, 18)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(40, 30, 45),
        Header = Color3.fromRGB(30, 22, 35),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(50, 38, 58)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(64, 156, 255),
        Background = Color3.fromRGB(10, 25, 45),
        Header = Color3.fromRGB(8, 20, 35),
        TextColor = Color3.fromRGB(200, 225, 255),
        ElementColor = Color3.fromRGB(15, 30, 50)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(20, 30, 40),
        Header = Color3.fromRGB(15, 22, 30),
        TextColor = Color3.fromRGB(220, 240, 240),
        ElementColor = Color3.fromRGB(25, 35, 45)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(28, 28, 28),
        Header = Color3.fromRGB(20, 20, 20),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(20, 22, 18),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(28, 30, 25)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(20, 30, 22),
        Header = Color3.fromRGB(15, 22, 16),
        TextColor = Color3.fromRGB(220, 240, 220),
        ElementColor = Color3.fromRGB(25, 35, 28)
    }
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
    local gui = game.CoreGui:FindFirstChild(LibName)
    if gui then
        gui.Enabled = not gui.Enabled
    end
end

-- Main library creation - KEEPING ORIGINAL FUNCTION NAME AND PARAMETERS
function Kavo.CreateLib(kavName, themeList)
    -- Theme selection logic (keep original)
    if not themeList then
        themeList = themes
    end
    if type(themeList) == "string" then
        if themeList == "DarkTheme" then
            themeList = themeStyles.DarkTheme
        elseif themeList == "LightTheme" then
            themeList = themeStyles.LightTheme
        elseif themeList == "BloodTheme" then
            themeList = themeStyles.BloodTheme
        elseif themeList == "GrapeTheme" then
            themeList = themeStyles.GrapeTheme
        elseif themeList == "Ocean" then
            themeList = themeStyles.Ocean
        elseif themeList == "Midnight" then
            themeList = themeStyles.Midnight
        elseif themeList == "Sentinel" then
            themeList = themeStyles.Sentinel
        elseif themeList == "Synapse" then
            themeList = themeStyles.Synapse
        elseif themeList == "Serpent" then
            themeList = themeStyles.Serpent
        else
            themeList = themes
        end
    else
        -- Validate custom theme
        if themeList.SchemeColor == nil then
            themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
        end
        if themeList.Background == nil then
            themeList.Background = Color3.fromRGB(36, 37, 43)
        end
        if themeList.Header == nil then
            themeList.Header = Color3.fromRGB(28, 29, 34)
        end
        if themeList.TextColor == nil then
            themeList.TextColor = Color3.fromRGB(255,255,255)
        end
        if themeList.ElementColor == nil then
            themeList.ElementColor = Color3.fromRGB(32, 32, 38)
        end
    end

    -- Cleanup existing GUI
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == LibName then
            v:Destroy()
        end
    end

    -- Create main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Main frame with modern design
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 550, 0, 350)

    -- Shadow effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    Shadow.Size = UDim2.new(1.1, 0, 1.1, 0)
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ZIndex = -1

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 2
    MainStroke.Color = themeList.ElementColor
    MainStroke.Parent = Main

    -- Header
    local MainHeader = Instance.new("Frame")
    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    Objects[MainHeader] = "BackgroundColor3"
    MainHeader.Size = UDim2.new(0, 550, 0, 35)

    local headerCover = Instance.new("UICorner")
    headerCover.CornerRadius = UDim.new(0, 8)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    -- Gradient effect for header
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, themeList.SchemeColor),
        ColorSequenceKeypoint.new(1, themeList.Header)
    })
    HeaderGradient.Rotation = 90
    HeaderGradient.Parent = MainHeader

    local coverup = Instance.new("Frame")
    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    Objects[coverup] = "BackgroundColor3"
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.85, 0)
    coverup.Size = UDim2.new(0, 550, 0, 5)

    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundTransparency = 1.000
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0.02, 0, 0, 0)
    title.Size = UDim2.new(0, 300, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- Close button with animation
    local close = Instance.new("ImageButton")
    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(0.95, -15, 0.5, -12)
    close.Size = UDim2.new(0, 24, 0, 24)
    close.ZIndex = 2
    close.Image = "rbxassetid://6031068459"
    close.ImageColor3 = themeList.TextColor
    
    close.MouseEnter:Connect(function()
        tween:Create(close, tweeninfo(0.2), {ImageColor3 = themeList.SchemeColor}):Play()
    end)
    
    close.MouseLeave:Connect(function()
        tween:Create(close, tweeninfo(0.2), {ImageColor3 = themeList.TextColor}):Play()
    end)
    
    close.MouseButton1Click:Connect(function()
        tween:Create(Main, tweeninfo(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0,0,0,0)
        }):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Enable dragging
    Kavo:DraggingEnabled(MainHeader, Main)

    -- Sidebar
    local MainSide = Instance.new("Frame")
    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    Objects[MainSide] = "Header"
    MainSide.Position = UDim2.new(0, 0, 0, 35)
    MainSide.Size = UDim2.new(0, 150, 1, -35)

    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 8)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    -- Tab container
    local tabFrames = Instance.new("ScrollingFrame")
    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1
    tabFrames.BorderSizePixel = 0
    tabFrames.Position = UDim2.new(0, 5, 0, 5)
    tabFrames.Size = UDim2.new(1, -10, 1, -10)
    tabFrames.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabFrames.ScrollBarThickness = 4
    tabFrames.ScrollBarImageColor3 = themeList.SchemeColor

    local tabListing = Instance.new("UIListLayout")
    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    tabListing.Padding = UDim.new(0, 5)

    -- Pages container
    local pages = Instance.new("Frame")
    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundTransparency = 1
    pages.Position = UDim2.new(0, 155, 0, 40)
    pages.Size = UDim2.new(1, -165, 1, -50)

    local Pages = Instance.new("Folder")
    Pages.Name = "Pages"
    Pages.Parent = pages

    -- Library API (keep original structure)
    local Library = {
        ScreenGui = ScreenGui,
        Main = Main,
        Pages = Pages,
        tabs = {},
        currentTab = nil
    }

    -- Tab creation (keep original function name)
    function Library:NewTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name.."Tab"
        TabButton.Parent = tabFrames
        TabButton.BackgroundColor3 = themeList.ElementColor
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = themeList.TextColor
        TabButton.TextSize = 14
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- Hover effect
        TabButton.MouseEnter:Connect(function()
            if Library.currentTab ~= TabButton then
                tween:Create(TabButton, tweeninfo(0.2), {
                    BackgroundColor3 = themeList.SchemeColor
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Library.currentTab ~= TabButton then
                tween:Create(TabButton, tweeninfo(0.2), {
                    BackgroundColor3 = themeList.ElementColor
                }):Play()
            end
        end)
        
        -- Tab page
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = name.."Page"
        TabPage.Parent = Pages
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.ScrollBarThickness = 6
        TabPage.ScrollBarImageColor3 = themeList.SchemeColor
        TabPage.Visible = false
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = TabPage
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = TabPage
        PagePadding.PaddingTop = UDim.new(0, 10)
        PagePadding.PaddingBottom = UDim.new(0, 10)
        PagePadding.PaddingLeft = UDim.new(0, 10)
        PagePadding.PaddingRight = UDim.new(0, 10)
        
        -- Tab selection
        TabButton.MouseButton1Click:Connect(function()
            if Library.currentTab then
                tween:Create(Library.currentTab, tweeninfo(0.2), {
                    BackgroundColor3 = themeList.ElementColor,
                    TextColor3 = themeList.TextColor
                }):Play()
            end
            
            for _, page in pairs(Pages:GetChildren()) do
                if page:IsA("ScrollingFrame") then
                    page.Visible = false
                end
            end
            
            Library.currentTab = TabButton
            tween:Create(TabButton, tweeninfo(0.2), {
                BackgroundColor3 = themeList.SchemeColor,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            
            TabPage.Visible = true
        end)
        
        -- Auto-select first tab
        if #tabFrames:GetChildren() - 1 == 1 then
            Library.currentTab = TabButton
            TabButton.BackgroundColor3 = themeList.SchemeColor
            TabPage.Visible = true
        end
        
        -- Update canvas size
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
        end)
        
        local Tab = {
            Button = TabButton,
            Page = TabPage,
            Layout = PageLayout,
            Sections = {}
        }
        
        -- Section creation (keep original function name)
        function Tab:NewSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName.."Section"
            Section.Parent = TabPage
            Section.BackgroundColor3 = themeList.ElementColor
            Section.Size = UDim2.new(1, 0, 0, 0)
            Section.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = Section
            
            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Thickness = 1
            SectionStroke.Color = themeList.SchemeColor
            SectionStroke.Parent = Section
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 0, 30)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = themeList.SchemeColor
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionTitlePadding = Instance.new("UIPadding")
            SectionTitlePadding.Parent = SectionTitle
            SectionTitlePadding.PaddingLeft = UDim.new(0, 10)
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 30)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionContent
            SectionLayout.Padding = UDim.new(0, 5)
            SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.Parent = SectionContent
            SectionPadding.PaddingLeft = UDim.new(0, 5)
            SectionPadding.PaddingRight = UDim.new(0, 5)
            SectionPadding.PaddingBottom = UDim.new(0, 5)
            
            local SectionAPI = {
                Section = Section,
                Content = SectionContent,
                Layout = SectionLayout
            }
            
            -- Element creation functions (keep original names)
            function SectionAPI:NewButton(btnText, desc, callback)
                local Button = Instance.new("TextButton")
                Button.Name = btnText.."Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = themeList.Background
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Gotham
                Button.Text = btnText
                Button.TextColor3 = themeList.TextColor
                Button.TextSize = 14
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    tween:Create(Button, tweeninfo(0.2), {
                        BackgroundColor3 = themeList.SchemeColor
                    }):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    tween:Create(Button, tweeninfo(0.2), {
                        BackgroundColor3 = themeList.Background
                    }):Play()
                end)
                
                Button.MouseButton1Click:Connect(callback)
                
                return Button
            end
            
            function SectionAPI:NewToggle(txt, desc, callback)
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = txt.."Toggle"
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = themeList.Background
                ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Parent = ToggleFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = ToggleFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(0.7, 0, 1, 0)
                Label.Font = Enum.Font.Gotham
                Label.Text = txt
                Label.TextColor3 = themeList.TextColor
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextWrapped = true
                
                local Toggle = Instance.new("ImageButton")
                Toggle.Name = "Toggle"
                Toggle.Parent = ToggleFrame
                Toggle.BackgroundTransparency = 1
                Toggle.Position = UDim2.new(1, -35, 0.5, -10)
                Toggle.Size = UDim2.new(0, 20, 0, 20)
                Toggle.Image = "rbxassetid://6035067836"
                Toggle.ImageColor3 = themeList.TextColor
                
                local toggled = false
                
                Toggle.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    Toggle.Image = toggled and "rbxassetid://6035047409" or "rbxassetid://6035067836"
                    tween:Create(Toggle, tweeninfo(0.2), {
                        ImageColor3 = toggled and themeList.SchemeColor or themeList.TextColor
                    }):Play()
                    callback(toggled)
                end)
                
                -- Add update method
                Toggle.UpdateToggle = function(state)
                    toggled = state
                    Toggle.Image = state and "rbxassetid://6035047409" or "rbxassetid://6035067836"
                    Toggle.ImageColor3 = state and themeList.SchemeColor or themeList.TextColor
                end
                
                return Toggle
            end
            
            function SectionAPI:NewDropdown(name, desc, options, callback)
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Name = name.."Dropdown"
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundColor3 = themeList.Background
                DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                DropdownFrame.ClipsDescendants = true
                
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 6)
                DropdownCorner.Parent = DropdownFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = DropdownFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -50, 0.5, 0)
                Label.Font = Enum.Font.Gotham
                Label.Text = name
                Label.TextColor3 = themeList.TextColor
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local Value = Instance.new("TextLabel")
                Value.Name = "Value"
                Value.Parent = DropdownFrame
                Value.BackgroundTransparency = 1
                Value.Position = UDim2.new(0, 10, 0.5, 0)
                Value.Size = UDim2.new(1, -50, 0.5, 0)
                Value.Font = Enum.Font.Gotham
                Value.Text = options[1] or "Select..."
                Value.TextColor3 = themeList.SchemeColor
                Value.TextSize = 12
                Value.TextXAlignment = Enum.TextXAlignment.Left
                
                local Arrow = Instance.new("ImageLabel")
                Arrow.Parent = DropdownFrame
                Arrow.BackgroundTransparency = 1
                Arrow.Position = UDim2.new(1, -25, 0.5, -7)
                Arrow.Size = UDim2.new(0, 15, 0, 15)
                Arrow.Image = "rbxassetid://6031094667"
                Arrow.ImageColor3 = themeList.TextColor
                Arrow.Rotation = 180
                
                local DropdownList = Instance.new("Frame")
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = themeList.ElementColor
                DropdownList.Position = UDim2.new(0, 0, 0, 45)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.ClipsDescendants = true
                DropdownList.Visible = false
                
                local ListLayout = Instance.new("UIListLayout")
                ListLayout.Parent = DropdownList
                ListLayout.Padding = UDim.new(0, 2)
                
                local expanded = false
                
                -- Populate dropdown
                for _, option in ipairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Name = option.."Option"
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = themeList.Background
                    OptionButton.Size = UDim2.new(1, 0, 0, 25)
                    OptionButton.AutoButtonColor = false
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = option
                    OptionButton.TextColor3 = themeList.TextColor
                    OptionButton.TextSize = 13
                    
                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionButton
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Value.Text = option
                        callback(option)
                        expanded = false
                        Arrow.Rotation = 180
                        DropdownList.Visible = false
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                    end)
                end
                
                -- Toggle dropdown
                DropdownFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        expanded = not expanded
                        Arrow.Rotation = expanded and 0 or 180
                        DropdownList.Visible = expanded
                        if expanded then
                            DropdownFrame.Size = UDim2.new(1, 0, 0, 45 + (#options * 27))
                        else
                            DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                        end
                    end
                end)
                
                -- Add refresh method
                DropdownFrame.Refresh = function(newOptions, keepValue)
                    -- Clear old options
                    for _, child in ipairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    -- Add new options
                    for _, option in ipairs(newOptions) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Name = option.."Option"
                        OptionButton.Parent = DropdownList
                        OptionButton.BackgroundColor3 = themeList.Background
                        OptionButton.Size = UDim2.new(1, 0, 0, 25)
                        OptionButton.AutoButtonColor = false
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.Text = option
                        OptionButton.TextColor3 = themeList.TextColor
                        OptionButton.TextSize = 13
                        
                        local OptionCorner = Instance.new("UICorner")
                        OptionCorner.CornerRadius = UDim.new(0, 4)
                        OptionCorner.Parent = OptionButton
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            Value.Text = option
                            callback(option)
                            expanded = false
                            Arrow.Rotation = 180
                            DropdownList.Visible = false
                            DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                        end)
                    end
                    
                    if not keepValue then
                        Value.Text = newOptions[1] or "Select..."
                    end
                end
                
                return DropdownFrame
            end
            
            function SectionAPI:NewTextBox(txt, placeholder, callback)
                local TextBoxFrame = Instance.new("Frame")
                TextBoxFrame.Name = txt.."TextBox"
                TextBoxFrame.Parent = SectionContent
                TextBoxFrame.BackgroundColor3 = themeList.Background
                TextBoxFrame.Size = UDim2.new(1, 0, 0, 45)
                
                local TextBoxCorner = Instance.new("UICorner")
                TextBoxCorner.CornerRadius = UDim.new(0, 6)
                TextBoxCorner.Parent = TextBoxFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = TextBoxFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -20, 0.4, 0)
                Label.Font = Enum.Font.Gotham
                Label.Text = txt
                Label.TextColor3 = themeList.TextColor
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local TextBox = Instance.new("TextBox")
                TextBox.Parent = TextBoxFrame
                TextBox.BackgroundColor3 = themeList.ElementColor
                TextBox.Position = UDim2.new(0, 10, 0.45, 0)
                TextBox.Size = UDim2.new(1, -20, 0, 20)
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderText = placeholder
                TextBox.Text = ""
                TextBox.TextColor3 = themeList.TextColor
                TextBox.TextSize = 12
                TextBox.ClearTextOnFocus = false
                
                local TextBoxCorner2 = Instance.new("UICorner")
                TextBoxCorner2.CornerRadius = UDim.new(0, 4)
                TextBoxCorner2.Parent = TextBox
                
                TextBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
                
                return TextBox
            end
            
            function SectionAPI:NewLabel(txt)
                local Label = Instance.new("TextLabel")
                Label.Name = txt.."Label"
                Label.Parent = SectionContent
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, -10, 0, 20)
                Label.Font = Enum.Font.Gotham
                Label.Text = txt
                Label.TextColor3 = themeList.TextColor
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                return Label
            end
            
            table.insert(Tab.Sections, SectionAPI)
            return SectionAPI
        end
        
        table.insert(Library.tabs, Tab)
        return Tab
    end

    -- Add ToggleUI method
    function Library:ToggleUI()
        Kavo:ToggleUI()
    end

    return Library
end

return Kavo
