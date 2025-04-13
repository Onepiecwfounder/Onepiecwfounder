
-- Yh Hub V2 Script
print("Yh Hub Loaded!")

-- Auto Farm
spawn(function()
    while true do
        pcall(function()
            local enemy = game.Workspace.Enemies:FindFirstChildOfClass("Model")
            if enemy then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
            end
        end)
        task.wait(0.1)
    end
end)

-- Auto Raid
spawn(function()
    while true do
        if game:GetService("ReplicatedStorage").Remotes.StartRaid then
            game:GetService("ReplicatedStorage").Remotes.StartRaid:FireServer("Flame")
        end
        wait(300)
    end
end)

-- Fruit Notifier
spawn(function()
    while true do
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Yh Hub";
                    Text = "Fruit Found: "..v.Name;
                    Duration = 10;
                })
            end
        end
        wait(2)
    end
end)

-- Redeem All Codes
local codes = {"SUB2GAMERROBOT_RESET1","kittgaming","Sub2NoobMaster123"}
for i,v in pairs(codes) do
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
    end)
end)

-- Auto Next Sea
spawn(function()
    while wait(3) do
        pcall(function()
            local placeId = game.PlaceId
            if placeId == 2753915549 then -- First Sea
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5550, 330, -695)
            elseif placeId == 4442272183 then -- Second Sea
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2285, 15, 905)
            end
        end)
    end
end)

-- ESP (Players + Fruits)
spawn(function()
    while wait(1) do
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Character and not v.Character:FindFirstChild("ESP") then
                local billboard = Instance.new("BillboardGui", v.Character)
                billboard.Name = "ESP"
                billboard.Size = UDim2.new(0,100,0,50)
                billboard.Adornee = v.Character.Head
                local text = Instance.new("TextLabel", billboard)
                text.Size = UDim2.new(1,0,1,0)
                text.Text = v.Name
                text.TextColor3 = Color3.new(1,0,0)
                text.BackgroundTransparency = 1
            end
        end
        for _,obj in pairs(game.Workspace:GetChildren()) do
            if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and not obj:FindFirstChild("ESP") then
                local billboard = Instance.new("BillboardGui", obj)
                billboard.Name = "ESP"
                billboard.Size = UDim2.new(0,100,0,50)
                billboard.Adornee = obj.Handle
                local text = Instance.new("TextLabel", billboard)
                text.Size = UDim2.new(1,0,1,0)
                text.Text = obj.Name
                text.TextColor3 = Color3.new(0,1,0)
                text.BackgroundTransparency = 1
            end
        end
    end
end)

-- Boss Auto Farm
spawn(function()
    while wait(2) do
        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
            if string.find(v.Name, "Boss") and v:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
            end
        end
    end
end)

-- Auto Material Farm
spawn(function()
    while wait(1) do
        for i,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Tool") and string.find(v.Name, "Material") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
            end
        end
    end
end)

-- Server Hop if no fruit
spawn(function()
    while wait(60) do
        local found = false
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                found = true
            end
        end
        if not found then
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end
end)
