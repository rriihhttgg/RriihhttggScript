-- Update 0.0.6
-- Storm Titan + Celestial Conqueror System
-- Alpha Version
-- Надежный AutoAttack + TP + Storm Titan Transformation

--------------------------------------------------
-- LOAD UI
--------------------------------------------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "⚡ Elemental dungeon hub ⚡",
    SubTitle = "Alpha v0.2.6",
    TabWidth = 180,
    Size = UDim2.fromOffset(580, 560),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"})
}

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("ElementalDungeonHub")
SaveManager:SetFolder("ElementalDungeonHub")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

--------------------------------------------------
-- SERVICES
--------------------------------------------------

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local mobsFolder = workspace:WaitForChild("Mobs")

local Character = player.Character or player.CharacterAdded:Wait()
player.CharacterAdded:Connect(function(char)
    Character = char
end)

--------------------------------------------------
-- MAP / POSITIONS
--------------------------------------------------

local Map = workspace:WaitForChild("Map")

local pos1 = Instance.new("Part")
pos1.Size = Vector3.new(1,1,1)
pos1.Position = Vector3.new(-4437.43, 408.652, -877.571)
pos1.Anchored = true
pos1.Name = "pos1"
pos1.Parent = Map

local pos2 = Instance.new("Part")
pos2.Size = Vector3.new(1,1,1)
pos2.Position = Vector3.new(-4505.16, 428.136, 754.889)
pos2.Anchored = true
pos2.Name = "pos2"
pos2.Parent = Map

--------------------------------------------------
-- FLAGS
--------------------------------------------------

local AutoAttack = false
local ConqKilled = false
local CurrentTP = "pos1" -- Отслеживает текущую целевую позицию
local StormTitanTransformed = false -- Однократная трансформация

--------------------------------------------------
-- FUNCTIONS
--------------------------------------------------

-- Safe teleport
local function SafeTeleport(targetPos)
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        if (hrp.Position - targetPos.Position).Magnitude > 2 then
            hrp.CFrame = targetPos.CFrame
        end
    end
end

