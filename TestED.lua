-- Update 0.0.7
-- Alpha Version
-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer -- для LocalScript
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")
local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")

local npcHG = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local difficulty = nil
local dungeon = nil
local Key = nil

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
    SubTitle = "Version 0.0.1",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Создание вкладки
local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Esp = Window:AddTab({ Title = "Esp", Icon = "eye"}),
	Craft = Window:AddTab({ Title = "Craft", Icon = "anvil"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Создание сохранений
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("ElementalDungeonHub")
SaveManager:SetFolder("ElementalDungeonHub")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

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

    -- Создание секции
    Tabs.Esp:AddParagraph({
	Title = "Esp",
	Content = "Show items on map",
    })

    -- Тумблер
    local ElementEsp = Tabs.Esp:AddToggle("Esp Element orb",
    {
	Title = "Esp elements",
	Description = "Show element orbs on map",
	Default = false,
	Callback = function(elementorb)
	if elementorb then
	    EspElement = true
	else
	    EspElement = false
	    end
	end
    })
    
    ElementEsp:OnChanged(function()
		while wait(10) do
			if EspElement == true then
				for dildi in range(10) do
    				for i, childrik in ipairs(workspace:GetDescendants()) do
        				if childrik:FindFirstChild("OrbHandler") then
            				if not childrik:FindFirstChild("EspBox") then
                				if childrik ~= game.Players.LocalPlayer.Character then
                    				local esp = Instance.new("BoxHandleAdornment",childrik)
                    				esp.Adornee = childrik
                    				esp.ZIndex = 0
                    				esp.Size = Vector3.new(4, 5, 1)
                   	    			esp.Transparency = 0.65
                   	    			esp.Color3 = Color3.fromRGB(255,48,48)
                    				esp.AlwaysOnTop = true
                    				esp.Name = "EspBox"
                				end
            				end
        				end
    				end
				end
			end
		end
    end)

    ElementEsp:SetValue(false)
end

	-- Создание секции
    Tabs.Craft:AddParagraph({
	Title = "Esp",
	Content = "Show items on map",
    })

	-- Список
    local KeyDropdown = Tabs.Craft:AddDropdown("Craft Keys", {
		Title = "Select Key",
		Values = {"Angel Key", "Dragon Key", "Zeus Key", "Reaper Key", "Skeleton Key", "Kronax Key", "Heroic Kronax Key"},
		Multi = false,
		Default = 1,
    })
    
    KeyDropdown:SetValue("Angel Key")

    KeyDropdown:OnChanged(function(Keys)
		print(Keys)
		Key = Keys
    end)

	-- Кнопка
    Tabs.Craft:AddButton({
		Title = "Craft Selected Dungeon", 
		Description = "Crafting Selected Key",
		Callback = function()
	    	if Key == "Angel Key" then
				print("Angel")
	    	elseif Key == "Zeus Key" then
				game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CraftingService"):WaitForChild("RF"):WaitForChild("Craft"):InvokeServer(19)
    		elseif Key == "Dragon Key" then
				game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CraftingService"):WaitForChild("RF"):WaitForChild("Craft"):InvokeServer(20)
        	elseif Key == "Reaper Key" then
        		game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CraftingService"):WaitForChild("RF"):WaitForChild("Craft"):InvokeServer(17)
    		elseif Key == "Skeleton Key" then
				game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CraftingService"):WaitForChild("RF"):WaitForChild("Craft"):InvokeServer(21)
			elseif Key == "Kronax Key" then
				print("Kronax")
			elseif Key == "Heroic Kronax Key" then
				print("Heroic Kronax")
    		end
		end
    })
