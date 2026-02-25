--[[
    SAPI HUB BF PVP - Fix theo đúng cách của Rubu Hub
--]]

-- Load các module chức năng trước
local AimlockModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Dk"))()
local ESPModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Gk"))()
local SilentAimModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Bg"))()
local StuffsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Stuf"))()
local OthersStuffsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Mot"))()
local UiSettingsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Vot"))()
local ZSkillModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgotBand/BloxFruits/refs/heads/main/Beta/Aim/Teku"))()

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

-- Settings
local Settings = OthersStuffsModule.LoadSettings() or {}

-- Load thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- === TẠO WRAPPER GIỐNG RUBU HUB ===
local Library = {}

function Library:CreateWindow(options)
    local Window = WindUI:CreateWindow({
        Title = options.Title,
        Author = options.SubTitle,
        Folder = "SapiHub",
        Size = options.Size or UDim2.fromOffset(555, 320),
        Transparent = true,
        Theme = "Dark",
        SideBarWidth = 200,
        HideSearchBar = false,
        ScrollBarEnabled = true,
        MinimizeKey = Enum.KeyCode.M
    })
    
    local MainWindow = {}
    
    function MainWindow:Notify(options)
        WindUI:Popup({
            Title = options.Title,
            Content = options.Content
        })
    end
    
    function MainWindow:AddTab(options)
        local Tab = Window:Tab({ Title = options.Title })
        local TabObject = {}
        
        function TabObject:AddParagraph(options)
            return Tab:Paragraph({
                Title = options.Title,
                Desc = options.Content
            })
        end
        
        function TabObject:AddToggle(name, options)
            return Tab:Toggle({
                Title = options.Title,
                Desc = options.Description or "",
                Default = options.Default or false,
                Callback = options.Callback or function() end
            })
        end
        
        function TabObject:AddDropdown(name, options)
            return Tab:Dropdown({
                Title = options.Title,
                Values = options.Values or {},
                Default = options.Default or (options.Values and options.Values[1]),
                Multi = options.Multi or false,
                Callback = options.Callback or function() end
            })
        end
        
        function TabObject:AddButton(options)
            Tab:Button({
                Title = options.Title,
                Desc = options.Description or "",
                Callback = options.Callback or function() end
            })
        end
        
        function TabObject:AddSection(title)
            Tab:Section(title)
        end
        
        function TabObject:AddSlider(name, options)
            return Tab:Slider({
                Title = options.Title,
                Step = options.Rounding or 1,
                Value = {
                    Min = options.Min or 0,
                    Max = options.Max or 100,
                    Default = options.Default or 50
                },
                Callback = options.Callback or function() end
            })
        end
        
        function TabObject:AddInput(name, options)
            Tab:Input({
                Title = options.Title,
                Placeholder = options.Placeholder or "",
                Default = options.Default or "",
                Callback = options.Callback or function() end
            })
        end
        
        return TabObject
    end
    
    return MainWindow
end

-- Tạo Window chính
local Window = Library:CreateWindow({
    Title = "Sapi Hub BF PvP ˃ᴗ˂",
    SubTitle = " | Velocity [Working]",
    Size = UDim2.fromOffset(580, 460)
})

-- === TẠO CÁC TAB ===
local Tabs = {}

-- TAB 1: Executor Status
Tabs.Executor = Window:AddTab({ Title = "◇・Executor Status" })
Tabs.Executor:AddSection("◈・Information")
Tabs.Executor:AddParagraph({
    Title = "Executor Information",
    Content = "Executor: Velocity\nStatus: Working"
})

-- TAB 2: Changelogs
Tabs.Changelogs = Window:AddTab({ Title = "⛓・ChangesLogs" })
Tabs.Changelogs:AddSection("✏・Updated")
Tabs.Changelogs:AddParagraph({
    Title = "Latest Updates",
    Content = "• Fixed Dropdown Save Settings ✔\n• Added Info Of Target (Name/Health) ✔\n• Optimized Script ✔\n• Improved Fps Boost ✔"
})

-- TAB 3: Aimbot
Tabs.Aimbot = Window:AddTab({ Title = "❖・Aimbot" })
Tabs.Aimbot:AddSection("☘・Settings")