-- Get nearest mob
local function getNearestMob()
    local root = Character and Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local nearestMob = nil
    local shortestDistance = math.huge

    for _, mob in pairs(mobsFolder:GetChildren()) do
        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
        local humanoid = mob:FindFirstChild("Humanoid")

        if mobRoot and humanoid and humanoid.Health > 0 then
            local distance = (mobRoot.Position - root.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestMob = mob
            end
        end
    end

    return nearestMob
end

-- Attack mob
local function AttackMob(mob)
    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
    if not mobRoot then return end

    local pos = mobRoot.Position

    local args1 = {
        ReplicatedStorage.ReplicatedStorage.Abilities.Elements.Mech.M1,
        {Direction = Vector3.new(0,0,0), Origin = pos, Position = pos},
        "Start"
    }
    ReplicatedStorage.ReplicatedStorage.Abilities.Templates.ToolTemplate.RemoteEvent:FireServer(unpack(args1))

    task.wait(0.05) -- скорость атаки

    local args2 = {
        ReplicatedStorage.ReplicatedStorage.Abilities.Elements.Mech.M1,
        {Direction = Vector3.new(0,0,0), Origin = pos, Position = pos},
        "End"
    }
    ReplicatedStorage.ReplicatedStorage.Abilities.Templates.ToolTemplate.RemoteEvent:FireServer(unpack(args2))
end

-- Storm Titan Transformation (однократно)
local function CheckStormTitanTransformation()
    local titan = mobsFolder:FindFirstChild("[Lv. 220] Storm Titan")
    if not titan then return end

    local humanoid = titan:FindFirstChild("Humanoid")
    if not humanoid then return end

    if not StormTitanTransformed and humanoid.MaxHealth > 250000 then
        StormTitanTransformed = true

        -- Transformation Start
        local startArgs = {
            ReplicatedStorage:WaitForChild("ReplicatedStorage"):WaitForChild("Abilities"):WaitForChild("Elements"):WaitForChild("Mech"):WaitForChild("Transformation"),
            {
                Direction = Vector3.new(-0.4728613793849945, -0.25441843271255493, -0.8436074256896973),
                Origin = Vector3.new(-4480.640625, 440.3681945800781, 776.1621704101562),
                Position = Vector3.new(-4541.6201171875, 407.55877685546875, 667.371826171875)
            },
            "Start"
        }
        ReplicatedStorage:WaitForChild("ReplicatedStorage"):WaitForChild("Abilities"):WaitForChild("Templates"):WaitForChild("ToolTemplate"):WaitForChild("RemoteEvent"):FireServer(unpack(startArgs))

        -- Transformation End
        local endArgs = {
            ReplicatedStorage:WaitForChild("ReplicatedStorage"):WaitForChild("Abilities"):WaitForChild("Elements"):WaitForChild("Mech"):WaitForChild("Transformation"),
            {
                Direction = Vector3.new(-0.6456324458122253, -0.2522144615650177, -0.7207959294319153),
                Origin = Vector3.new(-4481.083984375, 439.70550537109375, 774.5275268554688),
                Position = Vector3.new(-4582.77587890625, 399.9798583984375, 660.996826171875)
            },
            "End"
        }
        ReplicatedStorage:WaitForChild("ReplicatedStorage"):WaitForChild("Abilities"):WaitForChild("Templates"):WaitForChild("ToolTemplate"):WaitForChild("RemoteEvent"):FireServer(unpack(endArgs))
    end
end

--------------------------------------------------
-- AUTOATTACK + SAFE TP LOOP
--------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoAttack then
            pcall(function()
                -- Проверка боссов
                local titan = mobsFolder:FindFirstChild("[Lv. 220] Storm Titan")
                local conqueror = mobsFolder:FindFirstChild("[Lv. 220] Celestial Conqueror")
                local bossActive = (titan and titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0) 
                                   or (conqueror and conqueror:FindFirstChild("Humanoid") and conqueror.Humanoid.Health > 0)

                -- TP на pos2, если есть босс, иначе pos1
                if bossActive then
                    CurrentTP = "pos2"
                    SafeTeleport(pos2)
                else
                    CurrentTP = "pos1"
                    SafeTeleport(pos1)
                end

                -- Атака ближайшего моба
                local mob = getNearestMob()
                if mob then
                    AttackMob(mob)
                end

                -- Storm Titan трансформация
                CheckStormTitanTransformation()

                -- Celestial Conqueror Retry
                if conqueror and conqueror:FindFirstChild("Humanoid") then
                    if conqueror.Humanoid.Health <= 0 and not ConqKilled then
                        ConqKilled = true
                        task.spawn(function()
                            while ConqKilled do
                                pcall(function()
                                    ReplicatedStorage:WaitForChild("ReplicatedStorage")
                                        :WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
                                        :WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("VoteOn")
                                        :InvokeServer("Retry")
                                end)
                                task.wait(1)
                            end
                        end)
                    end
                end
            end)
        end
    end
end)

--------------------------------------------------
-- TOGGLE
--------------------------------------------------

Tabs.Main:AddToggle("AutoAttack", {
    Title = "Auto Attack Mobs",
    Default = false,
    Callback = function(state)
        AutoAttack = state

        if state then
            -- Запускаем данж
            pcall(function()
                ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.StartDungeon:InvokeServer()
            end)
        end
    end
})

--------------------------------------------------
-- BUTTONS
--------------------------------------------------

Tabs.Main:AddButton({
    Title = "Tp 1 pos",
    Callback = function()
        SafeTeleport(pos1)
    end
})

Tabs.Main:AddButton({
    Title = "Tp 2 pos",
    Callback = function()
        SafeTeleport(pos2)
    end
})
