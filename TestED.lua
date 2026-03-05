-- Update 0.1.4
-- Added Armor and Sword Rolls
-- Alpha Version

-- Переменные
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerr = character:WaitForChild("HumanoidRootPart")
local npcSus = workspace.MapContent.NPCs["Sus Vampire"]:WaitForChild("HumanoidRootPart")
local npcHG = workspace.MapContent.NPCs["Handy Gorilla"]:WaitForChild("HumanoidRootPart")

local ClosestRollDamage
local GoldSpent = 0
local GoldLeftToSpent = 0
local RollTable
local StatusPanel
local Roll
local StatusPanelRoll
local difficulty, dungeon, Key
local Cor = false
local ArmorSet
local Armor
local Health
local UpgradeArmor
local CorArmor = false

local RollArmor
local ClosestRollHealth
local GoldSpentArmor = 0
local GoldLeftToSpentArmor = 0
local BaseHeal

-- Функции
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

local function formatNumber(n)
    if not n then return "0" end
    
    local formatted = tostring(math.floor(n))
    formatted = formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    formatted = formatted:gsub("^,", "")
    
    return formatted
end

-- Массивы
local TimeBanner = {"TimeBanner2025"}
local args = {"InfiniteTimeDungeon", "Hardcore", "All", "MiscChallenges"}
local AscDaggersRolls = {5126.44, 5175.30, 5224.16, 5273.01, 5321.87, 5370.73}
local AscSwordRolls = {8434.12, 8514.45, 8594.77, 8675.10, 8755.42, 8835.75}
local ConqBladeRolls = {8032.50, 8112.82, 8193.15, 8273.48, 8353.80, 8434.12, 8514.45, 8594.77, 8675.10, 8755.42, 8835.75}
local DoombringerRolls = {6300, 6363, 6426, 6489, 6552, 6615, 6678, 6741, 6804, 6867, 6930}
local TLConqRolls = {6825, 6893.25, 6961.50, 7029.75, 7098.05, 7166.25, 7234.50, 7302.75, 7371, 7439.25, 7507.50}
local FZHelmet = {787.50, 795.38, 803.25, 811.12, 819, 826.88, 834.75, 842.62, 850.50, 858.38, 866.25}
local FZChestplate = {708.85, 715.91, 722.96, 730.02, 737.08, 744.14, 751.19, 758.25, 765.31, 772.37, 779.42}
local FZLeggings = {682.50, 689.32, 696.13, 702.95, 709.77, 716.59, 723.40, 730.22, 737.04, 743.85, 750.67}
local ZHelmet = {577.50, 583.27, 589.05, 594.83, 600.60, 606.38, 612.15, 617.92, 623.70, 629.48, 635.25}
local ZChestplate = {603.75, 609.79, 615.83, 621.86, 627.90, 633.94, 639.98, 646.01, 652.05, 658.09, 664.12}
local ZLeggings = {682.50, 689.32, 696.13, 702.95, 709.77, 716.59, 723.40, 730.22, 737.04, 743.85, 750.67}
local HKSet = {840, 848.40, 856.80, 865.20, 873.60, 882, 890.40, 898.80, 907.20, 915.60, 924}

local AscSwordsGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000, 4300000, 4800000, 5300000, 5800000, 6300000, 6800000, 7300000, 7800000, 8300000, 8800000, 9300000, 9800000, 10300000, 10800000, 11300000, 11800000, 12300000, 12800000, 13300000, 13800000, 14300000, 14800000, 15300000, 15800000, 16300000, 16800000, 17300000, 17800000, 18300000, 18800000, 19300000, 19800000, 20300000, 20800000, 21300000, 21800000, 22300000, 22800000, 23300000, 23800000}
local ConqBladeGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000, 4300000, 4800000, 5300000, 5800000, 6300000, 6800000, 7300000, 7800000, 8300000, 8800000}
local DoombringerGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000}
local FZGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000, 4300000, 4800000, 5300000, 5800000, 6300000, 6800000, 7300000, 7800000, 8300000, 8800000, 9300000}
local ZGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000}
local KGold = {500, 1500, 2750, 4000, 6000, 8000, 10500, 13000, 15500, 18000, 21000, 24500, 28000, 32000, 35000, 45000, 57500, 70000, 73000, 88000, 100000, 150000, 250000, 400000, 550000, 700000, 900000, 1100000, 1300000, 1800000, 2300000, 2800000, 3300000, 3800000, 4300000, 4800000, 5300000, 5800000, 6300000, 6800000, 7300000, 7800000, 8300000, 8800000}

