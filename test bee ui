--[[
╔══════════════════════════════════════════════════════════════════╗
║                         BeeUI v1.0                            ║
║              Roblox GUI Library by BeeUI Team                 ║
║                                                                  ║
║  Лаконичная, красивая и удобная библиотека для создания          ║
║  интерфейсов в Roblox. Поддерживает темы, анимации,             ║
║  уведомления, вкладки, кнопки, слайдеры, тогглы и многое другое.║
╚══════════════════════════════════════════════════════════════════╝

ИСПОЛЬЗОВАНИЕ:
    local BeeUI = loadstring(game:HttpGet("..."))()

    local Window = BeeUI:CreateWindow({
        Title = "My Script",
        SubTitle = "by Author",
        Theme = "Dark",
        Size = UDim2.new(0, 580, 0, 460),
    })

    local Tab = Window:AddTab({ Name = "Main", Icon = "rbxassetid://..." })

    Tab:AddButton({ Label = "Click Me", Callback = function() print("Clicked!") end })
    Tab:AddToggle({ Label = "Toggle", Default = false, Callback = function(v) print(v) end })
    Tab:AddSlider({ Label = "Speed", Min = 0, Max = 100, Default = 50, Callback = function(v) print(v) end })
    Tab:AddDropdown({ Label = "Mode", Options = {"A","B","C"}, Default = "A", Callback = function(v) print(v) end })
    Tab:AddInput({ Label = "Name", Placeholder = "Enter text...", Callback = function(v) print(v) end })
    Tab:AddLabel("This is a label")
    Tab:AddSeparator()
    Tab:AddColorPicker({ Label = "Color", Default = Color3.fromRGB(255,100,50), Callback = function(c) print(c) end })

    BeeUI:Notify({ Title = "Hello", Message = "BeeUI loaded!", Duration = 3 })
]]

local BeeUI = {}
BeeUI.__index = BeeUI

-- ══════════════════════════════════════════
--  СЕРВИСЫ
-- ══════════════════════════════════════════
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

-- ══════════════════════════════════════════
--  ТЕМЫ
-- ══════════════════════════════════════════
BeeUI.Themes = {
    Dark = {
        -- Фоны
        Background        = Color3.fromRGB(28,  18,  6  ),
        Surface           = Color3.fromRGB(38,  25,  8  ),
        SurfaceElevated   = Color3.fromRGB(50,  33,  10 ),
        SurfaceHover      = Color3.fromRGB(65,  44,  14 ),

        -- Текст
        TextPrimary       = Color3.fromRGB(240, 240, 245),
        TextSecondary     = Color3.fromRGB(140, 140, 160),
        TextMuted         = Color3.fromRGB(80,  80,  100),

        -- Акценты
        Accent            = Color3.fromRGB(255, 180, 30 ),  -- медовый
        AccentHover       = Color3.fromRGB(255, 200, 70 ),
        AccentSoft        = Color3.fromRGB(255, 180, 30 ),
        AccentGlow        = Color3.fromRGB(255, 210, 80 ),

        -- Рамки
        Border            = Color3.fromRGB(80,  55,  18 ),
        BorderAccent      = Color3.fromRGB(180, 130, 30 ),

        -- Статусы
        Success           = Color3.fromRGB(52,  211, 153),
        Warning           = Color3.fromRGB(251, 191, 36 ),
        Error             = Color3.fromRGB(239, 68,  68 ),
        Info              = Color3.fromRGB(96,  165, 250),

        -- Контролы
        ControlBg         = Color3.fromRGB(55,  36,  12 ),
        ControlBorder     = Color3.fromRGB(100, 68,  20 ),
        SliderTrack       = Color3.fromRGB(70,  46,  14 ),
        SliderFill        = Color3.fromRGB(255, 180, 30 ),
        ToggleOff         = Color3.fromRGB(80,  55,  18 ),
        ToggleOn          = Color3.fromRGB(255, 180, 30 ),

        -- Вкладки
        TabActive         = Color3.fromRGB(210, 145, 20 ),
        TabInactive       = Color3.fromRGB(44,  29,  9  ),
        TabText           = Color3.fromRGB(200, 165, 90 ),

        -- Заголовок
        TitleBarBg        = Color3.fromRGB(22,  14,  4  ),
        TitleText         = Color3.fromRGB(255, 255, 255),
        SubTitleText      = Color3.fromRGB(180, 140, 60 ),
        CloseBtn          = Color3.fromRGB(239, 68,  68 ),
        MinBtn            = Color3.fromRGB(251, 191, 36 ),

        -- Уведомления
        NotifyBg          = Color3.fromRGB(35,  22,  7  ),
        NotifyBorder      = Color3.fromRGB(100, 70,  20 ),
    },
    Light = {
        Background        = Color3.fromRGB(248, 248, 252),
        Surface           = Color3.fromRGB(255, 255, 255),
        SurfaceElevated   = Color3.fromRGB(245, 245, 250),
        SurfaceHover      = Color3.fromRGB(235, 235, 245),
        TextPrimary       = Color3.fromRGB(15,  15,  25 ),
        TextSecondary     = Color3.fromRGB(90,  90,  120),
        TextMuted         = Color3.fromRGB(160, 160, 180),
        Accent            = Color3.fromRGB(99,  70,  240),
        AccentHover       = Color3.fromRGB(120, 95,  255),
        AccentSoft        = Color3.fromRGB(99,  70,  240),
        AccentGlow        = Color3.fromRGB(99,  70,  240),
        Border            = Color3.fromRGB(220, 220, 235),
        BorderAccent      = Color3.fromRGB(180, 160, 240),
        Success           = Color3.fromRGB(16,  185, 129),
        Warning           = Color3.fromRGB(245, 158, 11 ),
        Error             = Color3.fromRGB(220, 38,  38 ),
        Info              = Color3.fromRGB(59,  130, 246),
        ControlBg         = Color3.fromRGB(240, 240, 248),
        ControlBorder     = Color3.fromRGB(210, 210, 230),
        SliderTrack       = Color3.fromRGB(220, 220, 235),
        SliderFill        = Color3.fromRGB(99,  70,  240),
        ToggleOff         = Color3.fromRGB(200, 200, 220),
        ToggleOn          = Color3.fromRGB(99,  70,  240),
        TabActive         = Color3.fromRGB(99,  70,  240),
        TabInactive       = Color3.fromRGB(240, 240, 248),
        TabText           = Color3.fromRGB(60,  60,  90 ),
        TitleBarBg        = Color3.fromRGB(255, 255, 255),
        TitleText         = Color3.fromRGB(15,  15,  25 ),
        SubTitleText      = Color3.fromRGB(120, 100, 200),
        CloseBtn          = Color3.fromRGB(220, 38,  38 ),
        MinBtn            = Color3.fromRGB(245, 158, 11 ),
        NotifyBg          = Color3.fromRGB(255, 255, 255),
        NotifyBorder      = Color3.fromRGB(210, 210, 230),
    },
}