local AimlockPlayersToggle = Tabs.Aimbot:AddToggle("AimlockPlayers", {
    Title = "・Aimlock Players",
    Description = "Lock onto nearest player",
    Default = Settings["AimlockPlayers"] or false,
    Callback = function(state)
        AimlockModule:SetPlayerAimlock(state)
        Settings["AimlockPlayers"] = state
    end
})

local AimlockPlayersMiniToggle = Tabs.Aimbot:AddToggle("AimlockPlayersMini", {
    Title = "・Aimlock Mini Toggle Players",
    Description = "Lock onto nearest player",
    Default = Settings["AimlockPlayersMiniTogglePlayers"] or false,
    Callback = function(state)
        AimlockModule:SetMiniTogglePlayerAimlock(state)
        Settings["AimlockPlayersMiniTogglePlayers"] = state
    end
})

local AimlockNPCToggle = Tabs.Aimbot:AddToggle("AimlockNPC", {
    Title = "・Aimlock NPC",
    Description = "Lock onto nearest NPC/Boss",
    Default = Settings["AimlockNPC"] or false,
    Callback = function(state)
        AimlockModule:SetNpcAimlock(state)
        Settings["AimlockNPC"] = state
    end
})

local AimlockPlayersMiniNPCToggle = Tabs.Aimbot:AddToggle("AimlockPlayersMiniNPC", {
    Title = "・Aimlock Mini Toggle NPC",
    Description = "Lock onto nearest NPC/Boss",
    Default = Settings["AimlockPlayersMiniToggleNPC"] or false,
    Callback = function(state)
        AimlockModule:SetMiniToggleNpcAimlock(state)
        Settings["AimlockPlayersMiniToggleNPC"] = state
    end
})

local PredictionToggle = Tabs.Aimbot:AddToggle("Prediction", {
    Title = "・Prediction",
    Description = "Predict enemy movement",
    Default = Settings["Prediction"] or false,
    Callback = function(state)
        AimlockModule:SetPrediction(state)
        Settings["Prediction"] = state
    end
})

local PredictionAmountDropdown = Tabs.Aimbot:AddDropdown("PredictionAmount", {
    Title = "・Prediction Amount",
    Values = {"0.1", "0.2", "0.3", "0.4"},
    Default = tostring(Settings["PredictionAmount"] or 0.1),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            AimlockModule:SetPredictionTime(num)
            Settings["PredictionAmount"] = num
        end
    end
})

-- TAB 4: Silent Aimbot
Tabs.SilentAim = Window:AddTab({ Title = "⛩・Silent Aimbot" })
Tabs.SilentAim:AddSection("⚓・Settings")

local SilentAimPlayersToggle = Tabs.SilentAim:AddToggle("SilentAimPlayers", {
    Title = "・SilentAim Players",
    Description = "Lock onto nearest player",
    Default = Settings["SilentAimPlayers"] or false,
    Callback = function(state)
        SilentAimModule:SetPlayerSilentAim(state)
        Settings["SilentAimPlayers"] = state
    end
})

local SilentMiniTogglePlayersToggle = Tabs.SilentAim:AddToggle("SilentMiniPlayers", {
    Title = "・SilentAim Mini Toggle Players",
    Description = "Lock onto nearest player",
    Default = Settings["SilentMiniTogglePlayers"] or false,
    Callback = function(state)
        SilentAimModule:SetMiniTogglePlayerSilentAim(state)
        Settings["SilentMiniTogglePlayers"] = state
    end
})

local SilentAimNPCToggle = Tabs.SilentAim:AddToggle("SilentAimNPC", {
    Title = "・SilentAim Npcs",
    Description = "Lock onto nearest npc",
    Default = Settings["SilentAimNPC"] or false,
    Callback = function(state)
        SilentAimModule:SetNPCSilentAim(state)
        Settings["SilentAimNPC"] = state
    end
})

local SilentMiniToggleNPCToggle = Tabs.SilentAim:AddToggle("SilentMiniNPC", {
    Title = "・SilentAim Mini Toggle NPC",
    Description = "Lock onto nearest NPC/Boss",
    Default = Settings["SilentMiniToggleNPC"] or false,
    Callback = function(state)
        SilentAimModule:SetMiniToggleNpcSilentAim(state)
        Settings["SilentMiniToggleNPC"] = state
    end
})

