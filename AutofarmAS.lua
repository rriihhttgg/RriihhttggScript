-- Update 0.0.1
-- Created Yay
-- Alpha Version

-- Загрузка библиотеки
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = "⚡ Elemental dungeon hub ⚡",
    SubTitle = "Alpha v0.1.6",
    TabWidth = 180,
    Size = UDim2.fromOffset(580, 560),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Вкладки
local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"})
}

-- Сохранения
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
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

local AutoAttack = false

local pos1 = Instance.new("Part")
        pos1.Size = Vector3.new(1, 1, 1)
        pos1.Position = Vector3.new(-4165.52, 377.045, -486.045)
        pos1.Anchored = true
        pos1.BrickColor = BrickColor.new("Bright red")
        pos1.Name = "Bridge1"
        pos1.Parent = Map

local pos2 = Instance.new("Part")
        pos2.Size = Vector3.new(1, 1, 1)
        pos2.Position = Vector3.new(-4505.16, 428.136, 754.889)
        pos2.Anchored = true
        pos2.BrickColor = BrickColor.new("Bright red")
        pos2.Name = "Bridge1"
        pos2.Parent = Map

--------------------------------------------------
-- FIND NEAREST MOB
--------------------------------------------------

local function getNearestMob()

    local character = player.Character
    if not character then return nil end

    local root = character:FindFirstChild("HumanoidRootPart")
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

--------------------------------------------------
-- ATTACK FUNCTION
--------------------------------------------------

local function AttackMob(mob)

    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
    if not mobRoot then return end

    local pos = mobRoot.Position

    -- M1
    local arg3 = {
        ReplicatedStorage.ReplicatedStorage.Abilities.Elements.Mech.M1,
        {
            Direction = Vector3.new(0,0,0),
            Origin = pos,
            Position = pos
        },
        "Start"
    }

    ReplicatedStorage.ReplicatedStorage.Abilities.Templates.ToolTemplate.RemoteEvent:FireServer(unpack(arg3))

    task.wait(0.05)

    local arg4 = {
        ReplicatedStorage.ReplicatedStorage.Abilities.Elements.Mech.M1,
        {
            Direction = Vector3.new(0,0,0),
            Origin = pos,
            Position = pos
        },
        "End"
    }

    ReplicatedStorage.ReplicatedStorage.Abilities.Templates.ToolTemplate.RemoteEvent:FireServer(unpack(arg4))

end

--------------------------------------------------
-- TOGGLE AUTO ATTACK
--------------------------------------------------

Tabs.Main:AddToggle("AutoAttack", {
    Title = "Auto Attack Mobs",
    Default = false,
    Callback = function(Value)
        AutoAttack = Value
    end
})

--------------------------------------------------
-- AUTO ATTACK LOOP
--------------------------------------------------

task.spawn(function()

    while true do
        task.wait(0.3)

        if AutoAttack then

            local mob = getNearestMob()

            if mob then
                AttackMob(mob)
            end

        end

    end

end)

--------------------------------------------------
-- BRIDGE BUTTON
--------------------------------------------------
Tabs.Main:AddButton({
    Title = "Tp 1 pos",
    Description = "Teleport to 1 pos",
    Callback = function()
        player.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.pos1.CFrame
    end
})
Tabs.Main:AddButton({
    Title = "Tp 2 pos",
    Description = "Teleport to 2 pos",
    Callback = function()
        player.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.pos2.CFrame
    end
})
Tabs.Main:AddButton({
    Title = "Bridge",
    Description = "Create bridge",
    Callback = function()

        local Map = workspace:WaitForChild("Map")

        local Bridge1 = Instance.new("Part")
        Bridge1.Size = Vector3.new(90,1,100)
        Bridge1.Position = Vector3.new(-3758.91,29.251,-803.428)
        Bridge1.Anchored = true
        Bridge1.BrickColor = BrickColor.new("Bright red")
        Bridge1.Name = "Bridge1"
        Bridge1.Parent = Map

        local Bridge2 = Instance.new("Part")
        Bridge2.Size = Vector3.new(90,1,80)
        Bridge2.Position = Vector3.new(-3955.5,22.5632,-600.395)
        Bridge2.Orientation = Vector3.new(10,0,0)
        Bridge2.Anchored = true
        Bridge2.BrickColor = BrickColor.new("Bright red")
        Bridge2.Name = "Bridge2"
        Bridge2.Parent = Map

        local Bridge3 = Instance.new("Part")
        Bridge3.Size = Vector3.new(90,1,90)
        Bridge3.Position = Vector3.new(-3978.5,18.6021,-1062.31)
        Bridge3.Orientation = Vector3.new(-10,0,0)
        Bridge3.Anchored = true
        Bridge3.BrickColor = BrickColor.new("Bright red")
        Bridge3.Name = "Bridge3"
        Bridge3.Parent = Map

        local Bridge4 = Instance.new("Part")
        Bridge4.Size = Vector3.new(90,1,100)
        Bridge4.Position = Vector3.new(-4184.13,29.734,-823.382)
        Bridge4.Anchored = true
        Bridge4.BrickColor = BrickColor.new("Bright red")
        Bridge4.Name = "Bridge4"
        Bridge4.Parent = Map

    end
})