-- ══════════════════════════════════════════
--  УТИЛИТЫ
-- ══════════════════════════════════════════
local Util = {}

-- Создать Tween с настройками по умолчанию
function Util.Tween(obj, info, props)
    local ti = typeof(info) == "TweenInfo" and info or TweenInfo.new(
        info.Time or 0.35,
        info.Ease or Enum.EasingStyle.Sine,
        info.Dir  or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, ti, props)
    t:Play()
    return t
end

-- Быстрые твины
function Util.TweenFast(obj, props, t)
    return Util.Tween(obj, {Time = t or 0.25}, props)
end

-- Скруглённый прямоугольник через UICorner
function Util.Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius  = UDim.new(0, radius or 8)
    c.Parent        = parent
    return c
end

-- Padding
function Util.Padding(parent, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 0)
    p.PaddingRight  = UDim.new(0, right  or 0)
    p.PaddingBottom = UDim.new(0, bottom or 0)
    p.PaddingLeft   = UDim.new(0, left   or 0)
    p.Parent        = parent
    return p
end

-- UIStroke
function Util.Stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color        = color or Color3.new(1,1,1)
    s.Thickness    = thickness or 1
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent       = parent
    return s
end

-- UIListLayout
function Util.ListLayout(parent, dir, padding, align)
    local l = Instance.new("UIListLayout")
    l.FillDirection      = dir    or Enum.FillDirection.Vertical
    l.Padding            = UDim.new(0, padding or 6)
    l.HorizontalAlignment = align  or Enum.HorizontalAlignment.Left
    l.SortOrder          = Enum.SortOrder.LayoutOrder
    l.Parent             = parent
    return l
end

-- Создать Frame
function Util.Frame(parent, props)
    local f = Instance.new("Frame")
    f.BorderSizePixel = 0
    for k, v in pairs(props or {}) do f[k] = v end
    f.Parent = parent
    return f
end

-- Создать TextLabel
function Util.Label(parent, props)
    local l = Instance.new("TextLabel")
    l.BorderSizePixel     = 0
    l.BackgroundTransparency = 1
    l.Font                = Enum.Font.Ubuntu
    l.TextSize            = 14
    l.TextXAlignment      = Enum.TextXAlignment.Left
    for k, v in pairs(props or {}) do l[k] = v end
    l.Parent = parent
    return l
end

-- Создать TextButton
function Util.Button(parent, props)
    local b = Instance.new("TextButton")
    b.BorderSizePixel     = 0
    b.Font                = Enum.Font.Ubuntu
    b.TextSize            = 14
    b.AutoButtonColor     = false
    for k, v in pairs(props or {}) do b[k] = v end
    b.Parent = parent
    return b
end

-- Создать ImageLabel
function Util.Image(parent, props)
    local i = Instance.new("ImageLabel")
    i.BackgroundTransparency = 1
    i.BorderSizePixel        = 0
    for k, v in pairs(props or {}) do i[k] = v end
    i.Parent = parent
    return i
end

-- Перетаскивание окна
function Util.MakeDraggable(frame, handle)
    local dragging, dragStart, startPos = false, nil, nil
    handle = handle or frame

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = frame.Position
        end
    end)

    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Подсветка при наведении
function Util.HoverEffect(btn, normalColor, hoverColor, speed)
    speed = speed or 0.22
    btn.MouseEnter:Connect(function()
        Util.TweenFast(btn, {BackgroundColor3 = hoverColor}, speed)
    end)
    btn.MouseLeave:Connect(function()
        Util.TweenFast(btn, {BackgroundColor3 = normalColor}, speed)
    end)
end

-- Нажатие (scale pop)
function Util.ClickEffect(btn)
    btn.MouseButton1Down:Connect(function()
        Util.TweenFast(btn, {Size = UDim2.new(
            btn.Size.X.Scale, btn.Size.X.Offset - 2,
            btn.Size.Y.Scale, btn.Size.Y.Offset - 2
        )}, 0.08)
    end)
    btn.MouseButton1Up:Connect(function()
        Util.TweenFast(btn, {Size = UDim2.new(
            btn.Size.X.Scale, btn.Size.X.Offset + 2,
            btn.Size.Y.Scale, btn.Size.Y.Offset + 2
        )}, 0.1)
    end)
end

-- ══════════════════════════════════════════
--  ГЛАВНЫЙ КЛАСС — BeeUI
-- ══════════════════════════════════════════

BeeUI._activeTheme = nil
BeeUI._screenGui   = nil
BeeUI._notifyHolder = nil
BeeUI._notifyCount = 0

