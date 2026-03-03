-- Update 0.1.2
-- Added Sword Rolls btw doesnt work roll
-- Alpha Version

-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")
local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")
local npcHG = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local StatusPanel
local Roll
local StatusPanelRoll
local difficulty, dungeon, Key
local Cor = false

local function findClosestIndex(base, list)
    local closestIndex = 1
    local smallestDiff = math.abs(base - list[1])

    for i = 2, #list do
        local diff = math.abs(base - list[i])
        if diff < smallestDiff then
            smallestDiff = diff
            closestIndex = i
        end
    end

    return closestIndex
end

-- Массивы
local TimeBanner = {"TimeBanner2025"}
local args = {"InfiniteTimeDungeon", "Hardcore", "All", "MiscChallenges"}
local AscDaggersRolls = {5126.44, 5175.30, 5224.16, 5273.01, 5321.87, 5370.73}
local AscSwordRolls = {8434.12, 8514.45, 8594.77, 8675.10, 8755.42, 8835.75}
local ConqBladeRolls = {8032.50, 8112.82, 8193.15, 8273.48, 8353.80, 8434.12, 8514.45, 8594.77, 8675.10, 8755.42, 8835.75}
local DoombringerRolls = {6300, 6363, 6426, 6489, 6552, 6615, 6678, 6741, 6804, 6867, 6930}
local TLConqRolls = {6825, 6893.25, 6961.50, 7029.75, 7098.05, 7166.25, 7234.50, 7302.75, 7371, 7439.25, 7507.50}


-- Загрузка библиотеки
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = "Elemental dungeon hub",
    SubTitle = "Version 0.1.1",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Создание вкладок
local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Craft = Window:AddTab({ Title = "Craft", Icon = "hammer"}),
    Roll = Window:AddTab({ Title = "Roll List", Icon = "list"}),
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

-- Функция обновления статуса
local function UpdateStatus()
    if not StatusPanel then return end

    local diffColor = "⚪"
    if difficulty == "Easy" then diffColor = "🟢"
    elseif difficulty == "Medium" then diffColor = "🟡"
    elseif difficulty == "Hard" then diffColor = "🟠"
    elseif difficulty == "Hell" then diffColor = "🔴"
    elseif difficulty == "Hardcore" then diffColor = "💀"
    elseif difficulty == "Infinite" then diffColor = "♾️" end

    StatusPanel:SetDesc(
        "Dungeon: " .. tostring(dungeon or "None") ..
        "\nDifficulty: " .. diffColor .. " " .. tostring(difficulty or "None") ..
        "\nSelected Key: " .. tostring(Key or "None")
    )
end

