--[[
    SAPI HUB BF PVP - Tích hợp Rubu Hub UI
    Đã loại bỏ UI cũ và sử dụng Rubu Hub UI
--]]

-- Khởi tạo thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Load các module
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
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- Biến toàn cục
local PlayerList = {"None"}
local Settings = OthersStuffsModule.LoadSettings()

-- Lấy thông tin executor
local executor = "Unknown"
if syn then executor = "Synapse X"
elseif KRNL_LOADED then executor = "KRNL"
elseif fluxus then executor = "Fluxus"
elseif getexecutorname then
    local success, execName = pcall(getexecutorname)
    if success and type(execName) == "string" then executor = execName end
end

local execStatus = (executor == "Xeno" or executor:lower():find("solara") or executor:lower():find("krnl")) and "Not Working" or "Working"

-- Tạo cửa sổ chính
local SapiHub = WindUI:CreateWindow({
    ["Title"] = "Sapi Hub BF PvP ˃ᴗ˂",
    ["Author"] = " | " .. executor .. " [" .. execStatus .. "]",
    ["Folder"] = "SapiHub",
    ["Size"] = UDim2.fromOffset(580, 460),
    ["Transparent"] = true,
    ["Theme"] = "Dark",
    ["SideBarWidth"] = 200,
    ["HideSearchBar"] = false,
    ["ScrollBarEnabled"] = true,
    ["MinimizeKey"] = Enum.KeyCode.M
})

-- Hàm tạo thông báo
function SapiHub:Notify(options)
    WindUI:Popup({
        ["Title"] = options.Title or "Sapi Hub",
        ["Content"] = options.Content or ""
    })
end

-- Tạo các tab
local Tabs = {}

-- Tab 1: Executor Status
Tabs.Executor = SapiHub:Tab({ ["Title"] = "◇・Executor Status", ["Icon"] = "" })
local ExecSection = Tabs.Executor:Section("◈・Information")
Tabs.Executor:Paragraph({
    ["Title"] = "Executor Information",
    ["Content"] = "Executor: " .. executor .. "\nStatus: " .. execStatus
})

-- Tab 2: ChangesLogs
Tabs.Changelogs = SapiHub:Tab({ ["Title"] = "⛓・ChangesLogs", ["Icon"] = "" })
local ChangelogSection = Tabs.Changelogs:Section("✏・Updated")
Tabs.Changelogs:Paragraph({
    ["Title"] = "Latest Updates",
    ["Content"] = "• Fixed Dropdown Save Settings ✔\n• Added Info Of Target (Name/Health) ✔\n• Optimized Script ✔\n• Improved Fps Boost ✔\n• Fixed Soul Guitar M1 in Silent aim ✔\n• Added RTX Graphic(Visual Vibes) ✔\n• Added Custom Global Text ✔\n• Added Dash No CD ✔\n• Added Remove Fog or Lava ✔\n• Added Z Skills Work(Except Godhuman Z) ✔\n• Added Fruit M1 Closet Attack ✔\n• Fixed Buddy Sword X in Silent aim ✔"
})

-- Tab 3: Aimbot
Tabs.Aimbot = SapiHub:Tab({ ["Title"] = "❖・Aimbot", ["Icon"] = "" })
local AimbotSection = Tabs.Aimbot:Section("☘・Settings")

-- Aimbot Players
local AimlockPlayersToggle = Tabs.Aimbot:Toggle({
    ["Title"] = "・Aimlock Players",
    ["Desc"] = "Lock onto nearest player",
    ["Default"] = Settings["AimlockPlayers"] or false,
    ["Callback"] = function(state)
        AimlockModule:SetPlayerAimlock(state)
        Settings["AimlockPlayers"] = state
    end
})

-- Aimlock Mini Players
local AimlockPlayersMiniToggle = Tabs.Aimbot:Toggle({
    ["Title"] = "・Aimlock Mini Toggle Players",
    ["Desc"] = "Lock onto nearest player",
    ["Default"] = Settings["AimlockPlayersMiniTogglePlayers"] or false,
    ["Callback"] = function(state)
        AimlockModule:SetMiniTogglePlayerAimlock(state)
        Settings["AimlockPlayersMiniTogglePlayers"] = state
    end
})