-- Загрузка библиотеки
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = "Elemental dungeon hub",
    SubTitle = "Version 0.1.4",
    TabWidth = 180,
    Size = UDim2.fromOffset(580, 560),
    Acrylic = true,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Создание вкладок
local Tabs = {
    Main = Window:AddTab({ Title = "Hub", Icon = "home"}),
    Summon = Window:AddTab({ Title = "Summon", Icon = "star"}),
    Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "gamepad-2"}),
    Craft = Window:AddTab({ Title = "Craft", Icon = "hammer"}),
    Roll = Window:AddTab({ Title = "Sword Roll", Icon = "swords"}),
    Armor = Window:AddTab({ Title = "Armor Roll", Icon = "shield"}),
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

    local Gems = game:GetService("Players").rriihhttGG.PlayerScripts.StarterPlayerScripts.Controllers.MainUIController.Gems.Value
    local Gold = game:GetService("Players").rriihhttGG.PlayerScripts.StarterPlayerScripts.Controllers.MainUIController.Gold.Value
    local Raidium = game:GetService("Players").rriihhttGG.PlayerScripts.StarterPlayerScripts.Controllers.MainUIController.Raidium.Value

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
        "\nSelected Key: " .. tostring(Key or "None") ..
        "\n🟡Gold: " .. tostring(Gold) ..
        "\n💎Gems: " .. tostring(Gems) ..
        "\n®Raidiums: " .. tostring(Raidium)
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
    Tabs.Summon:AddButton({
        Title = "Summon banner 1 time",
        Description = "Summon banner 1 time for 100 gems",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService")
                :WaitForChild("RF"):WaitForChild("SummonOnce"):InvokeServer()
        end
    })
    Tabs.Summon:AddButton({
        Title = "Summon banner 10 times",
        Description = "Summon banner 10 times for 1000 gems",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SummoningService")
                :WaitForChild("RF"):WaitForChild("SummonThree"):InvokeServer()
        end
    })
    Tabs.Summon:AddButton({
        Title = "Time banner roll",
        Description = "Roll time banner 1 time for 1 time shard",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService")
                :WaitForChild("RF"):WaitForChild("Spin"):InvokeServer(unpack(TimeBanner))
        end
    })
    Tabs.Summon:AddButton({
        Title = "Sus Vampire Element",
        Description = "Buying element for gold from Sus Vampire",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService")
                :WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(player)
        end
    })


    -- Dungeons
    local DungeonDropdown = Tabs.Dungeon:AddDropdown("Dungeons", {
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

    local DifficultyDropdown = Tabs.Dungeon:AddDropdown("Difficulties", {
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
    Tabs.Dungeon:AddButton({
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

    Tabs.Dungeon:AddButton({
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

    Tabs.Craft:AddButton({
        Title = "Craft time shard",
        Description = "Craft 1 time shard for 100 tickmetal fragments",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GachaService")
                :WaitForChild("RF"):WaitForChild("CraftSpecialMaterial"):InvokeServer(unpack(TimeBanner))
        end
    })


    -- Функция обновления статуса
local function UpdateStatusRoll()
    if not StatusPanelRoll then return end

    local rollDmgColor = ""
    if Roll then
        if Roll >= 1 and Roll <= 5 then
            rollDmgColor = "🔴"
        elseif Roll >= 6 and Roll <= 8 then
            rollDmgColor = "🟡"
        elseif Roll >= 9 and Roll <= 10 then
            rollDmgColor = "🟢"
        elseif Roll == 11 then
            rollDmgColor = "🟣"
        end
    end

    StatusPanelRoll:SetDesc(
        "⚔ Sword: " .. tostring(Sword or "None") ..
        "\n💥 Damage: " .. tostring(Damage or "Make Sure You Press Enter!") ..
        "\n⬆ Upgrade: " .. tostring(Upgrade or "Make Sure You Press Enter!") ..
        "\n🟣 Corrupted: " .. (Cor and "✅" or "❌") ..
        "\n✨ Reforge: " .. tostring(Reforge or "None") ..
        "\n🎲 Roll: "..(Roll or "Uhm. . .").." "..rollDmgColor.." ("..(ClosestRollDamage or "Hmm. . .")..")"..
        "\n📈 Base Damage: " .. tostring(BaseDamage or "Idk") ..
        "\n🥇 Gold Spent: " .. tostring(formatNumber(GoldSpent) or "Uh. . .") ..
        "\n🟡 Gold Left To Spent: " .. tostring(formatNumber(GoldLeftToSpent) or "🤔")
    )
end

    -- Статус панель
    StatusPanelRoll = Tabs.Roll:AddParagraph({
        Title = "Roll Status",
        Content = "Sword: None\nDamage: None\nUpgrade: None\nCorrupted: No\nReforge: None\nRoll: idk\nMaxDamage: idk"
    })

    local GoldTables = {
    ["Asc Daggers"] = AscSwordsGold,
    ["Asc Lightning Katana"] = AscSwordsGold,
    ["Menta V2"] = AscSwordsGold,
    ["Asc Abyssal Trident"] = AscSwordsGold,
    ["Asc Magma's Edge"] = AscSwordsGold,
    ["TL Conq Blade"] = ConqBladeGold,
    ["Conq Blade"] = ConqBladeGold,
    ["Doombringer"] = DoombringerGold
}

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
        local goldTable = GoldTables[Sword]

        -- Приводим значения к числу
        local dmg = tonumber(Damage) or 0
        local upg = tonumber(Upgrade) or 0

        GoldSpent = 0
        GoldLeftToSpent = 0

        -- Считаем GoldSpent
        for i = 1, upg do
            GoldSpent += goldTable[i] or 0
        end

        -- Считаем GoldLeftToSpend
        for i = upg + 1, #goldTable do
            GoldLeftToSpent += goldTable[i] or 0
        end

        -- Коррупция
        if Cor then
            dmg = dmg / 1.5
        end

        -- Reforge
        dmg = dmg / (Reforges[Reforge] or 1)

        -- Базовый урон
        BaseDamage = dmg / (1 + (upg * 0.047619))

        print("Gold Spent:", GoldSpent)
        print("Gold Left To Spend:", GoldLeftToSpend)
        print("Base Damage:", BaseDamage)

        -- Находим ближайший ролл
        Roll = findClosestIndex(BaseDamage, RollList[Sword])
        RollTable = RollList[Sword]
        ClosestRollDamage = RollTable[Roll]

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
        Values = {"Godly", "Mythical", "Vicious", "Cruel", "Ruthless", "Frenzied", "Superior", "Furious", "Legendary", "Relentless", "Savage", "Dangerous", "Hasty", "Mystical", "Swift", "Percise", "Murderous"},
        Multi = false,
        Default = 1
    })
    SwordReforgeDropdown:SetValue("Godly")
    SwordReforgeDropdown:OnChanged(function(Ref)
        Reforge = Ref
        UpdateStatusRoll()
    end)

-- Инициализация переменных для Armor Roll
ArmorSet = "Furious Zeus Set"
Armor = "Helmet"
Health = nil
UpgradeArmor = nil
BaseHeal = nil
CorArmor = false
GoldSpentArmor = 0
GoldLeftToSpentArmor = 0
RollArmor = nil
ClosestRollHealth = nil

-- Таблицы золота и роллов
local GoldTablesArmor = {
    ["Furious Zeus Set"] = FZGold,
    ["Zeus Set"] = ZGold,
    ["Kronax Set"] = KGold,
    ["Heroic Kronax Set"] = KGold
}

local ArmorRollList = {
    ["Furious Zeus Set"] = {Helmet=FZHelmet, Chestplate=FZChestplate, Leggings=FZLeggings},
    ["Zeus Set"] = {Helmet=ZHelmet, Chestplate=ZChestplate, Leggings=ZLeggings},
    ["Kronax Set"] = {Helmet=FZHelmet, Chestplate=FZHelmet, Leggings=FZHelmet},
    ["Heroic Kronax Set"] = {Helmet=HKSet, Chestplate=HKSet, Leggings=HKSet}
}

-- Панель статуса
StatusPanelArmor = Tabs.Armor:AddParagraph({
    Title = "Armor Roll Status",
    Content = 
        "🛡 Set: -\n" ..
        "💓 Health: -\n" ..
        "⬆ Upgrade: -\n" ..
        "🟣 Corrupted: -\n" ..
        "🎲 Roll: - (-)\n" ..
        "♥ Base Heal: -\n" ..
        "🥇 Gold Spent: -\n" ..
        "🟡 Gold Left: -"
})

-- Функция обновления статуса
local function UpdateStatusArmor()
    if not StatusPanelArmor then return end

    local rollColor = ""
    if RollArmor then
        if RollArmor >= 1 and RollArmor <= 5 then
            rollColor = "🔴"
        elseif RollArmor >= 6 and RollArmor <= 8 then
            rollColor = "🟡"
        elseif RollArmor >= 9 and RollArmor <= 10 then
            rollColor = "🟢"
        elseif RollArmor == 11 then
            rollColor = "🟣"
        end
    end

    StatusPanelArmor:SetDesc(
        "🛡 Set: "..(ArmorSet or "-").." ("..(Armor or "-")..")"..
        "\n💓 Health: "..(Health or "Make Sure You Press Enter!")..
        "\n⬆ Upgrade: "..(UpgradeArmor or "Make Sure You Press Enter!")..
        "\n🟣 Corrupted: "..(CorArmor and "✅" or "❌")..
        "\n🎲 Roll: "..(RollArmor or "Idk").." "..rollColor.." ("..(ClosestRollHealth or "🤔")..")"..
        "\n♥ Base Heal: "..(BaseHeal or "Uhh. . .")..
        "\n🥇 Gold Spent: "..(GoldSpentArmor > 0 and formatNumber(GoldSpentArmor) or "0")..
        "\n🟡 Gold Left: "..(GoldLeftToSpentArmor > 0 and formatNumber(GoldLeftToSpentArmor) or "0")
    )
end

-- Кнопка расчета
Tabs.Armor:AddButton({
    Title = "Calculate",
    Callback = function()
        local goldTable = GoldTablesArmor[ArmorSet]
        local rollTable = ArmorRollList[ArmorSet] and ArmorRollList[ArmorSet][Armor]

        if not goldTable or not rollTable then
            warn("Armor data missing")
            return
        end

        local hl = tonumber(Health) or 0
        local upg = tonumber(UpgradeArmor) or 0

        GoldSpentArmor = 0
        GoldLeftToSpentArmor = 0

        for i = 1, upg do
            GoldSpentArmor += goldTable[i] or 0
        end

        for i = upg + 1, #goldTable do
            GoldLeftToSpentArmor += goldTable[i] or 0
        end

        if CorArmor then
            hl /= 1.5
        end

        BaseHeal = hl / (1 + (upg * 0.047619))

        RollArmor = findClosestIndex(BaseHeal, rollTable)
        ClosestRollHealth = rollTable[RollArmor]

        UpdateStatusArmor()
    end
})

-- Dropdowns и Inputs
Tabs.Armor:AddDropdown("ArmorSetSelect", {
    Title = "Select Armor Set",
    Values = {"Furious Zeus Set","Zeus Set","Kronax Set","Heroic Kronax Set"},
    Default = 1,
    Callback = function(v)
        ArmorSet = v
        UpdateStatusArmor()
    end
})

Tabs.Armor:AddDropdown("ArmorPieceSelect", {
    Title = "Select Armor",
    Values = {"Helmet","Chestplate","Leggings"},
    Default = 1,
    Callback = function(v)
        Armor = v
        UpdateStatusArmor()
    end
})

Tabs.Armor:AddInput("HealthInput", {
    Title = "Health",
    Placeholder = "Need Press Enter!",
    Numeric = true,
    Finished = true,
    Callback = function(v)
        Health = v
        UpdateStatusArmor()
    end
})

Tabs.Armor:AddInput("UpgradeArmorInput", {
    Title = "Upgrade",
    Placeholder = "Need Press Enter!",
    Numeric = true,
    Finished = true,
    Callback = function(v)
        UpgradeArmor = v
        UpdateStatusArmor()
    end
})

Tabs.Armor:AddToggle("ArmorCor", {
    Title = "Corrupted",
    Callback = function(v)
        CorArmor = v
        UpdateStatusArmor()
    end
})

    
end