-- Основной блок интерфейса
do
    -- Статус панель
    StatusPanel = Tabs.Main:AddParagraph({
        Title = "📊 Live Status",
        Content = "Dungeon: None\nDifficulty: None\nStatus: Idle"
    })

    -- Teleports
    Tabs.Main:AddParagraph({Title = "Teleports", Content = "Teleports to Npc"})
    Tabs.Main:AddButton({
        Title = "Tp to Sus Vampire",
        Description = "Teleporting to Sus Vampire",
        Callback = function() playerr.CFrame = npcSus.CFrame end
    })
    Tabs.Main:AddButton({
        Title = "Tp to Handy Gorilla",
        Description = "Teleport to Handy Gorilla",
        Callback = function() playerr.CFrame = npcHG.CFrame end
    })

    -- Rolls
    Tabs.Main:AddParagraph({Title = "Rolls", Content = "Rolling"})
    Tabs.Main:AddButton({
        Title = "Summon banner 1 time",
        Description = "Summon banner 1 time for 100 gems",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService")
                :WaitForChild("RF"):WaitForChild("SummonOnce"):InvokeServer()
        end
    })
    Tabs.Main:AddButton({
        Title = "Summon banner 10 times",
        Description = "Summon banner 10 times for 1000 gems",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService")
                :WaitForChild("RF"):WaitForChild("SummonThree"):InvokeServer()
        end
    })
    Tabs.Main:AddButton({
        Title = "Time banner roll",
        Description = "Roll time banner 1 time for 1 time shard",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService")
                :WaitForChild("RF"):WaitForChild("Spin"):InvokeServer(unpack(TimeBanner))
        end
    })
    Tabs.Main:AddButton({
        Title = "Sus Vampire Element",
        Description = "Buying element for gold from Sus Vampire",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService")
                :WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(player)
        end
    })

    -- Craft
    Tabs.Main:AddParagraph({Title = "Craft", Content = "Crafting"})
    Tabs.Main:AddButton({
        Title = "Craft time shard",
        Description = "Craft 1 time shard for 100 tickmetal fragments",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService")
                :WaitForChild("RF"):WaitForChild("CraftSpecialMaterial"):InvokeServer(unpack(TimeBanner))
        end
    })

    -- Dungeons
    Tabs.Main:AddParagraph({Title = "Dungeons", Content = "Dungeons"})
    local DungeonDropdown = Tabs.Main:AddDropdown("Dungeons", {
        Title = "Select Dungeon",
        Values = {"Ancient Tomb", "Jungle", "Snow Castle", "Atlantis", "Underworld", "Angel Sanctuary"},
        Multi = false,
        Default = 1
    })
    DungeonDropdown:SetValue("Ancient Tomb")
    DungeonDropdown:OnChanged(function(dungeons)
        dungeon = dungeons
        UpdateStatus()
    end)

    local DifficultyDropdown = Tabs.Main:AddDropdown("Difficulties", {
        Title = "Select Difficulty",
        Values = {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"},
        Multi = false,
        Default = 1
    })
    DifficultyDropdown:SetValue("Easy")
    DifficultyDropdown:OnChanged(function(difficultys)
        difficulty = difficultys
        UpdateStatus()
    end)

    -- Кнопки создания
    Tabs.Main:AddButton({
        Title = "Create Dungeon",
        Description = "Creating selected dungeon",
        Callback = function()
            local DungeonsMap = {
                ["Ancient Tomb"] = {"BeginnersDungeon", difficulty, "All", "Normal"},
                ["Jungle"] = {"JungleDungeon", difficulty, "All", "Normal"},
                ["Snow Castle"] = {"ArcticBastionDungeon", difficulty, "All", "Normal"},
                ["Atlantis"] = {"UnderwaterDungeon", difficulty, "All", "Normal"},
                ["Underworld"] = {"FireDungeon", difficulty, "All", "Normal"},
                ["Angel Sanctuary"] = {"CloudDungeon", difficulty, "All", "Normal"}
            }

            if dungeon and DungeonsMap[dungeon] then
                game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage")
                    :WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
                    :WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty")
                    :InvokeServer(unpack(DungeonsMap[dungeon]))
            end
        end
    })

    Tabs.Main:AddButton({
        Title = "Create Infinite Time Dungeon",
        Description = "Creating Infinite Tower Time Dungeon",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage")
                :WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
                :WaitForChild("PartyService"):WaitForChild("RF"):WaitForChild("CreateParty")
                :InvokeServer(unpack(args))
        end
    })

    -- Craft Keys
    Tabs.Craft:AddParagraph({Title = "Esp", Content = "Show items on map"})
    local KeyDropdown = Tabs.Craft:AddDropdown("Craft Keys", {
        Title = "Select Key",
        Values = {"Angel Key", "Dragon Key", "Zeus Key", "Reaper Key", "Skeleton Key", "Kronax Key", "Heroic Kronax Key"},
        Multi = false,
        Default = 1
    })
    KeyDropdown:SetValue("Angel Key")
    KeyDropdown:OnChanged(function(Keys)
        Key = Keys
        UpdateStatus()
    end)

    Tabs.Craft:AddButton({
        Title = "Craft Selected Key",
        Description = "Crafting or Buying Key",
        Callback = function()
            local CraftMap = {
                ["Zeus Key"] = 19,
                ["Dragon Key"] = 20,
                ["Reaper Key"] = 17,
                ["Skeleton Key"] = 21,
                ["Angel Key"] = 18,
                ["Kronax Key"] = 199,
                ["Heroic Kronax Key"] = 200
            }
            if CraftMap[Key] > 16 and CraftMap[Key] < 22 then
                game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage")
                    :WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
                    :WaitForChild("CraftingService"):WaitForChild("RF"):WaitForChild("Craft")
                    :InvokeServer(CraftMap[Key])
            elseif CraftMap[Key] == 199 then
                game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("PurchaseKronaxKey"):InvokeServer()
            elseif CraftMap[Key] == 200 then
                game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("PurchaseHeroicKronaxKey"):InvokeServer()
            end
        end
    })

    -- Функция обновления статуса
local function UpdateStatusRoll()
    if not StatusPanelRoll then return end

    StatusPanelRoll:SetDesc(
        "⚔ Sword: " .. tostring(Sword or "None") ..
        "\n💥 Damage: " .. tostring(Damage or "—") ..
        "\n⬆ Upgrade: " .. tostring(Upgrade or "—") ..
        "\n🟣 Corrupted: " .. (Cor and "🟢" or "🔴") ..
        "\n✨ Reforge: " .. tostring(Reforge or "None") ..
        "\n🎲 Roll: " .. tostring(Roll or "—") ..
        "\n📈 Base Damage: " .. tostring(BaseDamage or "—")
    )
end

    -- Статус панель
    StatusPanelRoll = Tabs.Roll:AddParagraph({
        Title = "Roll Status",
        Content = "Sword: None\nDamage: None\nUpgrade: None\nCorrupted: No\nReforge: None\nRoll: idk\nMaxDamage: idk"
    })

    local Reforges = {
                ["Godly"] = 1.5,
                ["Mythical"] = 1.4,
                ["Vicious"] = 1.4,
                ["Cruel"] = 1.3,
                ["Ruthless"] = 1.3,
                ["Frenzied"] = 1.3,
                ["Furious"] = 1.2,
                ["Legendary"] = 1.2,
                ["Relentless"] = 1.2,
                ["Superior"] = 1.2,
                ["Savage"] = 1.1,
                ["Dangerous"] = 1.1,
                ["Hasty"] = 1.1,
                ["Mystical"] = 1.1,
                ["Percise"] = 1,
                ["Swift"] = 1,
                ["Murderous"] = 0.9
            }

    local RollList = {
        ["Asc Daggers"] = AscDaggersRolls,
        ["Asc Lightning Katana"] = AscSwordRolls,
        ["Menta V2"] = AscSwordRolls,
        ["Asc Abyssal Trident"] = AscSwordRolls,
        ["Asc Magma's Edge"] = AscSwordRolls,
        ["Conq Blade"] = ConqBladeRolls,
        ["Doombringer"] = DoombringerRolls,
        ["TL Conq Blade"] = TLConqRolls
    }

    Tabs.Roll:AddButton({
    Title = "Calculate",
    Description = "Calculate Roll",
    Callback = function()

        local dmg = Damage
        local upg = Upgrade

        if Cor then
            dmg = dmg / 1.5
        end

        dmg = dmg / Reforges[Reforge]

        local result = dmg / (1 + (upg * 0.047619))

        BaseDamage = result

        print("Base Damage:", BaseDamage)

        Roll = findClosestIndex(BaseDamage, RollList[Sword])

        if RollList[Sword] == AscDaggersRolls or RollList[Sword] == AscSwordRolls then
            Roll = Roll + 5
        end
        
        UpdateStatusRoll()
    end
})

    -- роллы
     local SwordRollDropdown = Tabs.Roll:AddDropdown("Select Sword for check roll", {
        Title = "Select Sword",
        Values = {"Asc Daggers", "Asc Lightning Katana", "Menta V2", "Asc Abyssal Trident", "Asc Magma's Edge", "TL Conq Blade", "Conq Blade", "Doombringer"},
        Multi = false,
        Default = 1
    })
    SwordRollDropdown:SetValue("Asc Daggers")
    SwordRollDropdown:OnChanged(function(Swords)
        Sword = Swords
        UpdateStatusRoll()
    end)

    local DamageInput = Tabs.Roll:AddInput("Damage Input", {
    Title = "Damage",
    Default = "",
    Placeholder = "Need Press Enter!",
    Numeric = true,
    Finished = true,
    Callback = function(Hit)
        Damage = Hit
        print("Damage: ", Damage)
        UpdateStatusRoll()
    end
})  

    local UpgradeInput = Tabs.Roll:AddInput("Upgrade Input", {
    Title = "Upgrade",
    Default = "",
    Placeholder = "Need Press Enter!",
    Numeric = true,
    Finished = true,
    Callback = function(Upg)
        Upgrade = Upg
        print("Upgrade: ", Upgrade)
        UpdateStatusRoll()
    end
})  

    Tabs.Roll:AddToggle("Is Sword Corrupted", {
    Title = "Corrupted",
    Default = false,
    Callback = function(IsCor)
        Cor = IsCor
        UpdateStatusRoll()
    end
})

    local SwordReforgeDropdown = Tabs.Roll:AddDropdown("Select Reforge for check roll", {
        Title = "Select Reforge",
        Values = {"Godly", "Mythical", "Vicious", "Cruel", "Ruthless", "Frenzied", "Superior", "Furious", "Legendary", "Relenless", "Savage", "Dangerous", "Hasty", "Mystical", "Swift", "Percise", "Murderous"},
        Multi = false,
        Default = 1
    })
    SwordReforgeDropdown:SetValue("Godly")
    SwordReforgeDropdown:OnChanged(function(Ref)
        Reforge = Ref
        UpdateStatusRoll()
    end)
end