-- Aimlock NPC
local AimlockNPCToggle = Tabs.Aimbot:Toggle({
    ["Title"] = "・Aimlock NPC",
    ["Desc"] = "Lock onto nearest NPC/Boss",
    ["Default"] = Settings["AimlockNPC"] or false,
    ["Callback"] = function(state)
        AimlockModule:SetNpcAimlock(state)
        Settings["AimlockNPC"] = state
    end
})

-- Aimlock Mini NPC
local AimlockPlayersMiniNPCToggle = Tabs.Aimbot:Toggle({
    ["Title"] = "・Aimlock Mini Toggle NPC",
    ["Desc"] = "Lock onto nearest NPC/Boss",
    ["Default"] = Settings["AimlockPlayersMiniToggleNPC"] or false,
    ["Callback"] = function(state)
        AimlockModule:SetMiniToggleNpcAimlock(state)
        Settings["AimlockPlayersMiniToggleNPC"] = state
    end
})

-- Prediction
local PredictionToggle = Tabs.Aimbot:Toggle({
    ["Title"] = "・Prediction",
    ["Desc"] = "Predict enemy movement",
    ["Default"] = Settings["Prediction"] or false,
    ["Callback"] = function(state)
        AimlockModule:SetPrediction(state)
        Settings["Prediction"] = state
    end
})

-- Prediction Amount
local PredictionAmountDropdown = Tabs.Aimbot:Dropdown({
    ["Title"] = "・Prediction Amount",
    ["Desc"] = "Select max Prediction for Aimlock (Default 0.1s)",
    ["Values"] = {"0.2", "0.3", "0.4"},
    ["Default"] = tostring(Settings["PredictionAmount"] or 0.1),
    ["Callback"] = function(selected)
        local num = tonumber(selected)
        if num then
            AimlockModule:SetPredictionTime(num)
            Settings["PredictionAmount"] = num
        end
    end
})

-- Tab 4: Silent Aimbot
Tabs.SilentAim = SapiHub:Tab({ ["Title"] = "⛩・Silent Aimbot", ["Icon"] = "" })
local SilentSection = Tabs.SilentAim:Section("⚓・Settings")

-- Silent Aim Players
local SilentAimPlayersToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・SilentAim Players",
    ["Desc"] = "Lock onto nearest player",
    ["Default"] = Settings["SilentAimPlayers"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetPlayerSilentAim(state)
        Settings["SilentAimPlayers"] = state
    end
})

-- Silent Mini Players
local SilentMiniTogglePlayersToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・SilentAim Mini Toggle Players",
    ["Desc"] = "Lock onto nearest player",
    ["Default"] = Settings["SilentMiniTogglePlayers"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetMiniTogglePlayerSilentAim(state)
        Settings["SilentMiniTogglePlayers"] = state
    end
})

-- Silent Aim NPC
local SilentAimNPCToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・SilentAim Npcs",
    ["Desc"] = "Lock onto nearest npc",
    ["Default"] = Settings["SilentAimNPC"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetNPCSilentAim(state)
        Settings["SilentAimNPC"] = state
    end
})

-- Silent Mini NPC
local SilentMiniToggleNPCToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・SilentAim Mini Toggle NPC",
    ["Desc"] = "Lock onto nearest NPC/Boss",
    ["Default"] = Settings["SilentMiniToggleNPC"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetMiniToggleNpcSilentAim(state)
        Settings["SilentMiniToggleNPC"] = state
    end
})

-- Silent Prediction
local SilentAimPredictionToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・SilentAim Prediction",
    ["Desc"] = "Prediction on target",
    ["Default"] = Settings["SilentAimPediction"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetPrediction(state)
        Settings["SilentAimPediction"] = state
    end
})

-- Silent Prediction Amount
local SilentPredictionAmountDropdown = Tabs.SilentAim:Dropdown({
    ["Title"] = "・Prediction Future",
    ["Desc"] = "Select max Prediction for Silent Aim (Default 0.1s)",
    ["Values"] = {"0.2", "0.3", "0.4"},
    ["Default"] = tostring(Settings["SilentAimPredictionFuture"] or 0.1),
    ["Callback"] = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetPredictionAmount(num)
            Settings["SilentAimPredictionFuture"] = num
        end
    end
})

