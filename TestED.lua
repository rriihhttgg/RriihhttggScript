-- Update 0.0.3
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
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = "Elemental dungeon hub",
    SubTitle = "by rriihhttGG",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Создание вкладки
local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Esp = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Создание сохранений
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("ElementalDungeonHub")
SaveManager:SetFolder("ElementalDungeonHub")

InterfaceManager:BuildInterfaceSection(Tabs.Esp)
SaveManager:BuildConfigSection(Tabs.Esp)

Window:SelectTab(1)


local Options = Fluent.Options

do
    -- Создание секции
    Tabs.Main:AddParagraph({
	Title = "Teleports",
	Content = "Teleports to Npc",
    })

    -- Кнопки
    Tabs.Main:AddButton({
		Title = "Tp to Sus Vampire",
		Description = "Teleporting to Sus Vampire",
		Callback = function()
	    	playerr.CFrame = npcSus.CFrame
		end
    })
    Tabs.Main:AddButton({
		Title = "Tp to Handy Gorilla",
		Description = "Teleport to Handy Gorilla",
		Callback = function()
	    	playerr.CFrame = npcHG.CFrame
		end
    })

    -- Создание секции
    Tabs.Main:AddParagraph({
		Title = "Rolls",
		Content = "Rolling"
    })

    -- Кнопки
    Tabs.Main:AddButton({
		Title = "Summon banner 1 time",
		Description = "Summon banner 1 time for 100 gems",
		Callback = function()
	  	    game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonOnce"):InvokeServer()
		end
    })
    Tabs.Main:AddButton({
		Title = "Summon banner 10 times",
		Description = "Summon banner 10 times for 1000 gems",
		Callback = function()
	    	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService"):WaitForChild("RF"):WaitForChild("SummonThree"):InvokeServer()
		end
    })
    Tabs.Main:AddButton({
		Title = "Time banner roll",
		Description = "Roll time banner 1 time for 1 time shard",
		Callback = function()
	    	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer(unpack(TimeBanner))
		end
    })
    	Tabs.Main:AddButton({
		Title = "Sus Vampire Element",
		Description = "Buying element for gold from Sus Vampire",
		Callback = function()
	    	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(player)
		end
    })

    -- Создание секции
    Tabs.Main:AddParagraph({
		Title = "Craft",
		Content = "Crafting"
    })

    -- Кнопки
    Tabs.Main:AddButton({
		Title = "Craft time shard",
		Description = "Craft 1 time shard for 100 tickmetal fragments",
		Callback = function()
	    	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService"):WaitForChild("RF"):WaitForChild("CraftSpecialMaterial"):InvokeServer(unpack(TimeBanner))
		end
    })

    -- Создание секции
    Tabs.Main:AddParagraph({
		Title = "Dungeons",
		Content = "Dungeons"
    })

    -- Список
    local DungeonDropdown = Tabs.Main:AddDropdown("Dungeons", {
		Title = "Select Dungeon",
		Values = {"Ancient Tomb", "Jungle", "Snow Castle", "Atlantis", "Underworld", "Angel Sanctuary"},
		Multi = false,
		Default = 1,
    })
    
    DungeonDropdown:SetValue("Ancient Tomb")

    DungeonDropdown:OnChanged(function(dungeons)
		print(dungeons)
		dungeon = dungeons
    end)

    local DifficultyDropdown = Tabs.Main:AddDropdown("Difficulties", {
		Title = "Select Difficulty",
		Values = {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"},
		Multi = false,
		Default = 1,
    })

    DifficultyDropdown:SetValue("Easy")

    DifficultyDropdown:OnChanged(function(difficultys)
        print(difficultys)
		difficulty = difficultys
    end)

    -- Кнопка
    Tabs.Main:AddButton({
		Title = "Create Dungeon", 
		Description = "Creating selected dungeon",
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

    Tabs.Main:AddButton({
		Title = "Create Infinite Time Dungeon",
		Description = "Creating Infinite Tower Time Dungeon",
		Callback = function()
	    	game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty"):InvokeServer(unpack(args))
		end
    })
end