local SilentAimPredictionToggle = Tabs.SilentAim:AddToggle("SilentAimPrediction", {
    Title = "・SilentAim Prediction",
    Description = "Prediction on target",
    Default = Settings["SilentAimPediction"] or false,
    Callback = function(state)
        SilentAimModule:SetPrediction(state)
        Settings["SilentAimPediction"] = state
    end
})

local SilentPredictionAmountDropdown = Tabs.SilentAim:AddDropdown("SilentPredictionAmount", {
    Title = "・Prediction Future",
    Values = {"0.1", "0.2", "0.3", "0.4"},
    Default = tostring(Settings["SilentAimPredictionFuture"] or 0.1),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetPredictionAmount(num)
            Settings["SilentAimPredictionFuture"] = num
        end
    end
})

local DistanceAmountDropdown = Tabs.SilentAim:AddDropdown("DistanceLimit", {
    Title = "・Distance Limit",
    Values = {"200", "400", "600", "800", "1000"},
    Default = tostring(Settings["SilentAimDistanceLimit"] or 1000),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetDistanceLimit(num)
            Settings["SilentAimDistanceLimit"] = num
        end
    end
})

-- Tạo player list
local PlayerList = {"None"}
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        table.insert(PlayerList, plr.Name)
    end
end

local PlayerDropdown = Tabs.SilentAim:AddDropdown("PlayerTarget", {
    Title = "・Select Player Target",
    Values = PlayerList,
    Default = Settings["SelectedPlayer"] or "None",
    Callback = function(selected)
        if selected == "None" then
            SilentAimModule:SetSelectedPlayer(nil)
            Settings["SelectedPlayer"] = nil
        else
            SilentAimModule:SetSelectedPlayer(selected)
            Settings["SelectedPlayer"] = selected
        end
    end
})

local ZSkillToggle = Tabs.SilentAim:AddToggle("ZSkills", {
    Title = "・GodhumanZ Aimlock",
    Description = "I only set Godhuman",
    Default = Settings["ZSkills"] or false,
    Callback = function(state)
        ZSkillModule:SetZSkills(state)
        Settings["ZSkills"] = state
    end
})

local HighlightToggle = Tabs.SilentAim:AddToggle("Highlight", {
    Title = "・Main Highlight",
    Description = "Current Target Highlighted",
    Default = Settings["Highlight"] or false,
    Callback = function(state)
        SilentAimModule:SetHighlight(state)
        Settings["Highlight"] = state
    end
})

local ZskillMOneToggle = Tabs.SilentAim:AddToggle("ZskillM1", {
    Title = "・Z|M1 Skills(except Godhuman Z)",
    Description = "Silent Aim That Work Some Skills",
    Default = Settings["Zskillmone"] or false,
    Callback = function(state)
        SilentAimModule:SetZSkillorM1(state)
        Settings["Zskillmone"] = state
    end
})

-- TAB 5: Features
Tabs.Features = Window:AddTab({ Title = "✿・Features" })
Tabs.Features:AddSection("⚜・Settings")

Tabs.Features:AddButton({
    Title = "Join Discord",
    Description = "Get Link Discord server",
    Callback = function()
        local link = "https://discord.gg/fKwqmB4C"
        if setclipboard then
            setclipboard(link)
            Window:Notify({
                Title = "Sapi Hub",
                Content = "Copied Discord Link!"
            })
        end
    end
})

local ESPPlayersToggle = Tabs.Features:AddToggle("ESPPlayers", {
    Title = "・ESP Players",
    Description = "Toggle Player ESP",
    Default = Settings["ESPPlayers"] or false,
    Callback = function(state)
        ESPModule:SetESP(state)
        Settings["ESPPlayers"] = state
    end
})

local V3SkillToggle = Tabs.Features:AddToggle("V3Skill", {
    Title = "・V3 Skill",
    Description = "Auto activate V3 ability",
    Default = Settings["V3Skill"] or false,
    Callback = function(state)
        ESPModule:SetV3(state)
        Settings["V3Skill"] = state
    end
})

local BunnyHopToggle = Tabs.Features:AddToggle("BunnyHop", {
    Title = "・Bunny hop",
    Description = "Toggle Bunnyhop",
    Default = Settings["BunnyHop"] or false,
    Callback = function(state)
        ESPModule:SetBunnyhop(state)
        Settings["BunnyHop"] = state
    end
})

