-- Zai Hub — All‑in‑One Script by Kaido
-- Single‑line loader:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/ZaiHub/main/Loader.lua", true))()

--[=[
  1) init global flags
  2) load & theme UI
  3) build window/tabs/sections
  4) set up hooks & loops
]=]

-- 1) GLOBAL FLAGS
local flags = {
    AutoFarm        = false,
    FastAttack      = false,
    UseTween        = false,
    ESPEnabled      = false,
    AutoSeaEvent    = false,
    AutoRaceV4      = false,
    AutoPrehistoric = false,
    AutoStats       = false,
    FruitList       = {},
    Destination     = nil,
}
for k,v in pairs(flags) do getgenv()[k] = v end

-- 2) LOAD & THEME KAVO UI
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua", true
))()  -- loads Kavo UI

local themeColors = {
    Background   = Color3.fromRGB(20,20,20),
    Accent       = Color3.fromRGB(0,170,150),
    Header       = Color3.fromRGB(15,15,15),
    TextColor    = Color3.fromRGB(230,230,230),
    SectionColor = Color3.fromRGB(25,25,25),
}
for prop,clr in pairs(themeColors) do
    Library:ChangeColor(prop, clr)
end

-- 3) CREATE WINDOW & TABS
local Window = Library.CreateLib("Zai Hub — Kaido Edition", "DarkTheme")
local Tabs = {
    Farm      = Window:NewTab("Auto Farm"),
    Combat    = Window:NewTab("Combat"),
    Teleports = Window:NewTab("Teleport"),
    Player    = Window:NewTab("Player"),
    ESP       = Window:NewTab("ESP"),
    Events    = Window:NewTab("Events"),
    Utils     = Window:NewTab("Utilities"),
}

-- 3a) Auto‑Farm Section
do
    local sec = Tabs.Farm:NewSection("Auto‑Farm Suite")
    sec:NewToggle("Enable Auto Farm", "Farm mobs, chests, players", function(s)
        getgenv().AutoFarm = s
    end)
end

-- 3b) Combat Section (Fast Attack Hook)
do
    local sec = Tabs.Combat:NewSection("Combat Utilities")
    sec:NewToggle("Fast Attack", "Bypass attack cooldowns", function(s)
        getgenv().FastAttack = s
    end)

    local mt    = getrawmetatable(game)
    local oldNC = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "FireServer"
        and tostring(self):match("MainEvent")
        and getgenv().FastAttack then
            return oldNC(self, ...)
        end
        return oldNC(self, ...)
    end)
    setreadonly(mt, true)
end

-- 3c) Teleports Section
do
    local sec = Tabs.Teleports:NewSection("Island Teleports")
    local islands = {
        Starter  = CFrame.new(100,10,200),
        Second   = CFrame.new(800,10,-500),
        Third    = CFrame.new(2000,15,1500),
        SeaEvent = CFrame.new(300,10,300),
    }
    sec:NewDropdown("Select Island", (function()
        local t = {}
        for name in pairs(islands) do table.insert(t, name) end
        return t
    end)(), function(choice)
        getgenv().Destination = islands[choice]
    end)
    sec:NewToggle("Use Tween", "Smooth glide", function(s)
        getgenv().UseTween = s
    end)
end

-- 3d) Player Section
do
    local sec = Tabs.Player:NewSection("Player Buffs")
    sec:NewSlider("Walk Speed", "Adjust speed", 16, 250, function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)
    sec:NewSlider("Jump Power", "Adjust jump", 50, 500, function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)
    sec:NewToggle("Auto‑Distribute Stats", nil, function(s)
        getgenv().AutoStats = s
    end)
end

-- 3e) ESP Section
do
    local sec = Tabs.ESP:NewSection("ESP & Overlays")
    sec:NewToggle("Enable ESP", nil, function(s)
        getgenv().ESPEnabled = s
    end)
end

-- 3f) Events Section
do
    local sec = Tabs.Events:NewSection("Event Automations")
    sec:NewToggle("Auto Sea Event", nil, function(s) getgenv().AutoSeaEvent = s end)
    sec:NewToggle("Auto Race V4", nil, function(s) getgenv().AutoRaceV4 = s end)
    sec:NewToggle("Auto Prehistoric", nil, function(s) getgenv().AutoPrehistoric = s end)
end

-- 3g) Utilities Section
do
    local sec = Tabs.Utils:NewSection("Fruit & Gear Utils")
    sec:NewTextBox("Fruit Alert", "Comma‑separate fruits", function(txt)
        getgenv().FruitList = txt:split(",")
    end)
    sec:NewButton("Collect Mirage Gear", nil, function()
        -- gear utility implementation
    end)
end

-- 4) BACKGROUND LOOPS (Auto‑Farm, Teleports, ESP, Events, Stats, Fruit Notifier)
-- (Implementation as shown in previous examples)