-- Distance Limit
local DistanceAmountDropdown = Tabs.SilentAim:Dropdown({
    ["Title"] = "・Distance Limit",
    ["Desc"] = "Select max distance for aimbot (Default 1000m)",
    ["Values"] = {"200", "400", "600", "800", "1000"},
    ["Default"] = tostring(Settings["SilentAimDistanceLimit"] or 1000),
    ["Callback"] = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetDistanceLimit(num)
            Settings["SilentAimDistanceLimit"] = num
        end
    end
})

-- Update player list
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        table.insert(PlayerList, plr.Name)
    end
end

-- Select Player Target
local PlayerDropdown = Tabs.SilentAim:Dropdown({
    ["Title"] = "・Select Player Target",
    ["Desc"] = "Choose a player to lock onto",
    ["Values"] = PlayerList,
    ["Default"] = Settings["SelectedPlayer"] or "None",
    ["Callback"] = function(selected)
        if selected == "None" then
            SilentAimModule:SetSelectedPlayer(nil)
            Settings["SelectedPlayer"] = nil
        else
            SilentAimModule:SetSelectedPlayer(selected)
            Settings["SelectedPlayer"] = selected
        end
    end
})

-- Refresh player list
local function RefreshPlayerList()
    local newList = {"None"}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(newList, plr.Name)
        end
    end
    PlayerDropdown:SetValues(newList)
end

Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

-- Godhuman Z Aimlock
local ZSkillToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・GodhumanZ Aimlock",
    ["Desc"] = "I only set Godhuman",
    ["Default"] = Settings["ZSkills"] or false,
    ["Callback"] = function(state)
        ZSkillModule:SetZSkills(state)
        Settings["ZSkills"] = state
    end
})

-- Highlight
local HighlightToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・Main Highlight",
    ["Desc"] = "Current Target Highlighted",
    ["Default"] = Settings["Highlight"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetHighlight(state)
        Settings["Highlight"] = state
    end
})