local AuraSkillToggle = Tabs.Features:AddToggle("AuraSkill", {
    Title = "・Aura Skill",
    Description = "Auto activate Buso",
    Default = Settings["AuraSkill"] or false,
    Callback = function(state)
        ESPModule:SetBuso(state)
        Settings["AuraSkill"] = state
    end
})

local FpsOrPingsToggle = Tabs.Features:AddToggle("FpsOrPings", {
    Title = "・Fps Or Pings",
    Description = "Display Ping or Fps",
    Default = Settings["FpsOrPings"] or false,
    Callback = function(state)
        StuffsModule:SetPingsOrFps(state)
        Settings["FpsOrPings"] = state
    end
})

Tabs.Features:AddInput("SpeedHack", {
    Title = "Speed Hack",
    Placeholder = "Enter speed value...",
    Default = tostring(getgenv().WalkSpeedValue or 16),
    Callback = function(value)
        local num = tonumber(value)
        if num then
            getgenv().WalkSpeedValue = num
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = num
            end
        end
    end
})

local FpsBoostToggle = Tabs.Features:AddToggle("FpsBoost", {
    Title = "・Fps Boost",
    Description = "Increase Fps",
    Default = Settings["FpsBoost"] or false,
    Callback = function(state)
        StuffsModule:SetFpsBoost(state)
        Settings["FpsBoost"] = state
    end
})

local INFEnergyToggle = Tabs.Features:AddToggle("INFEnergy", {
    Title = "・INF Energy",
    Description = "Max Energy",
    Default = Settings["INFEnergy"] or false,
    Callback = function(state)
        StuffsModule:SetINFEnergy(state)
        Settings["INFEnergy"] = state
    end
})

local WalkonWaterToggle = Tabs.Features:AddToggle("WalkonWater", {
    Title = "・Walk on Water",
    Description = "Travel in Water",
    Default = Settings["WalkonWater"] or false,
    Callback = function(state)
        StuffsModule:SetWalkWater(state)
        Settings["WalkonWater"] = state
    end
})

local FastAttackToggle = Tabs.Features:AddToggle("FastAttack", {
    Title = "・Fast Attack",
    Description = "Fast Attack",
    Default = Settings["FastAttack"] or false,
    Callback = function(state)
        StuffsModule:SetFastAttack(state)
        Settings["FastAttack"] = state
    end
})

local AntiAFKToggle = Tabs.Features:AddToggle("AntiAFK", {
    Title = "・AntiAfk",
    Description = "Anti AFK",
    Default = Settings["AntiAFK"] or false,
    Callback = function(state)
        ESPModule:SetAntiAfk(state)
        Settings["AntiAFK"] = state
    end
})

Tabs.Features:AddInput("JumpPower", {
    Title = "Jump Power",
    Placeholder = "Enter jump power...",
    Default = tostring(getgenv().JumpValue or 50),
    Callback = function(value)
        getgenv().JumpValue = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = tonumber(value) or 50
        end
    end
})

local V4Toggle = Tabs.Features:AddToggle("V4", {
    Title = "・Auto V4",
    Description = "Auto V4 Transform",
    Default = Settings["V4"] or false,
    Callback = function(state)
        UiSettingsModule:SetV4(state)
        Settings["V4"] = state
    end
})

local FruitCheckToggle = Tabs.Features:AddToggle("FruitCheck", {
    Title = "・Spawned Fruit Check",
    Description = "Check Fruit Spawned",
    Default = Settings["FruitCheck"] or false,
    Callback = function(state)
        UiSettingsModule:SetFruitCheck(state)
        Settings["FruitCheck"] = state
    end
})

local TeleportFruitToggle = Tabs.Features:AddToggle("TeleportFruit", {
    Title = "・Bring Fruits",
    Description = "Bring fruits to you",
    Default = Settings["TeleportFruit"] or false,
    Callback = function(state)
        UiSettingsModule:SetTeleportFruit(state)
        Settings["TeleportFruit"] = state
    end
})

local AutoKenToggle = Tabs.Features:AddToggle("AutoKen", {
    Title = "・Auto Ken",
    Description = "Auto Ken",
    Default = Settings["AutoKen"] or false,
    Callback = function(state)
        SilentAimModule:SetAutoKen(state)
        Settings["AutoKen"] = state
    end
})

