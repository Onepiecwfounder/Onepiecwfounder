-- Zai Hub: All-In-One Script (Like Andepzai Hub)
-- Made by Kaido

-- Initialize global settings
getgenv().AutoFarm = false
getgenv().FastAttack = false
getgenv().ESP = false

-- Load Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Zai Hub — Kaido Edition", "DarkTheme")

-- Tabs
local FarmTab = Window:NewTab("Auto Farm")
local CombatTab = Window:NewTab("Combat")
local ESPTab = Window:NewTab("ESP")
local PlayerTab = Window:NewTab("Player")

-- Auto Farm
local FarmSection = FarmTab:NewSection("Main")
FarmSection:NewToggle("Enable Auto Farm", "Automatically farm enemies", function(state)
    getgenv().AutoFarm = state
end)

-- Fast Attack
local CombatSection = CombatTab:NewSection("Combat")
CombatSection:NewToggle("Enable Fast Attack", "Removes attack cooldown", function(state)
    getgenv().FastAttack = state
end)

-- ESP
local ESPSection = ESPTab:NewSection("ESP")
ESPSection:NewToggle("Enable ESP", "Shows enemies/players", function(state)
    getgenv().ESP = state
end)

-- Walk Speed/Jump
local PlayerSection = PlayerTab:NewSection("Movement")
PlayerSection:NewSlider("Walk Speed", "Adjust speed", 16, 200, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)
PlayerSection:NewSlider("Jump Power", "Adjust jump height", 50, 250, function(val)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
end)
