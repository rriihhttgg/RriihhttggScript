-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")

local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")
local npcHG  = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local difficulty = nil
local dungeon = nil

-- Массивы
local TimeBanner = { "TimeBanner2025" }

local args = {
	"InfiniteTimeDungeon",
	"Hardcore",
	"All",
	"MiscChallenges"
}

-- Fluent
local Fluent = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"
))()

local Window = Fluent:CreateWindow({
    Title = "Rriihhttgg ED hub",
    SubTitle = "Fluent version",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 500),
    Acrylic = false, -- для Delta X
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Hub = Window:AddTab({ Title = "Hub", Icon = "home" }),
    Esp = Window:AddTab({ Title = "ESP", Icon = "eye" })
}

----------------------------------------------------------------
-- HUB
----------------------------------------------------------------

Tabs.Hub:AddSection("Teleports")

Tabs.Hub:AddButton({
    Title = "Tp to Sus Vampire",
    Callback = function()
        playerr.CFrame = npcSus.CFrame
    end
})

Tabs.Hub:AddButton({
    Title = "Tp to Handy Gorilla",
    Callback = function()
        playerr.CFrame = npcHG.CFrame
    end
})

----------------------------------------------------------------

Tabs.Hub:AddSection("Rolls")

Tabs.Hub:AddButton({
    Title = "Summon banner 1 time",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .SummoningService.RF.SummonOnce:InvokeServer()
    end
})

Tabs.Hub:AddButton({
    Title = "Summon banner 10 times",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .SummoningService.RF.SummonThree:InvokeServer()
    end
})

Tabs.Hub:AddButton({
    Title = "Time banner roll",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .GachaService.RF.Spin:InvokeServer(unpack(TimeBanner))
    end
})

Tabs.Hub:AddButton({
    Title = "Sus Vampire Element",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .MiscContentService.RF.BuyElementForGold:InvokeServer(player)
    end
})

----------------------------------------------------------------

Tabs.Hub:AddSection("Craft")

Tabs.Hub:AddButton({
    Title = "Craft time shard",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .GachaService.RF.CraftSpecialMaterial:InvokeServer(unpack(TimeBanner))
    end
})

----------------------------------------------------------------

Tabs.Hub:AddSection("Dungeons")

Tabs.Hub:AddDropdown("DungeonSelect", {
    Title = "Select Dungeon",
    Values = {
        "Ancient Tomb", "Jungle", "Snow Castle",
        "Atlantis", "Underworld", "Angel Sanctuary"
    },
    Default = "Ancient Tomb",
    Callback = function(v)
        dungeon = v
    end
})

Tabs.Hub:AddDropdown("DifficultySelect", {
    Title = "Select Difficulty",
    Values = { "Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite" },
    Default = "Easy",
    Callback = function(v)
        difficulty = v
    end
})

Tabs.Hub:AddButton({
    Title = "Create Dungeon",
    Callback = function()
        local mapIds = {
            ["Ancient Tomb"] = "BeginnersDungeon",
            ["Jungle"] = "JungleDungeon",
            ["Snow Castle"] = "ArcticBastionDungeon",
            ["Atlantis"] = "UnderwaterDungeon",
            ["Underworld"] = "FireDungeon",
            ["Angel Sanctuary"] = "CloudDungeon"
        }

        if dungeon and difficulty then
            game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
            .PartyService.RF.CreateParty:InvokeServer(
                mapIds[dungeon], difficulty, "All", "Normal"
            )
        end
    end
})

Tabs.Hub:AddButton({
    Title = "Create Infinite Time Dungeon",
    Callback = function()
        game.ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services
        .PartyService.RF.CreateParty:InvokeServer(unpack(args))
    end
})

----------------------------------------------------------------
-- ESP
----------------------------------------------------------------

Tabs.Esp:AddSection("Hub ESP")

local EspEnabled = false

Tabs.Esp:AddToggle("OrbESP", {
    Title = "ESP Element Orbs",
    Default = false,
    Callback = function(state)
        EspEnabled = state

        if state then
            task.spawn(function()
                while EspEnabled do
                    task.wait(1)
                    for _, orb in pairs(workspace:GetDescendants()) do
                        if orb:FindFirstChild("OrbHandler") and not orb:FindFirstChild("EspBox") then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name = "EspBox"
                            box.Adornee = orb
                            box.Size = Vector3.new(4,5,1)
                            box.Transparency = 0.6
                            box.Color3 = Color3.fromRGB(255,48,48)
                            box.AlwaysOnTop = true
                            box.ZIndex = 0
                            box.Parent = orb
                        end
                    end
                end
            end)
        end
    end
})