local LavaToggle = Tabs.Features:AddToggle("Lava", {
    Title = "・Remove Lava",
    Description = "Remove Lava",
    Default = Settings["Lava"] or false,
    Callback = function(state)
        StuffsModule:SetLava(state)
        Settings["Lava"] = state
    end
})

local FogToggle = Tabs.Features:AddToggle("Fog", {
    Title = "・Remove Fog",
    Description = "Remove Fog",
    Default = Settings["Fog"] or false,
    Callback = function(state)
        StuffsModule:SetFog(state)
        Settings["Fog"] = state
    end
})

local DodgeToggle = Tabs.Features:AddToggle("Dodge", {
    Title = "・Dodge no cd",
    Description = "Dodge no cooldown",
    Default = Settings["Dodge"] or false,
    Callback = function(state)
        ESPModule:SetNoDodgeCD(state)
        Settings["Dodge"] = state
    end
})

local OpponentToggle = Tabs.Features:AddToggle("Opponent", {
    Title = "・Target Info",
    Description = "Show target name/health",
    Default = Settings["Opponent"] or false,
    Callback = function(state)
        ZSkillModule:SetInfo(state)
        Settings["Opponent"] = state
    end
})

-- TAB 6: Settings Manager
Tabs.Settings = Window:AddTab({ Title = "⚙・Settings Manager" })
Tabs.Settings:AddSection("💾・Settings")

Tabs.Settings:AddInput("JobID", {
    Title = "Paste Job Id Here",
    Placeholder = "Enter Job ID...",
    Default = "",
    Callback = function(jobid)
        if jobid and jobid ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, jobid, LocalPlayer)
        end
    end
})

Tabs.Settings:AddButton({
    Title = "Save Current Settings",
    Description = "Save all current settings",
    Callback = function()
        OthersStuffsModule.SaveSettings(Settings)
        Window:Notify({
            Title = "Sapi Hub",
            Content = "Settings Saved!"
        })
    end
})

Tabs.Settings:AddButton({
    Title = "Reset Settings",
    Description = "Clear saved settings",
    Callback = function()
        OthersStuffsModule.ResetSettings()
        Settings = {}
        Window:Notify({
            Title = "Sapi Hub",
            Content = "Settings Reset!"
        })
    end
})

Tabs.Settings:AddButton({
    Title = "Rejoin Server",
    Description = "Rejoin your server",
    Callback = function()
        StuffsModule:SetRejoinServer()
    end
})

local GlobalTextDropdown = Tabs.Settings:AddDropdown("GlobalFont", {
    Title = "・Global Text Font",
    Values = {"Garamond", "RobotoMono", "FredokaOne", "Oswald", "Nunito"},
    Default = Settings["GlobalFont"] or "Garamond",
    Callback = function(selected)
        local fontEnum = Enum.Font[selected]
        if fontEnum then
            ESPModule:SetGlobalFont(fontEnum)
            Settings["GlobalFont"] = selected
        end
    end
})

local RTXModeDropdown = Tabs.Settings:AddDropdown("RTXMode", {
    Title = "・RTX Graphics Mode",
    Values = {"Autumn", "Summer", "Spring", "Winter"},
    Default = Settings["RTXMode"] or "Summer",
    Callback = function(selected)
        ESPModule:SetRTXMode(selected)
        Settings["RTXMode"] = selected
    end
})

-- Phím tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.M then
            WindUI:Toggle()
        elseif input.KeyCode == Enum.KeyCode.G then
            local newState = not (Settings["SilentAimPlayers"] or false)
            Settings["SilentAimPlayers"] = newState
            SilentAimModule:SetPlayerSilentAim(newState)
            if SilentAimPlayersToggle then
                SilentAimPlayersToggle:SetValue(newState)
            end
            Window:Notify({
                Title = "Sapi Hub",
                Content = "Silent Aim: " .. (newState and "ON" or "OFF")
            })
        end
    end
end)

-- Start fruit notifier
OthersStuffsModule.StartFruitNotifier()

-- Thông báo khởi động
Window:Notify({
    Title = "Sapi Hub",
    Content = "Loaded Successfully! Press M to toggle UI"
})

print("✅ Sapi Hub loaded! Press M to toggle UI")