--[[
    Создать главное окно.
    @param config {
        Title   : string   = "BeeUI",
        SubTitle: string   = "v1.0",
        Theme   : string   = "Dark",       -- "Dark" | "Light"
        Size    : UDim2    = 580×460,
        Position: UDim2    = center,
        Logo    : string?  = nil,          -- rbxassetid
    }
    @returns Window
]]
function BeeUI:CreateWindow(config)
    config = config or {}

    -- Применить тему
    local themeName = config.Theme or "Dark"
    local theme     = self.Themes[themeName] or self.Themes.Dark
    self._activeTheme = theme

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BeeUI"
    screenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn    = false
    screenGui.DisplayOrder    = 999

    -- Пытаемся положить в CoreGui (executor), иначе — в PlayerGui
    local ok = pcall(function()
        screenGui.Parent = CoreGui
    end)
    if not ok then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    self._screenGui = screenGui

    -- Контейнер уведомлений
    local notifyHolder = Util.Frame(screenGui, {
        Name              = "NotifyHolder",
        BackgroundTransparency = 1,
        Size              = UDim2.new(0, 320, 1, 0),
        Position          = UDim2.new(1, -330, 0, 0),
        AnchorPoint       = Vector2.new(0, 0),
    })
    Util.ListLayout(notifyHolder, Enum.FillDirection.Vertical, 8)
    Util.Padding(notifyHolder, 16, 0, 0, 0)
    self._notifyHolder = notifyHolder

    -- ────────────────────────────────────────
    --  ГЛАВНЫЙ ФРЕЙМ ОКНА
    -- ────────────────────────────────────────
    local winSize = config.Size or UDim2.new(0, 580, 0, 460)
    local winPos  = config.Position or UDim2.new(0.5, -290, 0.5, -230)

    local windowFrame = Util.Frame(screenGui, {
        Name = "BeeWindow",
        Size            = winSize,
        Position        = winPos,
        BackgroundColor3 = theme.Background,
        ClipsDescendants = true,
    })
    Util.Corner(windowFrame, 14)
    Util.Stroke(windowFrame, theme.Border, 1, 0)

    -- Декоративная линия акцента сверху
    local accentLine = Util.Frame(windowFrame, {
        Name            = "AccentLine",
        Size            = UDim2.new(1, 0, 0, 2),
        Position        = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = theme.Accent,
    })

    -- ────────────────────────────────────────
    --  ЗАГОЛОВОК
    -- ────────────────────────────────────────
    local titleBar = Util.Frame(windowFrame, {
        Name            = "TitleBar",
        Size            = UDim2.new(1, 0, 0, 52),
        Position        = UDim2.new(0, 0, 0, 2),
        BackgroundColor3 = theme.TitleBarBg,
    })
    Util.Padding(titleBar, 0, 14, 0, 14)

    -- Разделитель под заголовком
    local titleDivider = Util.Frame(windowFrame, {
        Name            = "TitleDivider",
        Size            = UDim2.new(1, 0, 0, 1),
        Position        = UDim2.new(0, 0, 0, 54),
        BackgroundColor3 = theme.Border,
    })

    -- Лого (если есть)
    local logoOffset = 0
    if config.Logo then
        local logo = Util.Image(titleBar, {
            Image           = config.Logo,
            Size            = UDim2.new(0, 28, 0, 28),
            Position        = UDim2.new(0, 0, 0.5, -14),
        })
        logoOffset = 36
    end

    -- Заголовок текст
    local titleLabel = Util.Label(titleBar, {
        Name            = "Title",
        Text            = config.Title or "BeeUI",
        Font            = Enum.Font.Ubuntu,
        TextSize        = 16,
        TextColor3      = theme.TitleText,
        Size            = UDim2.new(1, -160, 0, 20),
        Position        = UDim2.new(0, logoOffset, 0, 8),
    })

    local subLabel = Util.Label(titleBar, {
        Name            = "SubTitle",
        Text            = config.SubTitle or "",
        Font            = Enum.Font.Ubuntu,
        TextSize        = 12,
        TextColor3      = theme.SubTitleText,
        Size            = UDim2.new(1, -160, 0, 16),
        Position        = UDim2.new(0, logoOffset, 0, 28),
    })

    -- Кнопки управления (закрыть / свернуть)
    local btnClose = Util.Button(titleBar, {
        Name            = "CloseBtn",
        Text            = "✕",
        Font            = Enum.Font.Ubuntu,
        TextSize        = 12,
        TextColor3      = Color3.fromRGB(255,255,255),
        BackgroundColor3 = theme.CloseBtn,
        Size            = UDim2.new(0, 28, 0, 28),
        Position        = UDim2.new(1, -28, 0.5, -14),
    })
    Util.Corner(btnClose, 7)

    local btnMin = Util.Button(titleBar, {
        Name            = "MinBtn",
        Text            = "–",
        Font            = Enum.Font.Ubuntu,
        TextSize        = 14,
        TextColor3      = Color3.fromRGB(30,20,0),
        BackgroundColor3 = theme.MinBtn,
        Size            = UDim2.new(0, 28, 0, 28),
        Position        = UDim2.new(1, -62, 0.5, -14),
    })
    Util.Corner(btnMin, 7)

    Util.HoverEffect(btnClose, theme.CloseBtn, Color3.fromRGB(220, 30, 30))
    Util.HoverEffect(btnMin,   theme.MinBtn,   Color3.fromRGB(220, 160, 10))
    Util.ClickEffect(btnClose)
    Util.ClickEffect(btnMin)

    -- ────────────────────────────────────────
    --  ТЕЛО ОКНА (вкладки + контент)
    -- ────────────────────────────────────────
    local bodyFrame = Util.Frame(windowFrame, {
        Name            = "Body",
        Size            = UDim2.new(1, 0, 1, -55),
        Position        = UDim2.new(0, 0, 0, 55),
        BackgroundTransparency = 1,
    })

    -- Левая панель вкладок
    local tabSidebar = Util.Frame(bodyFrame, {
        Name            = "TabSidebar",
        Size            = UDim2.new(0, 140, 1, 0),
        BackgroundColor3 = theme.Surface,
    })
    Util.Padding(tabSidebar, 10, 8, 10, 8)
    local tabList = Util.ListLayout(tabSidebar, Enum.FillDirection.Vertical, 4)

    -- Вертикальный разделитель
    local sidebarDivider = Util.Frame(bodyFrame, {
        Name            = "SidebarDivider",
        Size            = UDim2.new(0, 1, 1, 0),
        Position        = UDim2.new(0, 140, 0, 0),
        BackgroundColor3 = theme.Border,
    })

    -- Область контента
    local contentArea = Util.Frame(bodyFrame, {
        Name            = "ContentArea",
        Size            = UDim2.new(1, -141, 1, 0),
        Position        = UDim2.new(0, 141, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })

    -- ────────────────────────────────────────
    --  ПЕРЕТАСКИВАНИЕ
    -- ────────────────────────────────────────
    Util.MakeDraggable(windowFrame, titleBar)

    -- ────────────────────────────────────────
    --  АНИМАЦИЯ ПОЯВЛЕНИЯ
    -- ────────────────────────────────────────
    windowFrame.Size = UDim2.new(
        winSize.X.Scale, winSize.X.Offset,
        winSize.Y.Scale, 0
    )
    windowFrame.BackgroundTransparency = 1
    Util.Tween(windowFrame, {Time = 0.5, Ease = Enum.EasingStyle.Back, Dir = Enum.EasingDirection.Out}, {
        Size = winSize,
        BackgroundTransparency = 0,
    })

    -- ────────────────────────────────────────
    --  ЗАКРЫТИЕ / СВОРАЧИВАНИЕ
    -- ────────────────────────────────────────
    local minimized = false
    local fullSize  = winSize

    btnMin.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Util.Tween(windowFrame, {Time = 0.35, Ease = Enum.EasingStyle.Sine}, {
                Size = UDim2.new(winSize.X.Scale, winSize.X.Offset, 0, 52)
            })
            bodyFrame.Visible = false
        else
            bodyFrame.Visible = true
            Util.Tween(windowFrame, {Time = 0.4, Ease = Enum.EasingStyle.Back, Dir = Enum.EasingDirection.Out}, {
                Size = fullSize
            })
        end
    end)

    btnClose.MouseButton1Click:Connect(function()
        Util.Tween(windowFrame, {Time = 0.3, Ease = Enum.EasingStyle.Sine}, {
            Size = UDim2.new(winSize.X.Scale, winSize.X.Offset, 0, 0),
            BackgroundTransparency = 1,
        })
        task.delay(0.25, function()
            screenGui:Destroy()
        end)
    end)

    -- ══════════════════════════════════════════
    --  ОБЪЕКТ ОКНА
    -- ══════════════════════════════════════════
    local Window = {}
    Window._theme       = theme
    Window._tabs        = {}
    Window._activeTab   = nil
    Window._tabSidebar  = tabSidebar
    Window._contentArea = contentArea

    -- ────────────────────────────────────────────────────────────────────────
    --  Window:AddTab(config)
    --  config = { Name = string, Icon = string? }
    -- ────────────────────────────────────────────────────────────────────────
    function Window:AddTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or ("Tab " .. (#self._tabs + 1))

        -- Кнопка вкладки в сайдбаре
        local isFirst = #self._tabs == 0

        local tabBtn = Util.Button(self._tabSidebar, {
            Name            = tabName .. "_Btn",
            Text            = "",
            Size            = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = isFirst and theme.TabActive or theme.TabInactive,
        })
        Util.Corner(tabBtn, 8)

        -- Иконка (если есть)
        local textOffsetX = 10
        if tabConfig.Icon then
            local iconImg = Util.Image(tabBtn, {
                Image           = tabConfig.Icon,
                Size            = UDim2.new(0, 16, 0, 16),
                Position        = UDim2.new(0, 10, 0.5, -8),
            })
            textOffsetX = 32
        end

        local tabLabel = Util.Label(tabBtn, {
            Text            = tabName,
            Font            = Enum.Font.Ubuntu,
            TextSize        = 13,
            TextColor3      = isFirst and Color3.fromRGB(255,255,255) or theme.TabText,
            Size            = UDim2.new(1, -textOffsetX - 4, 1, 0),
            Position        = UDim2.new(0, textOffsetX, 0, 0),
        })

        -- Фрейм контента вкладки
        local tabContent = Util.Frame(self._contentArea, {
            Name            = tabName .. "_Content",
            Size            = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible         = isFirst,
            ClipsDescendants = true,
        })

        -- Прокручиваемая область элементов
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Name                   = "Scroll"
        scrollFrame.Size                   = UDim2.new(1, 0, 1, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel        = 0
        scrollFrame.ScrollBarThickness     = 3
        scrollFrame.ScrollBarImageColor3   = theme.Accent
        scrollFrame.CanvasSize             = UDim2.new(0, 0, 0, 0)
        scrollFrame.AutomaticCanvasSize    = Enum.AutomaticSize.Y
        scrollFrame.Parent                 = tabContent

        local contentList = Util.ListLayout(scrollFrame, Enum.FillDirection.Vertical, 6)
        Util.Padding(scrollFrame, 12, 12, 12, 12)

        -- Регистрируем вкладку
        local tabEntry = {
            Name    = tabName,
            Button  = tabBtn,
            Content = tabContent,
            Scroll  = scrollFrame,
        }
        table.insert(self._tabs, tabEntry)

        if isFirst then
            self._activeTab = tabEntry
        end

        -- Переключение вкладок
        tabBtn.MouseButton1Click:Connect(function()
            if self._activeTab == tabEntry then return end
            -- Деактивируем текущую
            if self._activeTab then
                local prev = self._activeTab
                Util.TweenFast(prev.Button, {BackgroundColor3 = theme.TabInactive}, 0.35)
                -- Текст
                local prevLabel = prev.Button:FindFirstChildOfClass("TextLabel")
                if prevLabel then
                    Util.TweenFast(prevLabel, {TextColor3 = theme.TabText}, 0.35)
                end
                prev.Content.Visible = false
            end
            -- Активируем новую
            self._activeTab = tabEntry
            tabEntry.Content.Visible = true
            Util.TweenFast(tabBtn, {BackgroundColor3 = theme.TabActive}, 0.35)
            Util.TweenFast(tabLabel, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.35)
        end)

        Util.HoverEffect(tabBtn,
            isFirst and theme.TabActive or theme.TabInactive,
            isFirst and theme.AccentHover or theme.SurfaceHover
        )

        -- ══════════════════════════════════════════
        --  ОБЪЕКТ ВКЛАДКИ
        -- ══════════════════════════════════════════
        local Tab = {}
        Tab._theme     = theme
        Tab._scroll    = scrollFrame
        Tab._tabEntry  = tabEntry

        -- ──────────────────────────────────────────
        --  Внутренний хелпер: создать строку элемента
        -- ──────────────────────────────────────────
        local function makeRow(label, height)
            local row = Util.Frame(scrollFrame, {
                Name            = "Row_" .. (label or "Item"),
                Size            = UDim2.new(1, 0, 0, height or 48),
                BackgroundColor3 = theme.SurfaceElevated,
            })
            Util.Corner(row, 10)
            Util.Stroke(row, theme.Border, 1, 0)
            return row
        end

        local function makeLabel(parent, text, x, y, w, h, font, size, color)
            return Util.Label(parent, {
                Text     = text,
                Font     = font  or Enum.Font.Ubuntu,
                TextSize = size  or 14,
                TextColor3 = color or theme.TextPrimary,
                Size     = UDim2.new(0, w or 200, 0, h or 20),
                Position = UDim2.new(0, x or 14, 0.5, -(h or 20)/2),
            })
        end

        -- ──────────────────────────────────────────
        --  Tab:AddButton(config)
        --  config = { Label, Description?, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddButton(config)
            config = config or {}
            local row = makeRow(config.Label, 48)

            makeLabel(row, config.Label or "Button", 14, nil, 200, 20)

            if config.Description then
                makeLabel(row, config.Description, 14, nil, 200, 16,
                    Enum.Font.Ubuntu, 12, theme.TextSecondary)
            end

            local btn = Util.Button(row, {
                Name            = "ActionBtn",
                Text            = config.Label or "Button",
                Font            = Enum.Font.Ubuntu,
                TextSize        = 13,
                TextColor3      = Color3.fromRGB(255,255,255),
                BackgroundColor3 = theme.Accent,
                Size            = UDim2.new(0, 110, 0, 30),
                Position        = UDim2.new(1, -122, 0.5, -15),
            })
            Util.Corner(btn, 8)
            Util.HoverEffect(btn, theme.Accent, theme.AccentHover)
            Util.ClickEffect(btn)

            btn.MouseButton1Click:Connect(function()
                if config.Callback then
                    local ok, err = pcall(config.Callback)
                    if not ok then warn("[BeeUI] Button Callback error: " .. tostring(err)) end
                end
            end)

            return btn
        end

        -- ──────────────────────────────────────────
        --  Tab:AddToggle(config)
        --  config = { Label, Description?, Default, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddToggle(config)
            config = config or {}
            local value = config.Default == true
            local row   = makeRow(config.Label, 48)

            makeLabel(row, config.Label or "Toggle", 14, nil, 220, 20)

            -- Фон переключателя
            local trackW, trackH = 44, 24
            local track = Util.Frame(row, {
                Name            = "Track",
                Size            = UDim2.new(0, trackW, 0, trackH),
                Position        = UDim2.new(1, -(trackW + 12), 0.5, -trackH/2),
                BackgroundColor3 = value and theme.ToggleOn or theme.ToggleOff,
            })
            Util.Corner(track, trackH/2)

            -- Кружок переключателя
            local knobSize = trackH - 6
            local knob = Util.Frame(track, {
                Name            = "Knob",
                Size            = UDim2.new(0, knobSize, 0, knobSize),
                Position        = UDim2.new(0, value and (trackW - knobSize - 3) or 3, 0.5, -knobSize/2),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            })
            Util.Corner(knob, knobSize/2)

            -- Кликабельная зона
            local clickZone = Util.Button(row, {
                Text            = "",
                BackgroundTransparency = 1,
                Size            = UDim2.new(1, 0, 1, 0),
            })

            clickZone.MouseButton1Click:Connect(function()
                value = not value
                local knobX = value and (trackW - knobSize - 3) or 3
                Util.TweenFast(track, {BackgroundColor3 = value and theme.ToggleOn or theme.ToggleOff}, 0.18)
                Util.TweenFast(knob,  {Position = UDim2.new(0, knobX, 0.5, -knobSize/2)}, 0.18)
                if config.Callback then
                    local ok, err = pcall(config.Callback, value)
                    if not ok then warn("[BeeUI] Toggle Callback error: " .. tostring(err)) end
                end
            end)

            -- API
            local toggleObj = {}
            function toggleObj:Set(v)
                value = v
                local knobX = value and (trackW - knobSize - 3) or 3
                Util.TweenFast(track, {BackgroundColor3 = value and theme.ToggleOn or theme.ToggleOff}, 0.18)
                Util.TweenFast(knob,  {Position = UDim2.new(0, knobX, 0.5, -knobSize/2)}, 0.18)
            end
            function toggleObj:Get() return value end
            return toggleObj
        end

        -- ──────────────────────────────────────────
        --  Tab:AddSlider(config)
        --  config = { Label, Min, Max, Default, Step?, Suffix?, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddSlider(config)
            config = config or {}
            local minVal  = config.Min     or 0
            local maxVal  = config.Max     or 100
            local step    = config.Step    or 1
            local suffix  = config.Suffix  or ""
            local value   = math.clamp(config.Default or minVal, minVal, maxVal)

            local row = makeRow(config.Label, 58)

            makeLabel(row, config.Label or "Slider", 14, nil, 200, 20)

            -- Значение
            local valueLabel = Util.Label(row, {
                Text     = tostring(value) .. suffix,
                Font     = Enum.Font.Ubuntu,
                TextSize = 13,
                TextColor3 = theme.Accent,
                Size     = UDim2.new(0, 80, 0, 20),
                Position = UDim2.new(1, -94, 0, 10),
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            -- Трек
            local trackH = 6
            local track = Util.Frame(row, {
                Size     = UDim2.new(1, -28, 0, trackH),
                Position = UDim2.new(0, 14, 1, -18),
                BackgroundColor3 = theme.SliderTrack,
            })
            Util.Corner(track, trackH/2)

            -- Заполнение
            local fillRatio = (value - minVal) / (maxVal - minVal)
            local fill = Util.Frame(track, {
                Size     = UDim2.new(fillRatio, 0, 1, 0),
                BackgroundColor3 = theme.SliderFill,
            })
            Util.Corner(fill, trackH/2)

            -- Ручка
            local knobS = 16
            local knob = Util.Frame(track, {
                Size     = UDim2.new(0, knobS, 0, knobS),
                Position = UDim2.new(fillRatio, -knobS/2, 0.5, -knobS/2),
                BackgroundColor3 = Color3.fromRGB(255,255,255),
                ZIndex  = 5,
            })
            Util.Corner(knob, knobS/2)
            Util.Stroke(knob, theme.Accent, 2, 0)

            -- Логика перетаскивания
            local draggingSlider = false

            local function updateSlider(inputX)
                local trackPos = track.AbsolutePosition.X
                local trackSz  = track.AbsoluteSize.X
                local ratio    = math.clamp((inputX - trackPos) / trackSz, 0, 1)

                -- Применить step
                local rawVal = minVal + ratio * (maxVal - minVal)
                local snapped = math.round(rawVal / step) * step
                snapped = math.clamp(snapped, minVal, maxVal)
                value = snapped

                local newRatio = (snapped - minVal) / (maxVal - minVal)
                fill.Size = UDim2.new(newRatio, 0, 1, 0)
                knob.Position = UDim2.new(newRatio, -knobS/2, 0.5, -knobS/2)
                valueLabel.Text = tostring(snapped) .. suffix

                if config.Callback then
                    local ok, err = pcall(config.Callback, snapped)
                    if not ok then warn("[BeeUI] Slider Callback error: " .. tostring(err)) end
                end
            end

            track.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    updateSlider(inp.Position.X)
                end
            end)

            UserInputService.InputChanged:Connect(function(inp)
                if draggingSlider and inp.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(inp.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)

            -- API
            local sliderObj = {}
            function sliderObj:Set(v)
                v = math.clamp(v, minVal, maxVal)
                value = v
                local r = (v - minVal) / (maxVal - minVal)
                fill.Size = UDim2.new(r, 0, 1, 0)
                knob.Position = UDim2.new(r, -knobS/2, 0.5, -knobS/2)
                valueLabel.Text = tostring(v) .. suffix
            end
            function sliderObj:Get() return value end
            return sliderObj
        end

        -- ──────────────────────────────────────────
        --  Tab:AddDropdown(config)
        --  config = { Label, Options = {}, Default, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddDropdown(config)
            config = config or {}
            local options = config.Options or {}
            local selected = config.Default or (options[1] or "")
            local isOpen   = false

            local row = makeRow(config.Label, 48)

            makeLabel(row, config.Label or "Dropdown", 14, nil, 200, 20)

            -- Кнопка дропдауна
            local dropBtn = Util.Button(row, {
                Name            = "DropBtn",
                Text            = "",
                BackgroundColor3 = theme.ControlBg,
                Size            = UDim2.new(0, 140, 0, 30),
                Position        = UDim2.new(1, -152, 0.5, -15),
            })
            Util.Corner(dropBtn, 8)
            Util.Stroke(dropBtn, theme.ControlBorder, 1, 0)

            local dropLabel = Util.Label(dropBtn, {
                Text     = selected,
                TextSize = 13,
                TextColor3 = theme.TextPrimary,
                Size     = UDim2.new(1, -30, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
            })

            local arrowLabel = Util.Label(dropBtn, {
                Text     = "▾",
                TextSize = 13,
                TextColor3 = theme.TextSecondary,
                Size     = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -24, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Center,
            })

            -- Список вариантов (в отдельном фрейме)
            local listFrame = Util.Frame(row, {
                Name            = "DropList",
                Size            = UDim2.new(0, 140, 0, math.min(#options, 5) * 32 + 8),
                Position        = UDim2.new(1, -152, 1, 4),
                BackgroundColor3 = theme.SurfaceElevated,
                Visible         = false,
                ZIndex          = 20,
            })
            Util.Corner(listFrame, 8)
            Util.Stroke(listFrame, theme.BorderAccent, 1, 0)
            Util.Padding(listFrame, 4, 4, 4, 4)
            Util.ListLayout(listFrame, Enum.FillDirection.Vertical, 2)

            for _, opt in ipairs(options) do
                local optBtn = Util.Button(listFrame, {
                    Text            = opt,
                    Font            = Enum.Font.Ubuntu,
                    TextSize        = 13,
                    TextColor3      = opt == selected and theme.Accent or theme.TextPrimary,
                    BackgroundColor3 = theme.SurfaceElevated,
                    Size            = UDim2.new(1, 0, 0, 28),
                    TextXAlignment  = Enum.TextXAlignment.Left,
                    ZIndex          = 21,
                })
                Util.Corner(optBtn, 6)
                Util.Padding(optBtn, 0, 0, 0, 8)
                Util.HoverEffect(optBtn, theme.SurfaceElevated, theme.SurfaceHover)

                optBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    dropLabel.Text = opt
                    isOpen = false
                    listFrame.Visible = false
                    Util.TweenFast(arrowLabel, {Rotation = 0}, 0.15)
                    if config.Callback then
                        local ok, err = pcall(config.Callback, opt)
                        if not ok then warn("[BeeUI] Dropdown Callback error: " .. tostring(err)) end
                    end
                end)
            end

            dropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                listFrame.Visible = isOpen
                Util.TweenFast(arrowLabel, {Rotation = isOpen and 180 or 0}, 0.15)
            end)

            local dropObj = {}
            function dropObj:Set(v)
                selected = v
                dropLabel.Text = v
            end
            function dropObj:Get() return selected end
            return dropObj
        end

        -- ──────────────────────────────────────────
        --  Tab:AddInput(config)
        --  config = { Label, Placeholder, Default, Numeric?, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddInput(config)
            config = config or {}
            local row = makeRow(config.Label, 48)

            makeLabel(row, config.Label or "Input", 14, nil, 160, 20)

            local inputBox = Instance.new("TextBox")
            inputBox.Name                   = "InputBox"
            inputBox.Text                   = config.Default or ""
            inputBox.PlaceholderText        = config.Placeholder or "Type here..."
            inputBox.Font                   = Enum.Font.Ubuntu
            inputBox.TextSize               = 13
            inputBox.TextColor3             = theme.TextPrimary
            inputBox.PlaceholderColor3      = theme.TextMuted
            inputBox.BackgroundColor3       = theme.ControlBg
            inputBox.BorderSizePixel        = 0
            inputBox.ClearTextOnFocus       = false
            inputBox.Size                   = UDim2.new(0, 160, 0, 30)
            inputBox.Position               = UDim2.new(1, -172, 0.5, -15)
            inputBox.TextXAlignment         = Enum.TextXAlignment.Left
            inputBox.Parent                 = row
            Util.Corner(inputBox, 8)
            Util.Stroke(inputBox, theme.ControlBorder, 1, 0)
            Util.Padding(inputBox, 0, 0, 0, 10)

            -- Фокус — подсветить рамку
            inputBox.Focused:Connect(function()
                Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"), {Color = theme.Accent}, 0.15)
            end)
            inputBox.FocusLost:Connect(function(enter)
                Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"), {Color = theme.ControlBorder}, 0.15)
                if config.Callback then
                    local ok, err = pcall(config.Callback, inputBox.Text)
                    if not ok then warn("[BeeUI] Input Callback error: " .. tostring(err)) end
                end
            end)

            local inputObj = {}
            function inputObj:Set(v) inputBox.Text = tostring(v) end
            function inputObj:Get() return inputBox.Text end
            return inputObj
        end

        -- ──────────────────────────────────────────
        --  Tab:AddLabel(text)
        -- ──────────────────────────────────────────
        function Tab:AddLabel(text)
            local row = makeRow("Label_" .. (text or ""), 36)
            row.BackgroundTransparency = 1
            row:FindFirstChildOfClass("UIStroke"):Destroy()

            Util.Label(row, {
                Text     = text or "",
                Font     = Enum.Font.Ubuntu,
                TextSize = 13,
                TextColor3 = theme.TextSecondary,
                Size     = UDim2.new(1, -28, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                TextWrapped = true,
            })
        end

        -- ──────────────────────────────────────────
        --  Tab:AddSeparator()
        -- ──────────────────────────────────────────
        function Tab:AddSeparator()
            local sep = Util.Frame(scrollFrame, {
                Name            = "Separator",
                Size            = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = theme.Border,
            })
        end

        -- ──────────────────────────────────────────
        --  Tab:AddSection(title)
        -- ──────────────────────────────────────────
        function Tab:AddSection(title)
            local holder = Util.Frame(scrollFrame, {
                Name            = "Section_" .. (title or ""),
                Size            = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
            })

            -- Линия
            Util.Frame(holder, {
                Size     = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = theme.Border,
            })

            -- Бейдж с заголовком
            local badge = Util.Frame(holder, {
                Size     = UDim2.new(0, 0, 0, 22),
                Position = UDim2.new(0, 10, 0.5, -11),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = theme.SurfaceHover,
            })
            Util.Corner(badge, 6)
            Util.Padding(badge, 0, 10, 0, 10)

            Util.Label(badge, {
                Text     = title or "Section",
                Font     = Enum.Font.Ubuntu,
                TextSize = 11,
                TextColor3 = theme.Accent,
                Size     = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
            })
        end

        -- ──────────────────────────────────────────
        --  Tab:AddColorPicker(config)
        --  config = { Label, Default = Color3, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddColorPicker(config)
            config = config or {}
            local color = config.Default or Color3.fromRGB(255, 100, 50)

            local row = makeRow(config.Label, 48)
            makeLabel(row, config.Label or "Color", 14, nil, 200, 20)

            -- Превью цвета
            local preview = Util.Frame(row, {
                Name            = "ColorPreview",
                Size            = UDim2.new(0, 36, 0, 28),
                Position        = UDim2.new(1, -48, 0.5, -14),
                BackgroundColor3 = color,
            })
            Util.Corner(preview, 8)
            Util.Stroke(preview, theme.Border, 1, 0)

            -- Заглушка: в реальной реализации открывалось бы HSV колёсо
            -- Для полноты — простейший пикер через Input
            local clickZone = Util.Button(row, {
                Text     = "",
                BackgroundTransparency = 1,
                Size     = UDim2.new(1, 0, 1, 0),
            })
            clickZone.MouseButton1Click:Connect(function()
                -- Симулируем случайный цвет (в продакшене — открыть ColorWheel)
                color = Color3.fromHSV(math.random(), 0.8, 1)
                preview.BackgroundColor3 = color
                if config.Callback then pcall(config.Callback, color) end
            end)

            local cpObj = {}
            function cpObj:Set(c)
                color = c
                preview.BackgroundColor3 = c
            end
            function cpObj:Get() return color end
            return cpObj
        end

        -- ──────────────────────────────────────────
        --  Tab:AddKeybind(config)
        --  config = { Label, Default = Enum.KeyCode, Callback }
        -- ──────────────────────────────────────────
        function Tab:AddKeybind(config)
            config = config or {}
            local key     = config.Default or Enum.KeyCode.F
            local listening = false

            local row = makeRow(config.Label, 48)
            makeLabel(row, config.Label or "Keybind", 14, nil, 200, 20)

            local kbBtn = Util.Button(row, {
                Text            = "[" .. key.Name .. "]",
                Font            = Enum.Font.Ubuntu,
                TextSize        = 13,
                TextColor3      = theme.Accent,
                BackgroundColor3 = theme.ControlBg,
                Size            = UDim2.new(0, 110, 0, 30),
                Position        = UDim2.new(1, -122, 0.5, -15),
            })
            Util.Corner(kbBtn, 8)
            Util.Stroke(kbBtn, theme.ControlBorder, 1, 0)

            kbBtn.MouseButton1Click:Connect(function()
                listening = true
                kbBtn.Text = "[...]"
                kbBtn.TextColor3 = theme.Warning
            end)

            UserInputService.InputBegan:Connect(function(inp, gp)
                if gp then return end
                if listening and inp.UserInputType == Enum.UserInputType.Keyboard then
                    key = inp.KeyCode
                    kbBtn.Text = "[" .. key.Name .. "]"
                    kbBtn.TextColor3 = theme.Accent
                    listening = false
                    if config.Callback then pcall(config.Callback, key) end
                end
            end)

            local kbObj = {}
            function kbObj:Get() return key end
            return kbObj
        end

        return Tab
    end

    return Window
end

-- ══════════════════════════════════════════
--  BeeUI:Notify(config)
--  config = { Title, Message, Type?, Duration? }
--  Type: "info"|"success"|"warning"|"error"
-- ══════════════════════════════════════════
function BeeUI:Notify(config)
    config = config or {}
    local theme    = self._activeTheme or self.Themes.Dark
    local holder   = self._notifyHolder
    if not holder then return end

    local typeColors = {
        info    = theme.Info,
        success = theme.Success,
        warning = theme.Warning,
        error   = theme.Error,
    }
    local accentColor = typeColors[config.Type or "info"] or theme.Accent
    local duration    = config.Duration or 4

    -- Контейнер уведомления
    local notify = Util.Frame(holder, {
        Name            = "Notify_" .. tostring(tick()),
        Size            = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = theme.NotifyBg,
        ClipsDescendants = true,
        BackgroundTransparency = 0,
        LayoutOrder     = self._notifyCount,
    })
    self._notifyCount = self._notifyCount + 1
    Util.Corner(notify, 12)
    Util.Stroke(notify, theme.NotifyBorder, 1, 0)

    -- Цветная полоска слева
    local accent = Util.Frame(notify, {
        Size     = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = accentColor,
    })
    Util.Corner(accent, 3)

    -- Иконка типа
    local icons = { info="ℹ", success="✓", warning="⚠", error="✕" }
    local iconLabel = Util.Label(notify, {
        Text     = icons[config.Type or "info"] or "ℹ",
        Font     = Enum.Font.Ubuntu,
        TextSize = 16,
        TextColor3 = accentColor,
        Size     = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, 14, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Center,
    })

    -- Заголовок
    local titleLabel = Util.Label(notify, {
        Text     = config.Title or "Notification",
        Font     = Enum.Font.Ubuntu,
        TextSize = 14,
        TextColor3 = theme.TextPrimary,
        Size     = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 46, 0, 12),
    })

    -- Сообщение
    local msgLabel = Util.Label(notify, {
        Text     = config.Message or "",
        Font     = Enum.Font.Ubuntu,
        TextSize = 12,
        TextColor3 = theme.TextSecondary,
        Size     = UDim2.new(1, -60, 0, 36),
        Position = UDim2.new(0, 46, 0, 30),
        TextWrapped = true,
    })

    -- Прогресс-бар
    local progressTrack = Util.Frame(notify, {
        Size     = UDim2.new(1, -8, 0, 2),
        Position = UDim2.new(0, 4, 1, -6),
        BackgroundColor3 = theme.Border,
    })
    Util.Corner(progressTrack, 1)

    local progressFill = Util.Frame(progressTrack, {
        Size     = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = accentColor,
    })
    Util.Corner(progressFill, 1)

    -- Анимация появления
    Util.Tween(notify, {Time = 0.45, Ease = Enum.EasingStyle.Back, Dir = Enum.EasingDirection.Out}, {
        Size = UDim2.new(1, 0, 0, 76),
    })

    -- Прогресс
    Util.Tween(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0)
    })

    -- Закрытие
    task.delay(duration, function()
        Util.TweenFast(notify, {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
        }, 0.35)
        task.delay(0.3, function()
            notify:Destroy()
        end)
    end)

    return notify
end

-- ══════════════════════════════════════════
--  BeeUI:GetTheme()
-- ══════════════════════════════════════════
function BeeUI:GetTheme()
    return self._activeTheme
end

-- ══════════════════════════════════════════
--  ВОЗВРАТ БИБЛИОТЕКИ
-- ══════════════════════════════════════════
return BeeUI