-- Z|M1 Skills
local ZskillMOneToggle = Tabs.SilentAim:Toggle({
    ["Title"] = "・Z|M1 Skills(except Godhuman Z)",
    ["Desc"] = "Silent Aim That Work Some Skills",
    ["Default"] = Settings["Zskillmone"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetZSkillorM1(state)
        Settings["Zskillmone"] = state
    end
})

-- Tab 5: Features
Tabs.Features = SapiHub:Tab({ ["Title"] = "✿・Features", ["Icon"] = "" })
local FeaturesSection = Tabs.Features:Section("⚜・Settings")

-- Join Discord Button
Tabs.Features:Button({
    ["Title"] = "Join Discord",
    ["Desc"] = "Get Link Discord server",
    ["Callback"] = function()
        local link = "https://discord.gg/fKwqmB4C"
        if setclipboard then
            setclipboard(link)
            SapiHub:Notify({
                Title = "Sapi Hub",
                Content = "Copied Discord Link!"
            })
        end
    end
})

-- ESP Players
local ESPPlayersToggle = Tabs.Features:Toggle({
    ["Title"] = "・ESP Players",
    ["Desc"] = "Toggle Player ESP",
    ["Default"] = Settings["ESPPlayers"] or false,
    ["Callback"] = function(state)
        ESPModule:SetESP(state)
        Settings["ESPPlayers"] = state
    end
})

-- V3 Skill
local V3SkillToggle = Tabs.Features:Toggle({
    ["Title"] = "・V3 Skill",
    ["Desc"] = "Auto activate V3 ability",
    ["Default"] = Settings["V3Skill"] or false,
    ["Callback"] = function(state)
        ESPModule:SetV3(state)
        Settings["V3Skill"] = state
    end
})

-- Bunny Hop
local BunnyHopToggle = Tabs.Features:Toggle({
    ["Title"] = "・Bunny hop",
    ["Desc"] = "Toggle Bunnyhop",
    ["Default"] = Settings["BunnyHop"] or false,
    ["Callback"] = function(state)
        ESPModule:SetBunnyhop(state)
        Settings["BunnyHop"] = state
    end
})

-- Aura Skill
local AuraSkillToggle = Tabs.Features:Toggle({
    ["Title"] = "・Aura Skill",
    ["Desc"] = "Auto activate Buso",
    ["Default"] = Settings["AuraSkill"] or false,
    ["Callback"] = function(state)
        ESPModule:SetBuso(state)
        Settings["AuraSkill"] = state
    end
})

-- FPS or Pings
local FpsOrPingsToggle = Tabs.Features:Toggle({
    ["Title"] = "・Fps Or Pings",
    ["Desc"] = "Display Ping or Fps",
    ["Default"] = Settings["FpsOrPings"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetPingsOrFps(state)
        Settings["FpsOrPings"] = state
    end
})

-- Speed Hack
Tabs.Features:Input({
    ["Title"] = "Speed Hack",
    ["Desc"] = "Set Walk Speed Value",
    ["Placeholder"] = "Enter speed value...",
    ["Default"] = tostring(getgenv().WalkSpeedValue or 16),
    ["Callback"] = function(value)
        local num = tonumber(value)
        if num then
            getgenv().WalkSpeedValue = num
            UiSettingsModule:SetWalkSpeed(num)
        end
    end
})

-- FPS Boost
local FpsBoostToggle = Tabs.Features:Toggle({
    ["Title"] = "・Fps Boost",
    ["Desc"] = "Increase Fps",
    ["Default"] = Settings["FpsBoost"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetFpsBoost(state)
        Settings["FpsBoost"] = state
    end
})

-- INF Energy
local INFEnergyToggle = Tabs.Features:Toggle({
    ["Title"] = "・INF Energy",
    ["Desc"] = "Max Energy",
    ["Default"] = Settings["INFEnergy"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetINFEnergy(state)
        Settings["INFEnergy"] = state
    end
})

-- Walk on Water
local WalkonWaterToggle = Tabs.Features:Toggle({
    ["Title"] = "・Walk on Water",
    ["Desc"] = "Travel in Water",
    ["Default"] = Settings["WalkonWater"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetWalkWater(state)
        Settings["WalkonWater"] = state
    end
})

-- Fast Attack
local FastAttackToggle = Tabs.Features:Toggle({
    ["Title"] = "・Fast Attack",
    ["Desc"] = "Fast Attack",
    ["Default"] = Settings["FastAttack"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetFastAttack(state)
        Settings["FastAttack"] = state
    end
})

-- Anti AFK
local AntiAFKToggle = Tabs.Features:Toggle({
    ["Title"] = "・AntiAfk",
    ["Desc"] = "AntiAfk only on before you off",
    ["Default"] = Settings["AntiAFK"] or false,
    ["Callback"] = function(state)
        ESPModule:SetAntiAfk(state)
        Settings["AntiAFK"] = state
    end
})

-- Jump Power
Tabs.Features:Input({
    ["Title"] = "Jump Power",
    ["Desc"] = "Set Jump Power Value",
    ["Placeholder"] = "Enter jump power...",
    ["Default"] = tostring(getgenv().JumpValue or 50),
    ["Callback"] = function(value)
        getgenv().JumpValue = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = tonumber(value) or 50
        end
    end
})

-- Auto V4
local V4Toggle = Tabs.Features:Toggle({
    ["Title"] = "・Auto V4",
    ["Desc"] = "Auto V4 Transform",
    ["Default"] = Settings["V4"] or false,
    ["Callback"] = function(state)
        UiSettingsModule:SetV4(state)
        Settings["V4"] = state
    end
})

-- Fruit Check
local FruitCheckToggle = Tabs.Features:Toggle({
    ["Title"] = "・Spawned Fruit Check",
    ["Desc"] = "Check Fruit Spawned",
    ["Default"] = Settings["FruitCheck"] or false,
    ["Callback"] = function(state)
        UiSettingsModule:SetFruitCheck(state)
        Settings["FruitCheck"] = state
    end
})

-- Bring Fruits
local TeleportFruitToggle = Tabs.Features:Toggle({
    ["Title"] = "・Bring Fruits",
    ["Desc"] = "It take few seconds to bring fruits",
    ["Default"] = Settings["TeleportFruit"] or false,
    ["Callback"] = function(state)
        UiSettingsModule:SetTeleportFruit(state)
        Settings["TeleportFruit"] = state
    end
})

-- Auto Ken
local AutoKenToggle = Tabs.Features:Toggle({
    ["Title"] = "・Auto Ken",
    ["Desc"] = "AutoKen",
    ["Default"] = Settings["AutoKen"] or false,
    ["Callback"] = function(state)
        SilentAimModule:SetAutoKen(state)
        Settings["AutoKen"] = state
    end
})

-- Remove Lava
local LavaToggle = Tabs.Features:Toggle({
    ["Title"] = "・Remove Lava",
    ["Desc"] = "Remove Lava",
    ["Default"] = Settings["Lava"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetLava(state)
        Settings["Lava"] = state
    end
})

-- Remove Fog
local FogToggle = Tabs.Features:Toggle({
    ["Title"] = "・Remove Fog",
    ["Desc"] = "Remove Fog",
    ["Default"] = Settings["Fog"] or false,
    ["Callback"] = function(state)
        StuffsModule:SetFog(state)
        Settings["Fog"] = state
    end
})

-- Dodge no cd
local DodgeToggle = Tabs.Features:Toggle({
    ["Title"] = "・Dodge no cd",
    ["Desc"] = "Dodge no cd",
    ["Default"] = Settings["Dodge"] or false,
    ["Callback"] = function(state)
        ESPModule:SetNoDodgeCD(state)
        Settings["Dodge"] = state
    end
})

-- Target Info
local OpponentToggle = Tabs.Features:Toggle({
    ["Title"] = "・Target Info(Name/Health)",
    ["Desc"] = "Info Of Target",
    ["Default"] = Settings["Opponent"] or false,
    ["Callback"] = function(state)
        ZSkillModule:SetInfo(state)
        Settings["Opponent"] = state
    end
})

-- Tab 6: Settings Manager
Tabs.Settings = SapiHub:Tab({ ["Title"] = "⚙・Settings Manager", ["Icon"] = "" })
local SettingsSection = Tabs.Settings:Section("💾・Settings")

-- Job ID Input
Tabs.Settings:Input({
    ["Title"] = "Paste Job Id Here",
    ["Desc"] = "Paste JobId and press Enter",
    ["Placeholder"] = "Enter Job ID...",
    ["Default"] = "",
    ["Callback"] = function(jobid)
        if jobid and jobid ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, jobid, LocalPlayer)
        end
    end
})

-- Save Settings
Tabs.Settings:Button({
    ["Title"] = "Save Current Settings",
    ["Desc"] = "Save all current settings",
    ["Callback"] = function()
        OthersStuffsModule.SaveSettings(Settings)
        SapiHub:Notify({
            Title = "Sapi Hub",
            Content = "Settings Saved!"
        })
    end
})

-- Reset Settings
Tabs.Settings:Button({
    ["Title"] = "Reset Settings",
    ["Desc"] = "Clear saved settings",
    ["Callback"] = function()
        OthersStuffsModule.ResetSettings()
        Settings = {}
        SapiHub:Notify({
            Title = "Sapi Hub",
            Content = "Settings Reset!"
        })
    end
})

-- Rejoin Server
Tabs.Settings:Button({
    ["Title"] = "Rejoin Server",
    ["Desc"] = "Rejoin your server",
    ["Callback"] = function()
        StuffsModule:SetRejoinServer()
    end
})

-- Global Text Font
local GlobalTextDropdown = Tabs.Settings:Dropdown({
    ["Title"] = "・Global Text Font",
    ["Desc"] = "Change font for all text",
    ["Values"] = {
        "Arcade", "Cartoon", "SciFi", "Fantasy", "Antique",
        "Garamond", "RobotoMono", "FredokaOne", "LuckiestGuy",
        "PermanentMarker", "SpecialElite", "Oswald", "Nunito"
    },
    ["Default"] = Settings["GlobalFont"] or "Garamond",
    ["Callback"] = function(selected)
        local fontEnum = Enum.Font[selected]
        if fontEnum then
            ESPModule:SetGlobalFont(fontEnum)
            Settings["GlobalFont"] = selected
        end
    end
})

-- RTX Graphics Mode
local RTXModeDropdown = Tabs.Settings:Dropdown({
    ["Title"] = "・RTX Graphics Mode",
    ["Desc"] = "Choose between Autumn or Summer lighting",
    ["Values"] = {"Autumn", "Summer", "Spring", "Winter"},
    ["Default"] = Settings["RTXMode"] or "Summer",
    ["Callback"] = function(selected)
        ESPModule:SetRTXMode(selected)
        Settings["RTXMode"] = selected
    end
})

-- Theme Selection
local ThemesDropdown = Tabs.Settings:Dropdown({
    ["Title"] = "Select Theme",
    ["Desc"] = "Choose a color theme",
    ["Values"] = UiSettingsModule:getThemeNames(),
    ["Default"] = Settings["Themes"] or "Dark",
    ["Callback"] = function(selected)
        local newColor = UiSettingsModule.themes[selected]
        if newColor then
            UiSettingsModule:updateSchemeColor(newColor, { updateTheme = function(color) 
                WindUI:SetTheme(color) 
            end})
            Settings["Themes"] = selected
        end
    end
})

-- Background Theme
local BackgroundThemesDropdown = Tabs.Settings:Dropdown({
    ["Title"] = "Select Background Theme",
    ["Desc"] = "Choose a color background",
    ["Values"] = UiSettingsModule:getBackgroundThemeNames(),
    ["Default"] = Settings["BackgroundThemes"] or "Dark",
    ["Callback"] = function(selected)
        local newColor = UiSettingsModule.backgroundThemes[selected]
        if newColor then
            UiSettingsModule:updateBackgroundColor(newColor, { updateBackground = function(color) end })
            Settings["BackgroundThemes"] = selected
        end
    end
})

-- Text Color
local TextColorDropdown = Tabs.Settings:Dropdown({
    ["Title"] = "Select TextColor",
    ["Desc"] = "Choose a textcolor",
    ["Values"] = UiSettingsModule:getThemeNames(),
    ["Default"] = Settings["TextColor"] or "Dark",
    ["Callback"] = function(selected)
        local newColor = UiSettingsModule.themes[selected]
        if newColor then
            UiSettingsModule:updateTextColor(newColor, { updateText = function(color) end })
            Settings["TextColor"] = selected
        end
    end
})

-- Áp dụng settings đã lưu
Settings = OthersStuffsModule.LoadSettings()

OthersStuffsModule:ApplySettings(Settings, {
    Aimlock = AimlockModule,
    SilentAim = SilentAimModule,
    ESP = ESPModule,
    Stuffs = StuffsModule,
    Ui = UiSettingsModule,
    Zskill = ZSkillModule
}, {
    AimlockPlayers = AimlockPlayersToggle,
    AimlockPlayersMiniTogglePlayers = AimlockPlayersMiniToggle,
    AimlockNPC = AimlockNPCToggle,
    SilentAimPlayers = SilentAimPlayersToggle,
    SilentAimNPC = SilentAimNPCToggle,
    ESPPlayers = ESPPlayersToggle,
    AntiAFK = AntiAFKToggle,
    FpsOrPings = FpsOrPingsToggle,
    FpsBoost = FpsBoostToggle,
    INFEnergy = INFEnergyToggle,
    FastAttack = FastAttackToggle,
    WalkonWater = WalkonWaterToggle,
    V4 = V4Toggle,
    FruitCheck = FruitCheckToggle,
    TeleportFruit = TeleportFruitToggle,
    AutoKen = AutoKenToggle,
    ZSkills = ZSkillToggle,
    BunnyHop = BunnyHopToggle,
    AuraSkill = AuraSkillToggle,
    V3Skill = V3SkillToggle,
    Highlight = HighlightToggle,
    SilentMiniToggleNPC = SilentMiniToggleNPCToggle,
    SilentMiniTogglePlayers = SilentMiniTogglePlayersToggle,
    Zskillmone = ZskillMOneToggle,
    SilentAimPediction = SilentAimPredictionToggle,
    Dodge = DodgeToggle,
    Lava = LavaToggle,
    Fog = FogToggle,
    PredictionAmount = PredictionAmountDropdown,
    SilentAimPredictionFuture = SilentPredictionAmountDropdown,
    SilentAimDistanceLimit = DistanceAmountDropdown,
    GlobalFont = GlobalTextDropdown,
    RTXMode = RTXModeDropdown,
    Themes = ThemesDropdown,
    BackgroundThemes = BackgroundThemesDropdown,
    TextColor = TextColorDropdown
})

-- Start fruit notifier
OthersStuffsModule.StartFruitNotifier()

-- Phím tắt mở/tắt UI (M)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.M then
        WindUI:Toggle()
    end
end)

-- Phím tắt bật/tắt Silent Aim (G)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.G then
        Settings["SilentAimPlayers"] = not Settings["SilentAimPlayers"]
        SilentAimModule:SetPlayerSilentAim(Settings["SilentAimPlayers"])
        if SilentAimPlayersToggle then
            SilentAimPlayersToggle:SetValue(Settings["SilentAimPlayers"])
        end
    end
end)
