-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer -- для LocalScript
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")
local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")

local npcHG = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local difficulty = nil
local dungeon = nil

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
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Создание окна
local Window = Library.CreateLib("Rriihhttgg ED hub", "DarkTheme")

-- Создание вкладки
local MainTab = Window:NewTab("Hub")

-- Создание секции
local MainSection = MainTab:NewSection("Teleports")

-- Кнопки
MainSection:NewButton("Tp to Sus Vampire", "Teleport to Sus vampire", function()
playerr.CFrame = npcSus.CFrame
end)
MainSection:NewButton("Tp to Handy Gorilla", "Teleport to Handy Gorilla", function()
playerr.CFrame = npcHG.CFrame
end)

-- Создание секции
local MainSection = MainTab:NewSection("Rolls")

-- Кнопки
MainSection:NewButton("Summon banner 1 time", "Summon banner 1 time for 100 gems", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonOnce"):InvokeServer()
end)
MainSection:NewButton("Summon banner 10 times", "Summon banner 10 times for 1000 gems", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonThree"):InvokeServer()
end)
MainSection:NewButton("Time banner roll", "Roll time banner 1 time for 1 time shard", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer(unpack(TimeBanner))
end)
MainSection:NewButton("Sus Vampire Element", "Buying element for gold from Sus Vampire", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(player)
end)

-- Создание секции
local MainSection = MainTab:NewSection("Craft")

-- Кнопки
MainSection:NewButton("Craft time shard", "Craft 1 time shard for 100 tickmetal fragments", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("CraftSpecialMaterial"):InvokeServer(unpack(TimeBanner))
end)

-- Создание секции
local MainSection = MainTab:NewSection("Dungeons")

-- Список
MainSection:NewDropdown("Dungeons", "Select Dungeon", {"Ancient Tomb", "Jungle", "Snow Castle", "Atlantis", "Underworld", "Angel Sanctuary"}, function(dungeons)
    print(dungeon)
dungeon = dungeons
end)

MainSection:NewDropdown("Difficulties", "Select Difficulty", {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"}, function(difficultys)
    print(difficulty)
difficulty = difficultys
end)

-- Кнопка
MainSection:NewButton("Create Dungeon", "Creating selected dungeon", function()
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
end)

MainSection:NewButton("Create Infinite Time Dungeon", "Creating Infinite Tower Time Dungeon", function()
game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(args))
end)


-- Создание вкладки
local MainTab = Window:NewTab("Esp")

-- Создание секции
local MainSection = MainTab:NewSection("Hub esp")


-- Тумблер
MainSection:NewToggle("ESP element orbs", "Turn on/ Turn off", function(state)
    if state then
        while wait(1) do
	    for i, ElementOrb in pairs(workspace:GetDescnedants()) do
		if ElementOrb:FindFirstChild("OrbHandler") then
		    if not ElementOrb:FindFirstChild("EspBox") then
			local EspElement = Instance.new("BoxHandlerAdorment", ELementOrb)
			EspElement.Adornee = ElementOrb
			EspElement.ZIndex = 0
			EspElement.Size = Vector.new(4, 5, 1)
			EspElement.Transparency = 0.6
			EspElement.Color = Color3.fromRGB(255, 48, 48)
			EspElement.AlwaysOnTop = true
			EspElement.Name = "EspBox"
		    end
		end
	    end
        end
    end
end)
