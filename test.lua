--[[
    SAPI HUB BF PVP - Fix UI không hiển thị element
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
local LocalPlayer = Players.LocalPlayer

-- Settings
local Settings = OthersStuffsModule.LoadSettings() or {}

-- Tạo Window
local Window = WindUI:CreateWindow({
    Title = "Sapi Hub BF PvP ˃ᴗ˂",
    Author = " | Velocity",
    Folder = "SapiHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    MinimizeKey = Enum.KeyCode.M
})

-- === TAB 1: EXECUTOR STATUS ===
local Tab1 = Window:Tab({ Title = "◇・Executor Status" })

-- Section
local Section1 = Tab1:Section("◈・Information")

-- Paragraph
Tab1:Paragraph({
    Title = "Executor Information",
    Desc = "Executor: Velocity\nStatus: Working"
})

-- === TAB 2: CHANGELOGS ===
local Tab2 = Window:Tab({ Title = "⛓・ChangesLogs" })

-- Section
local Section2 = Tab2:Section("✏・Updated")

-- Paragraph
Tab2:Paragraph({
    Title = "Latest Updates",
    Desc = "• Fixed Dropdown Save Settings ✔\n• Added Info Of Target (Name/Health) ✔\n• Optimized Script ✔\n• Improved Fps Boost ✔"
})

-- === TAB 3: AIMBOT ===
local Tab3 = Window:Tab({ Title = "❖・Aimbot" })

-- Section
local Section3 = Tab3:Section("☘・Settings")

-- Toggle 1
local Toggle1 = Tab3:Toggle({
    Title = "・Aimlock Players",
    Desc = "Lock onto nearest player",
    Default = Settings["AimlockPlayers"] or false,
    Callback = function(state)
        AimlockModule:SetPlayerAimlock(state)
        Settings["AimlockPlayers"] = state
        print("Aimlock Players:", state)
    end
})

-- Toggle 2
local Toggle2 = Tab3:Toggle({
    Title = "・Aimlock NPC",
    Desc = "Lock onto nearest NPC/Boss",
    Default = Settings["AimlockNPC"] or false,
    Callback = function(state)
        AimlockModule:SetNpcAimlock(state)
        Settings["AimlockNPC"] = state
        print("Aimlock NPC:", state)
    end
})

-- Toggle 3
local Toggle3 = Tab3:Toggle({
    Title = "・Prediction",
    Desc = "Predict enemy movement",
    Default = Settings["Prediction"] or false,
    Callback = function(state)
        AimlockModule:SetPrediction(state)
        Settings["Prediction"] = state
        print("Prediction:", state)
    end
})

-- Dropdown
local Dropdown1 = Tab3:Dropdown({
    Title = "・Prediction Amount",
    Desc = "Select prediction time",
    Values = {"0.1", "0.2", "0.3", "0.4"},
    Default = tostring(Settings["PredictionAmount"] or 0.1),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            AimlockModule:SetPredictionTime(num)
            Settings["PredictionAmount"] = num
            print("Prediction Amount:", num)
        end
    end
})

-- === TAB 4: SILENT AIMBOT ===
local Tab4 = Window:Tab({ Title = "⛩・Silent Aimbot" })

-- Section
local Section4 = Tab4:Section("⚓・Settings")

-- Toggle 1
local Toggle4 = Tab4:Toggle({
    Title = "・SilentAim Players",
    Desc = "Lock onto nearest player",
    Default = Settings["SilentAimPlayers"] or false,
    Callback = function(state)
        SilentAimModule:SetPlayerSilentAim(state)
        Settings["SilentAimPlayers"] = state
        print("Silent Aim Players:", state)
    end
})

-- Toggle 2
local Toggle5 = Tab4:Toggle({
    Title = "・SilentAim NPC",
    Desc = "Lock onto nearest NPC",
    Default = Settings["SilentAimNPC"] or false,
    Callback = function(state)
        SilentAimModule:SetNPCSilentAim(state)
        Settings["SilentAimNPC"] = state
        print("Silent Aim NPC:", state)
    end
})

-- Toggle 3
local Toggle6 = Tab4:Toggle({
    Title = "・SilentAim Prediction",
    Desc = "Prediction on target",
    Default = Settings["SilentAimPediction"] or false,
    Callback = function(state)
        SilentAimModule:SetPrediction(state)
        Settings["SilentAimPediction"] = state
        print("Silent Aim Prediction:", state)
    end
})

-- Dropdown 1
local Dropdown2 = Tab4:Dropdown({
    Title = "・Prediction Future",
    Desc = "Select prediction amount",
    Values = {"0.1", "0.2", "0.3", "0.4"},
    Default = tostring(Settings["SilentAimPredictionFuture"] or 0.1),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetPredictionAmount(num)
            Settings["SilentAimPredictionFuture"] = num
            print("Silent Prediction Amount:", num)
        end
    end
})

-- Dropdown 2
local Dropdown3 = Tab4:Dropdown({
    Title = "・Distance Limit",
    Desc = "Select max distance",
    Values = {"200", "400", "600", "800", "1000"},
    Default = tostring(Settings["SilentAimDistanceLimit"] or 1000),
    Callback = function(selected)
        local num = tonumber(selected)
        if num then
            SilentAimModule:SetDistanceLimit(num)
            Settings["SilentAimDistanceLimit"] = num
            print("Distance Limit:", num)
        end
    end
})

-- === TAB 5: FEATURES ===
local Tab5 = Window:Tab({ Title = "✿・Features" })

-- Section
local Section5 = Tab5:Section("⚜・Settings")

-- Button
Tab5:Button({
    Title = "Join Discord",
    Desc = "Get Link Discord server",
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

-- Toggle 1
local Toggle7 = Tab5:Toggle({
    Title = "・ESP Players",
    Desc = "Toggle Player ESP",
    Default = Settings["ESPPlayers"] or false,
    Callback = function(state)
        ESPModule:SetESP(state)
        Settings["ESPPlayers"] = state
        print("ESP Players:", state)
    end
})

-- Toggle 2
local Toggle8 = Tab5:Toggle({
    Title = "・V3 Skill",
    Desc = "Auto activate V3 ability",
    Default = Settings["V3Skill"] or false,
    Callback = function(state)
        ESPModule:SetV3(state)
        Settings["V3Skill"] = state
        print("V3 Skill:", state)
    end
})

-- Toggle 3
local Toggle9 = Tab5:Toggle({
    Title = "・Bunny hop",
    Desc = "Toggle Bunnyhop",
    Default = Settings["BunnyHop"] or false,
    Callback = function(state)
        ESPModule:SetBunnyhop(state)
        Settings["BunnyHop"] = state
        print("Bunny Hop:", state)
    end
})

-- Toggle 4
local Toggle10 = Tab5:Toggle({
    Title = "・Aura Skill",
    Desc = "Auto activate Buso",
    Default = Settings["AuraSkill"] or false,
    Callback = function(state)
        ESPModule:SetBuso(state)
        Settings["AuraSkill"] = state
        print("Aura Skill:", state)
    end
})

-- Toggle 5
local Toggle11 = Tab5:Toggle({
    Title = "・Fps Or Pings",
    Desc = "Display Ping or Fps",
    Default = Settings["FpsOrPings"] or false,
    Callback = function(state)
        StuffsModule:SetPingsOrFps(state)
        Settings["FpsOrPings"] = state
        print("FPS or Pings:", state)
    end
})

-- Input
Tab5:Input({
    Title = "Speed Hack",
    Desc = "Set Walk Speed Value",
    Placeholder = "Enter speed...",
    Default = tostring(getgenv().WalkSpeedValue or 16),
    Callback = function(value)
        local num = tonumber(value)
        if num then
            getgenv().WalkSpeedValue = num
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = num
            end
            print("Speed set to:", num)
        end
    end
})

-- Toggle 6
local Toggle12 = Tab5:Toggle({
    Title = "・Fps Boost",
    Desc = "Increase Fps",
    Default = Settings["FpsBoost"] or false,
    Callback = function(state)
        StuffsModule:SetFpsBoost(state)
        Settings["FpsBoost"] = state
        print("FPS Boost:", state)
    end
})

-- Toggle 7
local Toggle13 = Tab5:Toggle({
    Title = "・INF Energy",
    Desc = "Max Energy",
    Default = Settings["INFEnergy"] or false,
    Callback = function(state)
        StuffsModule:SetINFEnergy(state)
        Settings["INFEnergy"] = state
        print("INF Energy:", state)
    end
})

-- Toggle 8
local Toggle14 = Tab5:Toggle({
    Title = "・Walk on Water",
    Desc = "Travel in Water",
    Default = Settings["WalkonWater"] or false,
    Callback = function(state)
        StuffsModule:SetWalkWater(state)
        Settings["WalkonWater"] = state
        print("Walk on Water:", state)
    end
})

-- Toggle 9
local Toggle15 = Tab5:Toggle({
    Title = "・Fast Attack",
    Desc = "Fast Attack",
    Default = Settings["FastAttack"] or false,
    Callback = function(state)
        StuffsModule:SetFastAttack(state)
        Settings["FastAttack"] = state
        print("Fast Attack:", state)
    end
})

-- Toggle 10
local Toggle16 = Tab5:Toggle({
    Title = "・AntiAfk",
    Desc = "Anti AFK",
    Default = Settings["AntiAFK"] or false,
    Callback = function(state)
        ESPModule:SetAntiAfk(state)
        Settings["AntiAFK"] = state
        print("Anti AFK:", state)
    end
})

-- Input 2
Tab5:Input({
    Title = "Jump Power",
    Desc = "Set Jump Power Value",
    Placeholder = "Enter jump power...",
    Default = tostring(getgenv().JumpValue or 50),
    Callback = function(value)
        getgenv().JumpValue = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = tonumber(value) or 50
        end
        print("Jump Power set to:", value)
    end
})

-- Toggle 11
local Toggle17 = Tab5:Toggle({
    Title = "・Auto V4",
    Desc = "Auto V4 Transform",
    Default = Settings["V4"] or false,
    Callback = function(state)
        UiSettingsModule:SetV4(state)
        Settings["V4"] = state
        print("Auto V4:", state)
    end
})

-- Toggle 12
local Toggle18 = Tab5:Toggle({
    Title = "・Spawned Fruit Check",
    Desc = "Check Fruit Spawned",
    Default = Settings["FruitCheck"] or false,
    Callback = function(state)
        UiSettingsModule:SetFruitCheck(state)
        Settings["FruitCheck"] = state
        print("Fruit Check:", state)
    end
})

-- Toggle 13
local Toggle19 = Tab5:Toggle({
    Title = "・Bring Fruits",
    Desc = "Bring fruits to you",
    Default = Settings["TeleportFruit"] or false,
    Callback = function(state)
        UiSettingsModule:SetTeleportFruit(state)
        Settings["TeleportFruit"] = state
        print("Bring Fruits:", state)
    end
})

-- Toggle 14
local Toggle20 = Tab5:Toggle({
    Title = "・Auto Ken",
    Desc = "Auto Ken",
    Default = Settings["AutoKen"] or false,
    Callback = function(state)
        SilentAimModule:SetAutoKen(state)
        Settings["AutoKen"] = state
        print("Auto Ken:", state)
    end
})

-- Toggle 15
local Toggle21 = Tab5:Toggle({
    Title = "・Remove Lava",
    Desc = "Remove Lava",
    Default = Settings["Lava"] or false,
    Callback = function(state)
        StuffsModule:SetLava(state)
        Settings["Lava"] = state
        print("Remove Lava:", state)
    end
})

-- Toggle 16
local Toggle22 = Tab5:Toggle({
    Title = "・Remove Fog",
    Desc = "Remove Fog",
    Default = Settings["Fog"] or false,
    Callback = function(state)
        StuffsModule:SetFog(state)
        Settings["Fog"] = state
        print("Remove Fog:", state)
    end
})

-- Toggle 17
local Toggle23 = Tab5:Toggle({
    Title = "・Dodge no cd",
    Desc = "Dodge no cooldown",
    Default = Settings["Dodge"] or false,
    Callback = function(state)
        ESPModule:SetNoDodgeCD(state)
        Settings["Dodge"] = state
        print("Dodge no CD:", state)
    end
})

-- Toggle 18
local Toggle24 = Tab5:Toggle({
    Title = "・Target Info",
    Desc = "Show target name/health",
    Default = Settings["Opponent"] or false,
    Callback = function(state)
        ZSkillModule:SetInfo(state)
        Settings["Opponent"] = state
        print("Target Info:", state)
    end
})

-- === TAB 6: SETTINGS MANAGER ===
local Tab6 = Window:Tab({ Title = "⚙・Settings Manager" })

-- Section
local Section6 = Tab6:Section("💾・Settings")

-- Button 1
Tab6:Button({
    Title = "Save Current Settings",
    Desc = "Save all current settings",
    Callback = function()
        OthersStuffsModule.SaveSettings(Settings)
        Window:Notify({
            Title = "Sapi Hub",
            Content = "Settings Saved!"
        })
    end
})

-- Button 2
Tab6:Button({
    Title = "Reset Settings",
    Desc = "Clear saved settings",
    Callback = function()
        OthersStuffsModule.ResetSettings()
        Settings = {}
        Window:Notify({
            Title = "Sapi Hub",
            Content = "Settings Reset!"
        })
    end
})

-- Button 3
Tab6:Button({
    Title = "Rejoin Server",
    Desc = "Rejoin your server",
    Callback = function()
        StuffsModule:SetRejoinServer()
    end
})

-- Dropdown 1
local Dropdown4 = Tab6:Dropdown({
    Title = "・Global Text Font",
    Desc = "Change font for all text",
    Values = {"Garamond", "RobotoMono", "FredokaOne", "Oswald", "Nunito"},
    Default = Settings["GlobalFont"] or "Garamond",
    Callback = function(selected)
        local fontEnum = Enum.Font[selected]
        if fontEnum then
            ESPModule:SetGlobalFont(fontEnum)
            Settings["GlobalFont"] = selected
            print("Global Font:", selected)
        end
    end
})

-- Dropdown 2
local Dropdown5 = Tab6:Dropdown({
    Title = "・RTX Graphics Mode",
    Desc = "Choose lighting mode",
    Values = {"Autumn", "Summer", "Spring", "Winter"},
    Default = Settings["RTXMode"] or "Summer",
    Callback = function(selected)
        ESPModule:SetRTXMode(selected)
        Settings["RTXMode"] = selected
        print("RTX Mode:", selected)
    end
})

-- Phím tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.M then
            Window:Toggle()
        elseif input.KeyCode == Enum.KeyCode.G then
            local newState = not (Settings["SilentAimPlayers"] or false)
            Settings["SilentAimPlayers"] = newState
            SilentAimModule:SetPlayerSilentAim(newState)
            if Toggle4 then
                Toggle4:SetValue(newState)
            end
            Window:Notify({
                Title = "Sapi Hub",
                Content = "Silent Aim: " .. (newState and "ON" or "OFF")
            })
        end
    end
end)

-- Thông báo khởi động
Window:Notify({
    Title = "Sapi Hub",
    Content = "Loaded Successfully! Press M to toggle UI"
})

print("✅ Sapi Hub loaded! Press M to toggle UI")
