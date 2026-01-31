-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer -- для LocalScript
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")
local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")

local npcHG = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local difficulty = nil
local dungeon = nil

local Tabs = {}
local Esp = {}

-- Массивы
local TimeBanner = {
	"TimeBanner2025"
}

local args = {
	"InfiniteTimeDungeon",
	"Hardcore",
	"All",
	"MiscChallenges"
}

-- Загрузка библиотеки
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"))()

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = "Elemental Dungeon Script",
    SubTitle = "by rriihhttGG",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Создание вкладки
Tabs.Hub = Window:AddTab({ Title = "Hub", Icon = "" })

-- Создание секции
Tabs.Hub:AddSection("Teleports")

-- Кнопки
Tabs.Hub:AddButton({
    Title = "Teleport to Sus Vampire",
    Callback = function()
        playerr.CFrame = npcSus.CFrame
    end
})

Tabs.Hub:AddButton({
    Title = "Teleport to Handy Gorilla",
    Callback = function()
playerr.CFrame = npcHG.CFrame
    end
})

-- Создание секции
Tabs.Hub:AddSection("Rolls")

-- Кнопки
Tabs.Hub:AddButton({
    Title = "Summon banner 1 time",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonOnce"):InvokeServer()
    end
})
Tabs.Hub:AddButton({
    Title = "Summon banner 10 times",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonThree"):InvokeServer()
    end
})
Tabs.Hub:AddButton({
    Title = "Time Banner roll",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer(unpack(TimeBanner))
    end
})
Tabs.Hub:AddButton({
    Title = "Buy element orb from Sus Vampire",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(player)
    end
})

-- Создание секции
Tabs.Hub:AddSection("Craft")

-- Кнопка
Tabs.Hub:AddButton({
    Title = "Craft Time Shard",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("CraftSpecialMaterial"):InvokeServer(unpack(TimeBanner))
    end
})

-- Создание секции
Tabs.Hub:AddSection("Dungeons")

-- Список
Tabs.Hub:AddDropdown("Dungeons", {
    Title = "Select Dungeon",
    Values = {"Ancient Tomb", "Jungle", "Snow Castle", "Atlantis", "Underworld", "Angel Sanctuary"},
    Default = "Ancient Tomb",
    Callback = function(dungeons)
        print("Selected:", dungeons)
	dungeon = dungeons
    end
})

Tabs.Hub:AddDropdown("Difficulties", {
    Title = "Select Difficulty",
    Values = {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"},
    Default = "Easy",
    Callback = function(difficultys)
        print("Выбрано:", difficultys)
	difficulty = difficultys
    end
})

-- Кнопка
Tabs.Hub:AddButton({
    Title = "Create Dungeon",
    Callback = function()
    local Anc = {
     	    "BeginnersDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }

    local Jun = {
    	    "JungleDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }

    local Snow = {
	    "ArcticBastionDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }

    local Atl = {
	    "UnderwaterDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }

    local Und = {
	    "FireDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }

    local Ang = {
	    "CloudDungeon",
	    difficulty,
	    "All",
	    "Normal"
    }
	if dungeon == "Ancient Tomb" and difficulty ~= nil then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Anc))
        elseif (dungeon == "Jungle" and difficulty ~= "Easy") and difficulty ~= nil then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Jun))
        elseif dungeon == "Snow Castle" and difficulty ~= nil then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Snow))
        elseif dungeon == "Atlantis" then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Atl))
        elseif dungeon == "Underworld" and difficulty ~= nil then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Und))
        elseif dungeon == "Angel Sanctuary" and difficulty ~= nil then
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(Ang))
        end
end
})

-- Кнопка
Tabs.Hub:AddButton({
    Title = "Create Infinite Time Tower Dungeon",
    Callback = function()
	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(args))
    end
})


-- Создание вкладки
Tabs.Esp = Window:AddTab({ Title = "Esp", Icon = "" })


-- Создание секции
Tabs.Esp:AddSection("Hub Esp")
