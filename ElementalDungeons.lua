-- Переменные
local RS = game:GetService("ReplicatedStorage")
local CreateParty = RS.Packages.Knit.Services.PartyService.RF.CreateParty

local dungeon = nil
local difficulty = nil

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

local dungeonIds = {
	["Ancient Tomb"] = "BeginnersDungeon",
	["Jungle"] = "JungleDungeon",
	["Snow Castle"] = "ArcticBastionDungeon",
	["Atlantis"] = "UnderwaterDungeon",
	["Underworld"] = "FireDungeon",
	["Angel Sanctuary"] = "CloudDungeon"
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
MainSection:NewDropdown("Dungeons", "Select Dungeon", {"Ancient Tomb", "Jungle", "Snow Castle", "Atlantis", "Underworld", "Angel Sanctuary"}, function(value)
	dungeon = value
end)

MainSection:NewDropdown("Difficulties", "Select Difficulty", {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"}, function(valuer)
	difficulty = valuer
end)

MainSection:NewButton("Create Dungeon", "Creating selected dungeon", function()
	if not dungeon or not difficulty then
		warn("Dungeon or difficulty not selected")
		return
	end

	if dungeon == "Jungle" and difficulty == "Easy" then
		warn("Jungle нельзя на Easy")
		return
	end

	CreateParty:InvokeServer(
		dungeonIds[dungeon],
		difficulty,
		"All",
		"Normal"
	)
end)
