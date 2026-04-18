--[[
╔═══════════════════════════════════════════════════════════════════╗
║                         BeeUI v1.6                                ║
║                   Roblox GUI Library by Me                        ║
║                                                                   ║
║  CHANGES v1.6:                                                     ║
║  • Text Color section in Settings with presets                    ║
║  • Background color now propagates to ALL surface elements:       ║
║    tabSidebar, settingsBtnHolder, titleBar, rows, sections        ║
║  • Accent color now updates fills, knobs, scrollbars, strokes     ║
║  • Tab buttons, rows, dropdowns update on background change       ║
║  • Window tracks all "surface" elements for live recolor          ║
╚═══════════════════════════════════════════════════════════════════╝
]]

local BeeUI = {}
BeeUI.__index = BeeUI

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local HttpService      = game:GetService("HttpService")
local TextService      = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

local AvailableFonts = {
    { Name = "Ubuntu",          Font = Enum.Font.Ubuntu          },
    { Name = "GothamBold",      Font = Enum.Font.GothamBold      },
    { Name = "Gotham",          Font = Enum.Font.Gotham          },
    { Name = "GothamMedium",    Font = Enum.Font.GothamMedium    },
    { Name = "SourceSans",      Font = Enum.Font.SourceSans      },
    { Name = "SourceSansBold",  Font = Enum.Font.SourceSansBold  },
    { Name = "SourceSansLight", Font = Enum.Font.SourceSansLight },
    { Name = "RobotoMono",      Font = Enum.Font.RobotoMono      },
    { Name = "Code",            Font = Enum.Font.Code            },
    { Name = "Cartoon",         Font = Enum.Font.Cartoon         },
    { Name = "Fantasy",         Font = Enum.Font.Fantasy         },
    { Name = "Arcade",          Font = Enum.Font.Arcade          },
    { Name = "Bangers",         Font = Enum.Font.Bangers         },
    { Name = "Creepster",       Font = Enum.Font.Creepster       },
    { Name = "DenkOne",         Font = Enum.Font.DenkOne         },
    { Name = "Fondamento",      Font = Enum.Font.Fondamento      },
    { Name = "FredokaOne",      Font = Enum.Font.FredokaOne      },
    { Name = "Michroma",        Font = Enum.Font.Michroma        },
    { Name = "Nunito",          Font = Enum.Font.Nunito          },
    { Name = "Oswald",          Font = Enum.Font.Oswald          },
    { Name = "PatrickHand",     Font = Enum.Font.PatrickHand     },
    { Name = "PermanentMarker", Font = Enum.Font.PermanentMarker },
    { Name = "Sarpanch",        Font = Enum.Font.Sarpanch        },
    { Name = "SpecialElite",    Font = Enum.Font.SpecialElite    },
    { Name = "TitilliumWeb",    Font = Enum.Font.TitilliumWeb    },
}
do
    local seen, cleaned = {}, {}
    for _, f in ipairs(AvailableFonts) do
        if not seen[f.Name] then seen[f.Name] = true; table.insert(cleaned, f) end
    end
    AvailableFonts = cleaned
end

local BackgroundPresets = {
    { Name = "Dark Honey",  Color = Color3.fromRGB(28,  18,  6  ) },
    { Name = "Night",       Color = Color3.fromRGB(10,  10,  18 ) },
    { Name = "Dark Gray",   Color = Color3.fromRGB(20,  20,  25 ) },
    { Name = "Midnight",    Color = Color3.fromRGB(15,  12,  30 ) },
    { Name = "Forest",      Color = Color3.fromRGB(10,  22,  15 ) },
    { Name = "Black",       Color = Color3.fromRGB(5,   5,   8  ) },
    { Name = "Light",       Color = Color3.fromRGB(248, 248, 252) },
    { Name = "White",       Color = Color3.fromRGB(255, 255, 255) },
    { Name = "Sky",         Color = Color3.fromRGB(220, 235, 255) },
    { Name = "Mint",        Color = Color3.fromRGB(210, 245, 230) },
    { Name = "Pink",        Color = Color3.fromRGB(255, 220, 235) },
    { Name = "Yellow",      Color = Color3.fromRGB(255, 245, 200) },
    { Name = "Purple",      Color = Color3.fromRGB(30,  15,  50 ) },
    { Name = "Blue Storm",  Color = Color3.fromRGB(12,  18,  40 ) },
    { Name = "Ruby",        Color = Color3.fromRGB(35,  8,   12 ) },
}

-- Text color presets
local TextColorPresets = {
    { Name = "White",       Color = Color3.fromRGB(240, 240, 245) },
    { Name = "Soft White",  Color = Color3.fromRGB(200, 200, 210) },
    { Name = "Cream",       Color = Color3.fromRGB(255, 240, 210) },
    { Name = "Gold",        Color = Color3.fromRGB(255, 215, 120) },
    { Name = "Sky Blue",    Color = Color3.fromRGB(180, 210, 255) },
    { Name = "Mint",        Color = Color3.fromRGB(160, 240, 200) },
    { Name = "Lavender",    Color = Color3.fromRGB(210, 190, 255) },
    { Name = "Rose",        Color = Color3.fromRGB(255, 190, 200) },
    { Name = "Dark",        Color = Color3.fromRGB(15,  15,  25 ) },
    { Name = "Charcoal",    Color = Color3.fromRGB(50,  50,  65 ) },
    { Name = "Gray",        Color = Color3.fromRGB(120, 120, 140) },
    { Name = "Dark Brown",  Color = Color3.fromRGB(80,  55,  30 ) },
}

local LucideFallback = {
    ["home"]            = "⌂",  ["settings"]        = "⚙",
    ["menu"]            = "≡",  ["search"]          = "🔍",
    ["bell"]            = "🔔", ["user"]            = "👤",
    ["users"]           = "👥", ["star"]            = "★",
    ["heart"]           = "♥",  ["bookmark"]        = "🔖",
    ["plus"]            = "+",  ["minus"]           = "−",
    ["x"]               = "✕",  ["check"]           = "✓",
    ["edit"]            = "✏",  ["trash"]           = "🗑",
    ["copy"]            = "⧉",  ["download"]        = "↓",
    ["upload"]          = "↑",  ["refresh-cw"]      = "↻",
    ["rotate-ccw"]      = "↺",  ["shield"]          = "🛡",
    ["lock"]            = "🔒", ["unlock"]          = "🔓",
    ["eye"]             = "👁",  ["eye-off"]         = "🚫",
    ["alert-circle"]    = "⚠",  ["info"]            = "ℹ",
    ["zap"]             = "⚡",  ["flame"]           = "🔥",
    ["play"]            = "▶",  ["pause"]           = "⏸",
    ["stop-circle"]     = "⏹",  ["volume-2"]        = "🔊",
    ["volume-x"]        = "🔇", ["folder"]          = "📁",
    ["file"]            = "📄", ["image"]           = "🖼",
    ["code"]            = "</>",["arrow-up"]        = "↑",
    ["arrow-down"]      = "↓",  ["arrow-left"]      = "←",
    ["arrow-right"]     = "→",  ["chevron-up"]      = "⌃",
    ["chevron-down"]    = "⌄",  ["globe"]           = "🌐",
    ["map-pin"]         = "📍", ["clock"]           = "🕐",
    ["calendar"]        = "📅", ["cpu"]             = "💾",
    ["database"]        = "🗃", ["wifi"]            = "📶",
    ["battery"]         = "🔋", ["sun"]             = "☀",
    ["moon"]            = "☽",  ["cloud"]           = "☁",
    ["wind"]            = "💨", ["layers"]          = "⊞",
    ["layout"]          = "⊟",  ["grid"]            = "⊞",
    ["list"]            = "≣",  ["tag"]             = "🏷",
    ["hash"]            = "#",  ["at-sign"]         = "@",
    ["percent"]         = "%",  ["sliders"]         = "⊟",
    ["tool"]            = "🔧", ["wrench"]          = "🔧",
    ["sword"]           = "⚔",  ["shield-check"]    = "🛡",
    ["package"]         = "📦", ["box"]             = "📦",
    ["gift"]            = "🎁", ["trophy"]          = "🏆",
    ["target"]          = "🎯", ["crosshair"]       = "✛",
    ["compass"]         = "🧭", ["map"]             = "🗺",
    ["flag"]            = "🚩", ["send"]            = "➤",
    ["mail"]            = "✉",  ["message-circle"]  = "💬",
    ["message-square"]  = "💬", ["phone"]           = "📞",
    ["video"]           = "📹", ["camera"]          = "📷",
    ["mic"]             = "🎤", ["music"]           = "🎵",
    ["headphones"]      = "🎧", ["gamepad"]         = "🎮",
    ["terminal"]        = "⌨",  ["monitor"]         = "🖥",
    ["smartphone"]      = "📱", ["tablet"]          = "📱",
    ["printer"]         = "🖨", ["mouse-pointer"]   = "🖱",
    ["key"]             = "🔑", ["link"]            = "🔗",
    ["external-link"]   = "↗",  ["maximize"]        = "⛶",
    ["minimize"]        = "⛶",  ["chevron-left"]    = "‹",
    ["chevron-right"]   = "›",  ["more-horizontal"] = "···",
    ["more-vertical"]   = "⋮",  ["log-in"]          = "→",
    ["log-out"]         = "←",  ["power"]           = "⏻",
    ["activity"]        = "📈", ["trending-up"]     = "📈",
    ["trending-down"]   = "📉", ["bar-chart"]       = "📊",
    ["pie-chart"]       = "🥧", ["dollar-sign"]     = "$",
    ["credit-card"]     = "💳", ["shopping-cart"]   = "🛒",
    ["shopping-bag"]    = "🛍",
}

local function getLucideChar(iconName)
    return LucideFallback[iconName] or "•"
end

local function parseIcon(iconStr)
    if not iconStr then return nil end
    if iconStr:sub(1,7) == "lucide:" then return { type="lucide", name=iconStr:sub(8) } end
    return { type="asset", id=iconStr }
end

-- ══════════════════════════════════════════
--  Derive surface/elevated colors from a base background
-- ══════════════════════════════════════════
local function deriveColors(bgColor)
    local r, g, b = bgColor.R, bgColor.G, bgColor.B
    local brightness = 0.299*r + 0.587*g + 0.114*b
    local isDark = brightness < 0.5
    local lift1 = isDark and 0.06 or -0.04   -- Surface
    local lift2 = isDark and 0.12 or -0.08   -- SurfaceElevated
    local lift3 = isDark and 0.18 or -0.12   -- SurfaceHover
    local brd   = isDark and 0.08 or -0.06   -- Border

    local function shift(v, d)
        return math.clamp(v + d, 0, 1)
    end
    return {
        Surface         = Color3.new(shift(r,lift1), shift(g,lift1), shift(b,lift1)),
        SurfaceElevated = Color3.new(shift(r,lift2), shift(g,lift2), shift(b,lift2)),
        SurfaceHover    = Color3.new(shift(r,lift3), shift(g,lift3), shift(b,lift3)),
        Border          = Color3.new(shift(r,brd),   shift(g,brd),   shift(b,brd)),
        TitleBarBg      = Color3.new(math.clamp(r-0.04,0,1), math.clamp(g-0.04,0,1), math.clamp(b-0.04,0,1)),
        ControlBg       = Color3.new(shift(r,lift1*1.2), shift(g,lift1*1.2), shift(b,lift1*1.2)),
        SliderTrack     = Color3.new(shift(r,lift2*0.8), shift(g,lift2*0.8), shift(b,lift2*0.8)),
        TabInactive     = Color3.new(shift(r,lift1), shift(g,lift1), shift(b,lift1)),
    }
end

-- ══════════════════════════════════════════
--  THEMES
-- ══════════════════════════════════════════
BeeUI.Themes = {
    Dark = {
        Background        = Color3.fromRGB(28,  18,  6  ),
        Surface           = Color3.fromRGB(38,  25,  8  ),
        SurfaceElevated   = Color3.fromRGB(50,  33,  10 ),
        SurfaceHover      = Color3.fromRGB(65,  44,  14 ),
        TextPrimary       = Color3.fromRGB(240, 240, 245),
        TextSecondary     = Color3.fromRGB(140, 140, 160),
        TextMuted         = Color3.fromRGB(80,  80,  100),
        Accent            = Color3.fromRGB(255, 180, 30 ),
        AccentHover       = Color3.fromRGB(255, 200, 70 ),
        AccentSoft        = Color3.fromRGB(255, 180, 30 ),
        AccentGlow        = Color3.fromRGB(255, 210, 80 ),
        Border            = Color3.fromRGB(80,  55,  18 ),
        BorderAccent      = Color3.fromRGB(180, 130, 30 ),
        Success           = Color3.fromRGB(52,  211, 153),
        Warning           = Color3.fromRGB(251, 191, 36 ),
        Error             = Color3.fromRGB(239, 68,  68 ),
        Info              = Color3.fromRGB(96,  165, 250),
        ControlBg         = Color3.fromRGB(55,  36,  12 ),
        ControlBorder     = Color3.fromRGB(100, 68,  20 ),
        SliderTrack       = Color3.fromRGB(70,  46,  14 ),
        SliderFill        = Color3.fromRGB(255, 180, 30 ),
        ToggleOff         = Color3.fromRGB(80,  55,  18 ),
        ToggleOn          = Color3.fromRGB(255, 180, 30 ),
        TabActive         = Color3.fromRGB(210, 145, 20 ),
        TabInactive       = Color3.fromRGB(44,  29,  9  ),
        TabText           = Color3.fromRGB(200, 165, 90 ),
        TitleBarBg        = Color3.fromRGB(22,  14,  4  ),
        TitleText         = Color3.fromRGB(255, 255, 255),
        SubTitleText      = Color3.fromRGB(180, 140, 60 ),
        CloseBtn          = Color3.fromRGB(239, 68,  68 ),
        MinBtn            = Color3.fromRGB(251, 191, 36 ),
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
--  UTILITIES
-- ══════════════════════════════════════════
local Util = {}

function Util.Tween(obj, info, props)
    local ti = typeof(info) == "TweenInfo" and info or TweenInfo.new(
        info.Time or 0.35, info.Ease or Enum.EasingStyle.Sine, info.Dir or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, ti, props); t:Play(); return t
end
function Util.TweenFast(obj, props, t) return Util.Tween(obj, {Time=t or 0.25}, props) end

function Util.Corner(parent, radius)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, radius or 8); c.Parent = parent; return c
end
function Util.Padding(parent, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop=UDim.new(0,top or 0); p.PaddingRight=UDim.new(0,right or 0)
    p.PaddingBottom=UDim.new(0,bottom or 0); p.PaddingLeft=UDim.new(0,left or 0)
    p.Parent=parent; return p
end
function Util.Stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color=color or Color3.new(1,1,1); s.Thickness=thickness or 1
    s.Transparency=transparency or 0; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    s.Parent=parent; return s
end
function Util.ListLayout(parent, dir, padding, align)
    local l = Instance.new("UIListLayout")
    l.FillDirection=dir or Enum.FillDirection.Vertical; l.Padding=UDim.new(0,padding or 6)
    l.HorizontalAlignment=align or Enum.HorizontalAlignment.Left
    l.SortOrder=Enum.SortOrder.LayoutOrder; l.Parent=parent; return l
end
function Util.Frame(parent, props)
    local f = Instance.new("Frame"); f.BorderSizePixel=0
    for k,v in pairs(props or {}) do f[k]=v end; f.Parent=parent; return f
end
function Util.Label(parent, props)
    local l = Instance.new("TextLabel"); l.BorderSizePixel=0; l.BackgroundTransparency=1
    l.Font=Enum.Font.Ubuntu; l.TextSize=14; l.TextXAlignment=Enum.TextXAlignment.Left
    for k,v in pairs(props or {}) do l[k]=v end; l.Parent=parent; return l
end
function Util.Button(parent, props)
    local b = Instance.new("TextButton"); b.BorderSizePixel=0
    b.Font=Enum.Font.Ubuntu; b.TextSize=14; b.AutoButtonColor=false
    for k,v in pairs(props or {}) do b[k]=v end; b.Parent=parent; return b
end
function Util.Image(parent, props)
    local i = Instance.new("ImageLabel"); i.BackgroundTransparency=1; i.BorderSizePixel=0
    for k,v in pairs(props or {}) do i[k]=v end; i.Parent=parent; return i
end
function Util.TruncateText(text, font, textSize, maxWidth)
    if not text or text=="" then return text end
    local fullSize = TextService:GetTextSize(text, textSize, font, Vector2.new(9999,9999))
    if fullSize.X <= maxWidth then return text end
    local dotsSize = TextService:GetTextSize("...", textSize, font, Vector2.new(9999,9999))
    local available = maxWidth - dotsSize.X
    local lo, hi, result = 1, #text, ""
    while lo <= hi do
        local mid = math.floor((lo+hi)/2)
        local sub = text:sub(1,mid)
        local sz = TextService:GetTextSize(sub, textSize, font, Vector2.new(9999,9999))
        if sz.X <= available then result=sub; lo=mid+1 else hi=mid-1 end
    end
    return result.."..."
end
function Util.MakeDraggable(frame, handle)
    local dragging, dragStart, startPos = false, nil, nil
    handle = handle or frame
    handle.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true; dragStart=input.Position; startPos=frame.Position
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
        end
    end)
end
function Util.HoverEffect(btn, normalColor, hoverColor, speed)
    speed=speed or 0.22
    btn.MouseEnter:Connect(function() Util.TweenFast(btn,{BackgroundColor3=hoverColor},speed) end)
    btn.MouseLeave:Connect(function() Util.TweenFast(btn,{BackgroundColor3=normalColor},speed) end)
end
function Util.ClickEffect(btn)
    btn.MouseButton1Down:Connect(function()
        Util.TweenFast(btn,{Size=UDim2.new(btn.Size.X.Scale,btn.Size.X.Offset-2,btn.Size.Y.Scale,btn.Size.Y.Offset-2)},0.08)
    end)
    btn.MouseButton1Up:Connect(function()
        Util.TweenFast(btn,{Size=UDim2.new(btn.Size.X.Scale,btn.Size.X.Offset+2,btn.Size.Y.Scale,btn.Size.Y.Offset+2)},0.1)
    end)
end

-- ══════════════════════════════════════════
--  Apply transparency to ALL descendants
-- ══════════════════════════════════════════
local _origTransparencies = nil

local function applyWindowTransparency(windowFrame, alpha)
    if not _origTransparencies then
        _origTransparencies = {}
        local function collect(obj)
            for _, child in ipairs(obj:GetChildren()) do
                if child.Name == "DropdownOverlay" or child.Name == "NotifyHolder" then
                    continue
                end
                if child:IsA("Frame") or child:IsA("ScrollingFrame") then
                    _origTransparencies[child] = child.BackgroundTransparency
                elseif child:IsA("UIStroke") then
                    _origTransparencies[child] = child.Transparency
                end
                collect(child)
            end
        end
        _origTransparencies[windowFrame] = windowFrame.BackgroundTransparency
        collect(windowFrame)
    end

    for obj, origAlpha in pairs(_origTransparencies) do
        if not obj or not obj.Parent then continue end
        local newAlpha = origAlpha + (1 - origAlpha) * alpha
        pcall(function()
            if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                obj.BackgroundTransparency = newAlpha
            elseif obj:IsA("UIStroke") then
                obj.Transparency = newAlpha
            end
        end)
    end
end

-- ══════════════════════════════════════════
--  MAIN
-- ══════════════════════════════════════════
BeeUI._activeTheme     = nil
BeeUI._screenGui       = nil
BeeUI._notifyHolder    = nil
BeeUI._notifyCount     = 0
BeeUI._dropdownOverlay = nil

function BeeUI:CreateWindow(config)
    config = config or {}
    local themeName = config.Theme or "Dark"
    local theme = self.Themes[themeName] or self.Themes.Dark
    self._activeTheme = theme

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name="BeeUI"; screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn=false; screenGui.DisplayOrder=999
    local ok = pcall(function() screenGui.Parent=CoreGui end)
    if not ok then screenGui.Parent=LocalPlayer:WaitForChild("PlayerGui") end
    self._screenGui = screenGui

    local dropOverlay = Util.Frame(screenGui, {
        Name="DropdownOverlay", Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1, ZIndex=500,
    })
    self._dropdownOverlay = dropOverlay

    local notifyHolder = Util.Frame(screenGui, {
        Name="NotifyHolder", BackgroundTransparency=1,
        Size=UDim2.new(0,320,1,0), Position=UDim2.new(1,-330,0,0),
    })
    Util.ListLayout(notifyHolder,Enum.FillDirection.Vertical,8)
    Util.Padding(notifyHolder,16,0,0,0)
    self._notifyHolder = notifyHolder

    local winSize = config.Size or UDim2.new(0,580,0,460)
    local winPos  = config.Position or UDim2.new(0.5,-290,0.5,-230)

    local windowFrame = Util.Frame(screenGui, {
        Name="BeeWindow", Size=winSize, Position=winPos,
        BackgroundColor3=theme.Background, ClipsDescendants=true,
    })
    Util.Corner(windowFrame,14)
    Util.Stroke(windowFrame, theme.Border, 1, 0)

    local accentLine = Util.Frame(windowFrame, {
        Name="AccentLine", Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,0,0),
        BackgroundColor3=theme.Accent,
    })

    local titleBar = Util.Frame(windowFrame, {
        Name="TitleBar", Size=UDim2.new(1,0,0,52), Position=UDim2.new(0,0,0,2),
        BackgroundColor3=theme.TitleBarBg,
    })
    Util.Padding(titleBar,0,14,0,14)

    local titleDivider = Util.Frame(windowFrame, {
        Name="TitleDivider", Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,0,54),
        BackgroundColor3=theme.Border,
    })

    local logoOffset = 0
    if config.Logo then
        Util.Image(titleBar,{Image=config.Logo,Size=UDim2.new(0,28,0,28),Position=UDim2.new(0,0,0.5,-14)})
        logoOffset=36
    end

    local titleLabel = Util.Label(titleBar, {
        Name="Title", Text=config.Title or "BeeUI", Font=Enum.Font.Ubuntu,
        TextSize=16, TextColor3=theme.TitleText,
        Size=UDim2.new(1,-160,0,20), Position=UDim2.new(0,logoOffset,0,8),
    })
    local subTitleLabel = Util.Label(titleBar, {
        Name="SubTitle", Text=config.SubTitle or "", Font=Enum.Font.Ubuntu,
        TextSize=12, TextColor3=theme.SubTitleText,
        Size=UDim2.new(1,-160,0,16), Position=UDim2.new(0,logoOffset,0,28),
    })

    local btnClose = Util.Button(titleBar, {
        Name="CloseBtn", Text="X", Font=Enum.Font.GothamBold,
        TextSize=13, TextColor3=Color3.fromRGB(255,255,255),
        BackgroundColor3=theme.CloseBtn, Size=UDim2.new(0,28,0,28),
        Position=UDim2.new(1,-28,0.5,-14),
    })
    Util.Corner(btnClose,7)

    local btnMin = Util.Button(titleBar, {
        Name="MinBtn", Text="−", Font=Enum.Font.Ubuntu,
        TextSize=18, TextColor3=Color3.fromRGB(30,20,0),
        BackgroundColor3=theme.MinBtn, Size=UDim2.new(0,28,0,28),
        Position=UDim2.new(1,-62,0.5,-14),
    })
    Util.Corner(btnMin,7)

    Util.HoverEffect(btnClose,theme.CloseBtn,Color3.fromRGB(220,30,30))
    Util.HoverEffect(btnMin,theme.MinBtn,Color3.fromRGB(220,160,10))
    Util.ClickEffect(btnClose); Util.ClickEffect(btnMin)

    local bodyFrame = Util.Frame(windowFrame, {
        Name="Body", Size=UDim2.new(1,0,1,-55), Position=UDim2.new(0,0,0,55),
        BackgroundTransparency=1,
    })

    local tabSidebar = Util.Frame(bodyFrame, {
        Name="TabSidebar", Size=UDim2.new(0,140,1,0), BackgroundColor3=theme.Surface,
        ClipsDescendants=true,
    })

    local tabTopScroll = Instance.new("ScrollingFrame")
    tabTopScroll.Name="TabTopScroll"; tabTopScroll.Size=UDim2.new(1,0,1,-46)
    tabTopScroll.Position=UDim2.new(0,0,0,0); tabTopScroll.BackgroundTransparency=1
    tabTopScroll.BorderSizePixel=0; tabTopScroll.ScrollBarThickness=2
    tabTopScroll.ScrollBarImageColor3=theme.Accent; tabTopScroll.CanvasSize=UDim2.new(0,0,0,0)
    tabTopScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; tabTopScroll.Parent=tabSidebar
    Util.Padding(tabTopScroll,10,8,4,8); Util.ListLayout(tabTopScroll,Enum.FillDirection.Vertical,4)

    local settingsDivider = Util.Frame(tabSidebar,{Name="SettingsDivider",Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-47),BackgroundColor3=theme.Border})

    local settingsBtnHolder = Util.Frame(tabSidebar,{Name="SettingsBtnHolder",Size=UDim2.new(1,0,0,46),Position=UDim2.new(0,0,1,-46),BackgroundColor3=theme.Surface})
    Util.Padding(settingsBtnHolder,4,8,6,8)

    local sidebarDivider = Util.Frame(bodyFrame,{Name="SidebarDivider",Size=UDim2.new(0,1,1,0),Position=UDim2.new(0,140,0,0),BackgroundColor3=theme.Border})

    local contentArea = Util.Frame(bodyFrame,{Name="ContentArea",Size=UDim2.new(1,-141,1,0),Position=UDim2.new(0,141,0,0),BackgroundTransparency=1,ClipsDescendants=true})

    Util.MakeDraggable(windowFrame,titleBar)

    windowFrame.Size=UDim2.new(winSize.X.Scale,winSize.X.Offset,winSize.Y.Scale,0)
    windowFrame.BackgroundTransparency=1
    Util.Tween(windowFrame,{Time=0.5,Ease=Enum.EasingStyle.Back,Dir=Enum.EasingDirection.Out},{Size=winSize,BackgroundTransparency=0})

    local minimized=false; local fullSize=winSize
    btnMin.MouseButton1Click:Connect(function()
        minimized=not minimized
        if minimized then
            Util.Tween(windowFrame,{Time=0.35,Ease=Enum.EasingStyle.Sine},{Size=UDim2.new(winSize.X.Scale,winSize.X.Offset,0,52)})
            bodyFrame.Visible=false
        else
            bodyFrame.Visible=true
            Util.Tween(windowFrame,{Time=0.4,Ease=Enum.EasingStyle.Back,Dir=Enum.EasingDirection.Out},{Size=fullSize})
        end
    end)
    btnClose.MouseButton1Click:Connect(function()
        Util.Tween(windowFrame,{Time=0.3,Ease=Enum.EasingStyle.Sine},{Size=UDim2.new(winSize.X.Scale,winSize.X.Offset,0,0),BackgroundTransparency=1})
        task.delay(0.25,function() screenGui:Destroy() end)
    end)

    -- ══════════════════════════════════════════
    --  WINDOW OBJECT
    -- ══════════════════════════════════════════
    local Window = {}
    Window._theme             = theme
    Window._tabs              = {}
    Window._activeTab         = nil
    Window._tabTopScroll      = tabTopScroll
    Window._settingsBtnHolder = settingsBtnHolder
    Window._contentArea       = contentArea
    Window._dropOverlay       = dropOverlay
    Window._windowFrame       = windowFrame
    Window._screenGui         = screenGui
    Window._currentFont       = Enum.Font.Ubuntu
    Window._fontTargets       = {}   -- labels/buttons that follow the font picker
    Window._settingsTabEntry  = nil
    Window._titleLabel        = titleLabel
    Window._subTitleLabel     = subTitleLabel

    -- ── Surface element registries for live recolor ─────────────────
    -- Each entry: { obj=Instance, role="Surface"|"SurfaceElevated"|... }
    Window._surfaceElements   = {}
    -- Text elements that follow the text color picker
    -- Each entry: { obj=Instance, role="primary"|"secondary"|"muted"|"accent"|"tab" }
    Window._textElements      = {}

    -- Register helpers
    local function regSurface(obj, role)
        table.insert(Window._surfaceElements, { obj=obj, role=role })
        return obj
    end
    local function regText(obj, role)
        table.insert(Window._textElements, { obj=obj, role=role })
        return obj
    end

    -- Register base structural elements
    regSurface(tabSidebar,       "Surface")
    regSurface(settingsBtnHolder,"Surface")
    regSurface(titleBar,         "TitleBarBg")
    regSurface(settingsDivider,  "Border")
    regSurface(sidebarDivider,   "Border")
    regSurface(titleDivider,     "Border")
    regSurface(windowFrame,      "Background")

    regText(titleLabel,    "TitleText")
    regText(subTitleLabel, "SubTitleText")

    -- Include title in font targets
    table.insert(Window._fontTargets, titleLabel)
    table.insert(Window._fontTargets, subTitleLabel)

    -- ──────────────────────────────────────────
    --  Apply background to all registered surface elements
    --  Called whenever the user picks a background color
    -- ──────────────────────────────────────────
    function Window:ApplyBackground(bgColor)
        local derived = deriveColors(bgColor)
        local map = {
            Background  = bgColor,
            Surface     = derived.Surface,
            SurfaceElevated = derived.SurfaceElevated,
            SurfaceHover    = derived.SurfaceHover,
            Border      = derived.Border,
            TitleBarBg  = derived.TitleBarBg,
            ControlBg   = derived.ControlBg,
            SliderTrack = derived.SliderTrack,
            TabInactive = derived.TabInactive,
            TabActive   = self._theme.TabActive,  -- accent-driven, unchanged
        }
        -- Update live theme table so new elements pick it up
        self._theme.Background      = bgColor
        self._theme.Surface         = derived.Surface
        self._theme.SurfaceElevated = derived.SurfaceElevated
        self._theme.SurfaceHover    = derived.SurfaceHover
        self._theme.Border          = derived.Border
        self._theme.TitleBarBg      = derived.TitleBarBg
        self._theme.ControlBg       = derived.ControlBg
        self._theme.SliderTrack     = derived.SliderTrack
        self._theme.TabInactive     = derived.TabInactive
        self._theme.ControlBorder   = derived.Border

        for _, entry in ipairs(self._surfaceElements) do
            if entry.obj and entry.obj.Parent then
                local col = map[entry.role]
                if col then
                    pcall(function()
                        Util.TweenFast(entry.obj, {BackgroundColor3=col}, 0.3)
                    end)
                    -- Update UIStroke color too if present
                    local stroke = entry.obj:FindFirstChildOfClass("UIStroke")
                    if stroke and (entry.role=="Border" or entry.role=="Surface" or entry.role=="SurfaceElevated") then
                        pcall(function() Util.TweenFast(stroke, {Color=derived.Border}, 0.3) end)
                    end
                end
            end
        end
    end

    -- ──────────────────────────────────────────
    --  Apply text color to all registered text elements
    -- ──────────────────────────────────────────
    function Window:ApplyTextColor(primaryColor)
        -- Derive secondary/muted from primary
        local r, g, b = primaryColor.R, primaryColor.G, primaryColor.B
        local secondary = Color3.new(
            math.clamp(r*0.65 + 0.1, 0, 1),
            math.clamp(g*0.65 + 0.1, 0, 1),
            math.clamp(b*0.65 + 0.1, 0, 1)
        )
        local muted = Color3.new(
            math.clamp(r*0.4 + 0.15, 0, 1),
            math.clamp(g*0.4 + 0.15, 0, 1),
            math.clamp(b*0.4 + 0.15, 0, 1)
        )
        self._theme.TextPrimary   = primaryColor
        self._theme.TextSecondary = secondary
        self._theme.TextMuted     = muted

        for _, entry in ipairs(self._textElements) do
            if entry.obj and entry.obj.Parent then
                local col
                if entry.role == "primary"    then col = primaryColor
                elseif entry.role == "secondary" then col = secondary
                elseif entry.role == "muted"   then col = muted
                elseif entry.role == "TitleText"    then col = primaryColor
                elseif entry.role == "SubTitleText" then col = secondary
                elseif entry.role == "tab"     then col = secondary
                end
                if col then pcall(function() Util.TweenFast(entry.obj, {TextColor3=col}, 0.3) end) end
            end
        end
    end

    -- ──────────────────────────────────────────
    --  Create a tab button (sidebar)
    -- ──────────────────────────────────────────
    local function createTabButton(parent, tabName, tabConfig, isFirst)
        local tabBtn = Util.Button(parent,{
            Name=tabName.."_Btn", Text="", Size=UDim2.new(1,0,0,36),
            BackgroundColor3=isFirst and theme.TabActive or theme.TabInactive,
        })
        Util.Corner(tabBtn,8)
        regSurface(tabBtn, isFirst and "TabActive" or "TabInactive")

        local textOffsetX=10

        if tabConfig.Icon then
            local iconInfo=parseIcon(tabConfig.Icon)
            if iconInfo.type=="lucide" then
                local iconChar=getLucideChar(iconInfo.name)
                local iconLbl = Util.Label(tabBtn,{
                    Text=iconChar, Font=Enum.Font.Ubuntu, TextSize=16,
                    TextColor3=isFirst and Color3.fromRGB(255,255,255) or theme.TabText,
                    Size=UDim2.new(0,20,0,20), Position=UDim2.new(0,8,0.5,-10),
                    TextXAlignment=Enum.TextXAlignment.Center, BackgroundTransparency=1, ZIndex=2,
                })
                tabBtn:SetAttribute("LucideIcon",true)
                textOffsetX=30
                regText(iconLbl, isFirst and "primary" or "tab")
            elseif iconInfo.type=="asset" then
                Util.Image(tabBtn,{Image=iconInfo.id,Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,8,0.5,-8),ZIndex=2})
                textOffsetX=30
            end
        end

        local availableTextWidth=124-textOffsetX-4
        local tabLabelText=Util.TruncateText(tabName,Enum.Font.Ubuntu,13,availableTextWidth)
        local tabLabel=Util.Label(tabBtn,{
            Text=tabLabelText, Font=Window._currentFont, TextSize=13,
            TextColor3=isFirst and Color3.fromRGB(255,255,255) or theme.TabText,
            Size=UDim2.new(1,-(textOffsetX+4),1,0), Position=UDim2.new(0,textOffsetX,0,0), ZIndex=2,
        })
        table.insert(Window._fontTargets,tabLabel)
        regText(tabLabel, isFirst and "primary" or "tab")
        return tabBtn, tabLabel
    end

    -- ──────────────────────────────────────────
    --  Window:AddTab
    -- ──────────────────────────────────────────
    function Window:AddTab(tabConfig)
        tabConfig=tabConfig or {}
        local tabName=tabConfig.Name or ("Tab "..( #self._tabs+1))
        local isFirst=#self._tabs==0
        local tabBtn, tabLabel=createTabButton(self._tabTopScroll,tabName,tabConfig,isFirst)

        local tabContent=Util.Frame(self._contentArea,{
            Name=tabName.."_Content",Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,Visible=isFirst,ClipsDescendants=true,
        })
        local scrollFrame=Instance.new("ScrollingFrame")
        scrollFrame.Name="Scroll"; scrollFrame.Size=UDim2.new(1,0,1,0)
        scrollFrame.BackgroundTransparency=1; scrollFrame.BorderSizePixel=0
        scrollFrame.ScrollBarThickness=3; scrollFrame.ScrollBarImageColor3=theme.Accent
        scrollFrame.CanvasSize=UDim2.new(0,0,0,0); scrollFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y
        scrollFrame.Parent=tabContent
        Util.ListLayout(scrollFrame,Enum.FillDirection.Vertical,6); Util.Padding(scrollFrame,12,12,12,12)

        local tabEntry={Name=tabName,Button=tabBtn,Label=tabLabel,Content=tabContent,Scroll=scrollFrame}
        table.insert(self._tabs,tabEntry)
        if isFirst then self._activeTab=tabEntry end

        local function activateTab(entry)
            if self._activeTab==entry then return end
            if self._activeTab then
                local prev=self._activeTab
                Util.TweenFast(prev.Button,{BackgroundColor3=theme.TabInactive},0.35)
                Util.TweenFast(prev.Label,{TextColor3=theme.TabText},0.35)
                if prev.Button:GetAttribute("LucideIcon") then
                    local ic=prev.Button:FindFirstChildOfClass("TextLabel")
                    if ic and ic~=prev.Label then Util.TweenFast(ic,{TextColor3=theme.TabText},0.35) end
                end
                prev.Content.Visible=false
            end
            if self._settingsTabEntry and self._activeTab==self._settingsTabEntry then
                self._settingsTabEntry.Content.Visible=false
                Util.TweenFast(self._settingsTabEntry.Button,{BackgroundColor3=theme.TabInactive},0.35)
                Util.TweenFast(self._settingsTabEntry.Label,{TextColor3=theme.TabText},0.35)
            end
            self._activeTab=entry; entry.Content.Visible=true
            Util.TweenFast(entry.Button,{BackgroundColor3=theme.TabActive},0.35)
            Util.TweenFast(entry.Label,{TextColor3=Color3.fromRGB(255,255,255)},0.35)
            if entry.Button:GetAttribute("LucideIcon") then
                local ic=entry.Button:FindFirstChildOfClass("TextLabel")
                if ic and ic~=entry.Label then Util.TweenFast(ic,{TextColor3=Color3.fromRGB(255,255,255)},0.35) end
            end
        end

        tabBtn.MouseButton1Click:Connect(function() activateTab(tabEntry) end)
        Util.HoverEffect(tabBtn, isFirst and theme.TabActive or theme.TabInactive, isFirst and theme.AccentHover or theme.SurfaceHover)

        -- ────────────────────────────────────────
        --  TAB OBJECT
        -- ────────────────────────────────────────
        local Tab={}
        Tab._theme=theme; Tab._scroll=scrollFrame; Tab._tabEntry=tabEntry
        Tab._dropOverlay=self._dropOverlay; Tab._windowFrame=self._windowFrame; Tab._window=self

        local function makeRow(label, height)
            local row=Util.Frame(scrollFrame,{Name="Row_"..(label or "Item"),Size=UDim2.new(1,0,0,height or 48),BackgroundColor3=theme.SurfaceElevated})
            Util.Corner(row,10); Util.Stroke(row,theme.Border,1,0)
            regSurface(row, "SurfaceElevated")
            -- Register stroke for border recolor
            local stroke = row:FindFirstChildOfClass("UIStroke")
            if stroke then regSurface(stroke, "Border") end
            return row
        end
        local function makeLabel(parent, text, x, y, w, h, font, size, color, textRole)
            local lbl=Util.Label(parent,{
                Text=text, Font=font or Tab._window._currentFont, TextSize=size or 14,
                TextColor3=color or theme.TextPrimary,
                Size=UDim2.new(0,w or 200,0,h or 20), Position=UDim2.new(0,x or 14,0.5,-(h or 20)/2),
            })
            table.insert(Tab._window._fontTargets,lbl)
            regText(lbl, textRole or "primary")
            return lbl
        end

        -- ── Dropdown helper (shared) ─────────────────────────────────
        local function buildDropdown(parentFrame, options, defaultSelected, onSelect)
            local selected=defaultSelected or (options[1] or ""); local isOpen=false

            local dropBtn=Util.Button(parentFrame,{Name="DropBtn",Text="",BackgroundColor3=theme.ControlBg,Size=UDim2.new(0,140,0,30),Position=UDim2.new(1,-152,0.5,-15)})
            Util.Corner(dropBtn,8); Util.Stroke(dropBtn,theme.ControlBorder,1,0)
            regSurface(dropBtn, "ControlBg")

            local dropLabel=Util.Label(dropBtn,{Text=Util.TruncateText(selected,Enum.Font.Ubuntu,13,96),TextSize=13,TextColor3=theme.TextPrimary,Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,10,0,0)})
            table.insert(Tab._window._fontTargets,dropLabel)
            regText(dropLabel, "primary")

            local arrowLabel = Util.Label(dropBtn, {
                Text = "v", Font = Enum.Font.GothamBold,
                TextSize = 11, TextColor3 = theme.TextSecondary,
                Size = UDim2.new(0,20,1,0), Position = UDim2.new(1,-24,0,0),
                TextXAlignment = Enum.TextXAlignment.Center,
            })
            regText(arrowLabel, "secondary")

            local ITEM_H=30;local ITEM_PAD=2;local LIST_PAD=4;local MAX_VIS=5;local listW=140
            local totalH=#options*(ITEM_H+ITEM_PAD)-ITEM_PAD+LIST_PAD*2
            local visH=math.min(#options,MAX_VIS)*(ITEM_H+ITEM_PAD)-ITEM_PAD+LIST_PAD*2

            local listOuter=Util.Frame(Tab._dropOverlay,{
                Name="DropOuter",Size=UDim2.new(0,listW,0,visH),
                BackgroundColor3=theme.SurfaceElevated,Visible=false,ZIndex=500,ClipsDescendants=true,
            })
            Util.Corner(listOuter,8); Util.Stroke(listOuter,theme.BorderAccent,1,0)
            regSurface(listOuter, "SurfaceElevated")

            local listScroll=Instance.new("ScrollingFrame")
            listScroll.Name="DropScroll";listScroll.Size=UDim2.new(1,0,1,0);listScroll.BackgroundTransparency=1
            listScroll.BorderSizePixel=0;listScroll.ScrollBarThickness=#options>MAX_VIS and 3 or 0
            listScroll.ScrollBarImageColor3=theme.Accent;listScroll.CanvasSize=UDim2.new(0,0,0,totalH)
            listScroll.ScrollingDirection=Enum.ScrollingDirection.Y;listScroll.ZIndex=501;listScroll.Parent=listOuter
            Util.Padding(listScroll,LIST_PAD,4,LIST_PAD,4); Util.ListLayout(listScroll,Enum.FillDirection.Vertical,ITEM_PAD)

            for _,opt in ipairs(options) do
                local optBtn=Util.Button(listScroll,{
                    Text=Util.TruncateText(opt,Enum.Font.Ubuntu,13,120),Font=Tab._window._currentFont,
                    TextSize=13,TextColor3=opt==selected and theme.Accent or theme.TextPrimary,
                    BackgroundColor3=theme.SurfaceElevated,Size=UDim2.new(1,0,0,ITEM_H),
                    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=502,
                })
                Util.Corner(optBtn,6);Util.Padding(optBtn,0,0,0,8)
                Util.HoverEffect(optBtn,theme.SurfaceElevated,theme.SurfaceHover)
                table.insert(Tab._window._fontTargets,optBtn)
                regSurface(optBtn, "SurfaceElevated")
                regText(optBtn, "primary")
                optBtn.MouseButton1Click:Connect(function()
                    selected=opt; dropLabel.Text=Util.TruncateText(opt,Enum.Font.Ubuntu,13,96)
                    for _,child in ipairs(listScroll:GetChildren()) do
                        if child:IsA("TextButton") then child.TextColor3=theme.TextPrimary end
                    end
                    optBtn.TextColor3=theme.Accent; isOpen=false; listOuter.Visible=false
                    Util.TweenFast(arrowLabel,{Rotation=90},0.15)
                    onSelect(opt)
                end)
            end

            local function openDropdown()
                local btnPos=dropBtn.AbsolutePosition; local btnSize=dropBtn.AbsoluteSize
                local screenH=Tab._dropOverlay.AbsoluteSize.Y
                local openUp=(screenH-(btnPos.Y+btnSize.Y))<(visH+8)
                local posY=openUp and (btnPos.Y-visH-4) or (btnPos.Y+btnSize.Y+4)
                listOuter.Position=UDim2.new(0,btnPos.X,0,posY); listOuter.Visible=true
            end

            dropBtn.MouseButton1Click:Connect(function()
                isOpen=not isOpen
                if isOpen then
                    openDropdown()
                    Util.TweenFast(arrowLabel,{Rotation=270},0.15)
                else
                    listOuter.Visible=false
                    Util.TweenFast(arrowLabel,{Rotation=90},0.15)
                end
            end)

            UserInputService.InputBegan:Connect(function(inp)
                if isOpen and inp.UserInputType==Enum.UserInputType.MouseButton1 then
                    local mPos=inp.Position
                    local lPos=listOuter.AbsolutePosition;local lSize=listOuter.AbsoluteSize
                    local bPos=dropBtn.AbsolutePosition;local bSize=dropBtn.AbsoluteSize
                    local inside=mPos.X>=lPos.X and mPos.X<=lPos.X+lSize.X and mPos.Y>=lPos.Y and mPos.Y<=lPos.Y+lSize.Y
                    local onBtn=mPos.X>=bPos.X and mPos.X<=bPos.X+bSize.X and mPos.Y>=bPos.Y and mPos.Y<=bPos.Y+bSize.Y
                    if not inside and not onBtn then
                        isOpen=false; listOuter.Visible=false
                        Util.TweenFast(arrowLabel,{Rotation=90},0.15)
                    end
                end
            end)

            local obj={}
            function obj:Set(v) selected=v; dropLabel.Text=Util.TruncateText(v,Enum.Font.Ubuntu,13,96) end
            function obj:Get() return selected end
            return obj
        end

        -- Tab:AddButton
        function Tab:AddButton(config)
            config=config or {}
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Button",Enum.Font.Ubuntu,14,195),14,nil,195,20,nil,nil,nil,"primary")
            local btn=Util.Button(row,{Name="ActionBtn",Text=Util.TruncateText(config.ButtonText or config.Label or "Button",Enum.Font.Ubuntu,13,96),Font=self._window._currentFont,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),BackgroundColor3=theme.Accent,Size=UDim2.new(0,110,0,30),Position=UDim2.new(1,-122,0.5,-15),ClipsDescendants=true})
            Util.Corner(btn,8);Util.Padding(btn,0,7,0,7);Util.HoverEffect(btn,theme.Accent,theme.AccentHover);Util.ClickEffect(btn)
            table.insert(self._window._fontTargets,btn)
            -- Note: action buttons are accent-colored, not surface — don't register as surface
            btn.MouseButton1Click:Connect(function()
                if config.Callback then local ok,err=pcall(config.Callback);if not ok then warn("[BeeUI] Button: "..tostring(err)) end end
            end)
            return btn
        end

        -- Tab:AddToggle
        function Tab:AddToggle(config)
            config=config or {}
            local value=config.Default==true
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Toggle",Enum.Font.Ubuntu,14,195),14,nil,220,20,nil,nil,nil,"primary")
            local trackW,trackH=44,24
            local track=Util.Frame(row,{Name="Track",Size=UDim2.new(0,trackW,0,trackH),Position=UDim2.new(1,-(trackW+12),0.5,-trackH/2),BackgroundColor3=value and theme.ToggleOn or theme.ToggleOff})
            Util.Corner(track,trackH/2)
            -- ToggleOff track follows surface-ish color — register it
            regSurface(track, "ToggleOff_Track") -- special: only updated when off
            local knobSize=trackH-6
            local knob=Util.Frame(track,{Name="Knob",Size=UDim2.new(0,knobSize,0,knobSize),Position=UDim2.new(0,value and (trackW-knobSize-3) or 3,0.5,-knobSize/2),BackgroundColor3=Color3.fromRGB(255,255,255)})
            Util.Corner(knob,knobSize/2)
            local cz=Util.Button(row,{Text="",BackgroundTransparency=1,Size=UDim2.new(1,0,1,0)})
            cz.MouseButton1Click:Connect(function()
                value=not value
                Util.TweenFast(track,{BackgroundColor3=value and theme.ToggleOn or theme.ToggleOff},0.18)
                Util.TweenFast(knob,{Position=UDim2.new(0,value and (trackW-knobSize-3) or 3,0.5,-knobSize/2)},0.18)
                if config.Callback then local ok,err=pcall(config.Callback,value);if not ok then warn("[BeeUI] Toggle: "..tostring(err)) end end
            end)
            local obj={}
            function obj:Set(v) value=v;Util.TweenFast(track,{BackgroundColor3=value and theme.ToggleOn or theme.ToggleOff},0.18);Util.TweenFast(knob,{Position=UDim2.new(0,value and (trackW-knobSize-3) or 3,0.5,-knobSize/2)},0.18) end
            function obj:Get() return value end
            return obj
        end

        -- Tab:AddSlider
        function Tab:AddSlider(config)
            config=config or {}
            local minVal=config.Min or 0;local maxVal=config.Max or 100
            local step=config.Step or 1;local suffix=config.Suffix or ""
            local value=math.clamp(config.Default or minVal,minVal,maxVal)
            local row=makeRow(config.Label,62)
            local nameLbl=Util.Label(row,{Text=Util.TruncateText(config.Label or "Slider",Enum.Font.Ubuntu,14,160),Font=self._window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(0,160,0,18),Position=UDim2.new(0,14,0,8)})
            table.insert(self._window._fontTargets,nameLbl); regText(nameLbl,"primary")
            local valLbl=Util.Label(row,{Text=tostring(value)..suffix,Font=self._window._currentFont,TextSize=13,TextColor3=theme.Accent,Size=UDim2.new(0,80,0,18),Position=UDim2.new(1,-94,0,8),TextXAlignment=Enum.TextXAlignment.Right})
            table.insert(self._window._fontTargets,valLbl)
            local trackH=6
            local track=Util.Frame(row,{Size=UDim2.new(1,-28,0,trackH),Position=UDim2.new(0,14,1,-16),BackgroundColor3=theme.SliderTrack})
            Util.Corner(track,trackH/2); regSurface(track,"SliderTrack")
            local fillR=(value-minVal)/(maxVal-minVal)
            local fill=Util.Frame(track,{Size=UDim2.new(fillR,0,1,0),BackgroundColor3=theme.SliderFill})
            Util.Corner(fill,trackH/2)
            local knobS=16
            local knob=Util.Frame(track,{Size=UDim2.new(0,knobS,0,knobS),Position=UDim2.new(fillR,-knobS/2,0.5,-knobS/2),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=5})
            Util.Corner(knob,knobS/2);Util.Stroke(knob,theme.Accent,2,0)
            local dragging=false
            local function upd(ix)
                local ratio=math.clamp((ix-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
                local snapped=math.clamp(math.round((minVal+ratio*(maxVal-minVal))/step)*step,minVal,maxVal)
                value=snapped;local nr=(snapped-minVal)/(maxVal-minVal)
                fill.Size=UDim2.new(nr,0,1,0);knob.Position=UDim2.new(nr,-knobS/2,0.5,-knobS/2)
                valLbl.Text=tostring(snapped)..suffix
                if config.Callback then local ok,err=pcall(config.Callback,snapped);if not ok then warn("[BeeUI] Slider: "..tostring(err)) end end
            end
            track.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;upd(inp.Position.X) end end)
            UserInputService.InputChanged:Connect(function(inp) if dragging and inp.UserInputType==Enum.UserInputType.MouseMovement then upd(inp.Position.X) end end)
            UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
            local obj={}
            function obj:Set(v) v=math.clamp(v,minVal,maxVal);value=v;local r=(v-minVal)/(maxVal-minVal);fill.Size=UDim2.new(r,0,1,0);knob.Position=UDim2.new(r,-knobS/2,0.5,-knobS/2);valLbl.Text=tostring(v)..suffix end
            function obj:Get() return value end
            return obj
        end

        -- Tab:AddDropdown
        function Tab:AddDropdown(config)
            config=config or {}
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Dropdown",Enum.Font.Ubuntu,14,195),14,nil,200,20,nil,nil,nil,"primary")
            return buildDropdown(row, config.Options or {}, config.Default, function(opt)
                if config.Callback then local ok,err=pcall(config.Callback,opt);if not ok then warn("[BeeUI] Dropdown: "..tostring(err)) end end
            end)
        end

        -- Tab:AddInput
        function Tab:AddInput(config)
            config=config or {}
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Input",Enum.Font.Ubuntu,14,160),14,nil,160,20,nil,nil,nil,"primary")
            local inputBox=Instance.new("TextBox")
            inputBox.Name="InputBox";inputBox.Text=config.Default or "";inputBox.PlaceholderText=config.Placeholder or "Type here..."
            inputBox.Font=self._window._currentFont;inputBox.TextSize=13;inputBox.TextColor3=theme.TextPrimary
            inputBox.PlaceholderColor3=theme.TextMuted;inputBox.BackgroundColor3=theme.ControlBg
            inputBox.BorderSizePixel=0;inputBox.ClearTextOnFocus=false;inputBox.Size=UDim2.new(0,160,0,30)
            inputBox.Position=UDim2.new(1,-172,0.5,-15);inputBox.TextXAlignment=Enum.TextXAlignment.Left;inputBox.Parent=row
            Util.Corner(inputBox,8);Util.Stroke(inputBox,theme.ControlBorder,1,0);Util.Padding(inputBox,0,0,0,10)
            table.insert(self._window._fontTargets,inputBox)
            regSurface(inputBox, "ControlBg")
            regText(inputBox, "primary")
            inputBox.Focused:Connect(function() Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.Accent},0.15) end)
            inputBox.FocusLost:Connect(function()
                Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.ControlBorder},0.15)
                if config.Callback then local ok,err=pcall(config.Callback,inputBox.Text);if not ok then warn("[BeeUI] Input: "..tostring(err)) end end
            end)
            local obj={}
            function obj:Set(v) inputBox.Text=tostring(v) end
            function obj:Get() return inputBox.Text end
            return obj
        end

        -- Tab:AddLabel
        function Tab:AddLabel(text)
            local row=makeRow("Label_"..(text or ""),36); row.BackgroundTransparency=1
            local s=row:FindFirstChildOfClass("UIStroke");if s then s:Destroy() end
            local lbl=Util.Label(row,{Text=text or "",Font=self._window._currentFont,TextSize=13,TextColor3=theme.TextSecondary,Size=UDim2.new(1,-28,1,0),Position=UDim2.new(0,14,0,0),TextWrapped=true})
            table.insert(self._window._fontTargets,lbl); regText(lbl,"secondary")
        end

        -- Tab:AddSeparator
        function Tab:AddSeparator()
            local sep = Util.Frame(scrollFrame,{Name="Separator",Size=UDim2.new(1,0,0,1),BackgroundColor3=theme.Border})
            regSurface(sep, "Border")
        end

        -- Tab:AddSection
        function Tab:AddSection(title)
            local holder=Util.Frame(scrollFrame,{Name="Section_"..(title or ""),Size=UDim2.new(1,0,0,28),BackgroundTransparency=1})
            local line = Util.Frame(holder,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=theme.Border})
            regSurface(line, "Border")
            local badge=Util.Frame(holder,{Size=UDim2.new(0,0,0,22),Position=UDim2.new(0,10,0.5,-11),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=theme.SurfaceHover})
            Util.Corner(badge,6);Util.Padding(badge,0,10,0,10)
            regSurface(badge, "SurfaceHover")
            local sLbl=Util.Label(badge,{Text=title or "Section",Font=self._window._currentFont,TextSize=11,TextColor3=theme.Accent,Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X})
            table.insert(self._window._fontTargets,sLbl)
            -- Section labels use accent color, not text color — don't register as text target
        end

        -- Tab:AddColorPicker
        function Tab:AddColorPicker(config)
            config=config or {}; local color=config.Default or Color3.fromRGB(255,100,50)
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Color",Enum.Font.Ubuntu,14,195),14,nil,200,20,nil,nil,nil,"primary")
            local preview=Util.Frame(row,{Size=UDim2.new(0,36,0,28),Position=UDim2.new(1,-48,0.5,-14),BackgroundColor3=color})
            Util.Corner(preview,8);Util.Stroke(preview,theme.Border,1,0)
            local cz=Util.Button(row,{Text="",BackgroundTransparency=1,Size=UDim2.new(1,0,1,0)})
            cz.MouseButton1Click:Connect(function() color=Color3.fromHSV(math.random(),0.8,1);preview.BackgroundColor3=color;if config.Callback then pcall(config.Callback,color) end end)
            local obj={}; function obj:Set(c) color=c;preview.BackgroundColor3=c end; function obj:Get() return color end; return obj
        end

        -- Tab:AddKeybind
        function Tab:AddKeybind(config)
            config=config or {}; local key=config.Default or Enum.KeyCode.F; local listening=false
            local row=makeRow(config.Label,48)
            makeLabel(row,Util.TruncateText(config.Label or "Keybind",Enum.Font.Ubuntu,14,195),14,nil,200,20,nil,nil,nil,"primary")
            local kbBtn=Util.Button(row,{Text="["..key.Name.."]",Font=self._window._currentFont,TextSize=13,TextColor3=theme.Accent,BackgroundColor3=theme.ControlBg,Size=UDim2.new(0,110,0,30),Position=UDim2.new(1,-122,0.5,-15)})
            Util.Corner(kbBtn,8);Util.Stroke(kbBtn,theme.ControlBorder,1,0)
            table.insert(self._window._fontTargets,kbBtn)
            regSurface(kbBtn,"ControlBg")
            kbBtn.MouseButton1Click:Connect(function() listening=true;kbBtn.Text="[...]";kbBtn.TextColor3=theme.Warning end)
            UserInputService.InputBegan:Connect(function(inp,gp)
                if gp then return end
                if listening and inp.UserInputType==Enum.UserInputType.Keyboard then
                    key=inp.KeyCode;kbBtn.Text="["..key.Name.."]";kbBtn.TextColor3=theme.Accent;listening=false
                    if config.Callback then pcall(config.Callback,key) end
                end
            end)
            local obj={}; function obj:Get() return key end; return obj
        end

        return Tab
    end

    -- ══════════════════════════════════════════
    --  SETTINGS TAB
    -- ══════════════════════════════════════════
    local function buildSettingsTab()
        local tabName="Settings"
        local tabContent=Util.Frame(contentArea,{Name=tabName.."_Content",Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,ClipsDescendants=true})
        local scrollFrame=Instance.new("ScrollingFrame")
        scrollFrame.Name="Scroll";scrollFrame.Size=UDim2.new(1,0,1,0);scrollFrame.BackgroundTransparency=1
        scrollFrame.BorderSizePixel=0;scrollFrame.ScrollBarThickness=3;scrollFrame.ScrollBarImageColor3=theme.Accent
        scrollFrame.CanvasSize=UDim2.new(0,0,0,0);scrollFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y;scrollFrame.Parent=tabContent
        Util.ListLayout(scrollFrame,Enum.FillDirection.Vertical,6);Util.Padding(scrollFrame,12,12,12,12)

        local tabBtn,tabLabel=createTabButton(settingsBtnHolder,tabName,{Name=tabName,Icon="lucide:settings"},false)
        local tabEntry={Name=tabName,Button=tabBtn,Label=tabLabel,Content=tabContent,Scroll=scrollFrame}
        Window._settingsTabEntry=tabEntry

        tabBtn.MouseButton1Click:Connect(function()
            if Window._activeTab==tabEntry then return end
            if Window._activeTab then
                local prev=Window._activeTab
                Util.TweenFast(prev.Button,{BackgroundColor3=theme.TabInactive},0.35)
                Util.TweenFast(prev.Label,{TextColor3=theme.TabText},0.35)
                if prev.Button:GetAttribute("LucideIcon") then
                    local ic=prev.Button:FindFirstChildOfClass("TextLabel")
                    if ic and ic~=prev.Label then Util.TweenFast(ic,{TextColor3=theme.TabText},0.35) end
                end
                prev.Content.Visible=false
            end
            Window._activeTab=tabEntry;tabEntry.Content.Visible=true
            Util.TweenFast(tabBtn,{BackgroundColor3=theme.TabActive},0.35)
            Util.TweenFast(tabLabel,{TextColor3=Color3.fromRGB(255,255,255)},0.35)
            if tabBtn:GetAttribute("LucideIcon") then
                local ic=tabBtn:FindFirstChildOfClass("TextLabel")
                if ic and ic~=tabLabel then Util.TweenFast(ic,{TextColor3=Color3.fromRGB(255,255,255)},0.35) end
            end
        end)
        Util.HoverEffect(tabBtn,theme.TabInactive,theme.SurfaceHover)

        local function sMakeRow(label,height)
            local row=Util.Frame(scrollFrame,{Name="Row_"..(label or "Item"),Size=UDim2.new(1,0,0,height or 48),BackgroundColor3=theme.SurfaceElevated})
            Util.Corner(row,10);Util.Stroke(row,theme.Border,1,0)
            regSurface(row,"SurfaceElevated")
            local stroke=row:FindFirstChildOfClass("UIStroke")
            if stroke then regSurface(stroke,"Border") end
            return row
        end
        local function sSection(title)
            local holder=Util.Frame(scrollFrame,{Name="Section_"..(title or ""),Size=UDim2.new(1,0,0,28),BackgroundTransparency=1})
            local line=Util.Frame(holder,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=theme.Border})
            regSurface(line,"Border")
            local badge=Util.Frame(holder,{Size=UDim2.new(0,0,0,22),Position=UDim2.new(0,10,0.5,-11),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=theme.SurfaceHover})
            Util.Corner(badge,6);Util.Padding(badge,0,10,0,10)
            regSurface(badge,"SurfaceHover")
            local sLbl=Util.Label(badge,{Text=title or "Section",Font=Window._currentFont,TextSize=11,TextColor3=theme.Accent,Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X})
            table.insert(Window._fontTargets,sLbl)
        end

        -- ── Font picker ───────────────────────────────────────────────
        sSection("Font")
        do
            local fontNames={}
            for _,f in ipairs(AvailableFonts) do table.insert(fontNames,f.Name) end
            local row=sMakeRow("Interface Font",48)
            local lbl=Util.Label(row,{Text="Interface Font",Font=Window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(0,200,0,20),Position=UDim2.new(0,14,0.5,-10)})
            table.insert(Window._fontTargets,lbl); regText(lbl,"primary")

            local selected="Ubuntu";local isOpen=false
            local dropBtn=Util.Button(row,{Text="",BackgroundColor3=theme.ControlBg,Size=UDim2.new(0,140,0,30),Position=UDim2.new(1,-152,0.5,-15)})
            Util.Corner(dropBtn,8);Util.Stroke(dropBtn,theme.ControlBorder,1,0)
            regSurface(dropBtn,"ControlBg")
            local dropLabel=Util.Label(dropBtn,{Text=Util.TruncateText(selected,Enum.Font.Ubuntu,13,96),TextSize=13,TextColor3=theme.TextPrimary,Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,10,0,0)})
            table.insert(Window._fontTargets,dropLabel); regText(dropLabel,"primary")
            local arrowLbl=Util.Label(dropBtn,{Text=">",Font=Enum.Font.Ubuntu,TextSize=13,TextColor3=theme.TextSecondary,Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-24,0,0),TextXAlignment=Enum.TextXAlignment.Center,Rotation=90})
            regText(arrowLbl,"secondary")

            local ITEM_H=30;local ITEM_PAD=2;local LIST_PAD=4;local MAX_VIS=5;local listW=140
            local totalH=#fontNames*(ITEM_H+ITEM_PAD)-ITEM_PAD+LIST_PAD*2
            local visH=math.min(#fontNames,MAX_VIS)*(ITEM_H+ITEM_PAD)-ITEM_PAD+LIST_PAD*2
            local listOuter=Util.Frame(dropOverlay,{Name="FontDropOuter",Size=UDim2.new(0,listW,0,visH),BackgroundColor3=theme.SurfaceElevated,Visible=false,ZIndex=500,ClipsDescendants=true})
            Util.Corner(listOuter,8);Util.Stroke(listOuter,theme.BorderAccent,1,0)
            regSurface(listOuter,"SurfaceElevated")
            local listScroll=Instance.new("ScrollingFrame")
            listScroll.Name="FontDropScroll";listScroll.Size=UDim2.new(1,0,1,0);listScroll.BackgroundTransparency=1;listScroll.BorderSizePixel=0
            listScroll.ScrollBarThickness=#fontNames>MAX_VIS and 3 or 0;listScroll.ScrollBarImageColor3=theme.Accent
            listScroll.CanvasSize=UDim2.new(0,0,0,totalH);listScroll.ScrollingDirection=Enum.ScrollingDirection.Y
            listScroll.ZIndex=501;listScroll.Parent=listOuter
            Util.Padding(listScroll,LIST_PAD,4,LIST_PAD,4);Util.ListLayout(listScroll,Enum.FillDirection.Vertical,ITEM_PAD)
            for _,opt in ipairs(fontNames) do
                local optBtn=Util.Button(listScroll,{Text=Util.TruncateText(opt,Enum.Font.Ubuntu,13,120),Font=Enum.Font.Ubuntu,TextSize=13,TextColor3=opt==selected and theme.Accent or theme.TextPrimary,BackgroundColor3=theme.SurfaceElevated,Size=UDim2.new(1,0,0,ITEM_H),TextXAlignment=Enum.TextXAlignment.Left,ZIndex=502})
                Util.Corner(optBtn,6);Util.Padding(optBtn,0,0,0,8);Util.HoverEffect(optBtn,theme.SurfaceElevated,theme.SurfaceHover)
                regSurface(optBtn,"SurfaceElevated"); regText(optBtn,"primary")
                optBtn.MouseButton1Click:Connect(function()
                    selected=opt;dropLabel.Text=Util.TruncateText(opt,Enum.Font.Ubuntu,13,96)
                    for _,child in ipairs(listScroll:GetChildren()) do if child:IsA("TextButton") then child.TextColor3=theme.TextPrimary end end
                    optBtn.TextColor3=theme.Accent;isOpen=false;listOuter.Visible=false
                    Util.TweenFast(arrowLbl,{Rotation=90},0.15)
                    local newFont=Enum.Font.Ubuntu
                    for _,f in ipairs(AvailableFonts) do if f.Name==opt then newFont=f.Font;break end end
                    Window._currentFont=newFont
                    for _,obj in ipairs(Window._fontTargets) do
                        if obj and obj.Parent then pcall(function() obj.Font=newFont end) end
                    end
                end)
            end
            dropBtn.MouseButton1Click:Connect(function()
                isOpen=not isOpen
                if isOpen then
                    local bp=dropBtn.AbsolutePosition;local bs=dropBtn.AbsoluteSize
                    local sH=dropOverlay.AbsoluteSize.Y
                    local pY=(sH-(bp.Y+bs.Y))<visH+8 and (bp.Y-visH-4) or (bp.Y+bs.Y+4)
                    listOuter.Position=UDim2.new(0,bp.X,0,pY);listOuter.Visible=true;Util.TweenFast(arrowLbl,{Rotation=270},0.15)
                else listOuter.Visible=false;Util.TweenFast(arrowLbl,{Rotation=90},0.15) end
            end)
            UserInputService.InputBegan:Connect(function(inp)
                if isOpen and inp.UserInputType==Enum.UserInputType.MouseButton1 then
                    local mPos=inp.Position;local lPos=listOuter.AbsolutePosition;local lSize=listOuter.AbsoluteSize
                    local bPos=dropBtn.AbsolutePosition;local bSize=dropBtn.AbsoluteSize
                    local inside=mPos.X>=lPos.X and mPos.X<=lPos.X+lSize.X and mPos.Y>=lPos.Y and mPos.Y<=lPos.Y+lSize.Y
                    local onBtn=mPos.X>=bPos.X and mPos.X<=bPos.X+bSize.X and mPos.Y>=bPos.Y and mPos.Y<=bPos.Y+bSize.Y
                    if not inside and not onBtn then isOpen=false;listOuter.Visible=false;Util.TweenFast(arrowLbl,{Rotation=90},0.15) end
                end
            end)
        end

        -- ── Text Color ────────────────────────────────────────────────
        sSection("Text Color")
        do
            -- Swatch grid for text color presets
            local swatchContainer=Util.Frame(scrollFrame,{Name="TextColorContainer",Size=UDim2.new(1,0,0,80),BackgroundColor3=theme.SurfaceElevated})
            Util.Corner(swatchContainer,10);Util.Stroke(swatchContainer,theme.Border,1,0)
            Util.Padding(swatchContainer,10,10,10,10)
            regSurface(swatchContainer,"SurfaceElevated")
            local sg=Instance.new("UIGridLayout")
            sg.CellSize=UDim2.new(0,24,0,24);sg.CellPadding=UDim2.new(0,6,0,6)
            sg.FillDirection=Enum.FillDirection.Horizontal;sg.HorizontalAlignment=Enum.HorizontalAlignment.Left
            sg.SortOrder=Enum.SortOrder.LayoutOrder;sg.Parent=swatchContainer
            sg:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                swatchContainer.Size=UDim2.new(1,0,0,sg.AbsoluteContentSize.Y+20)
            end)
            for i, preset in ipairs(TextColorPresets) do
                local sw=Util.Button(swatchContainer,{Name="TxtSwatch_"..preset.Name,Text="",BackgroundColor3=preset.Color,Size=UDim2.new(0,24,0,24),LayoutOrder=i,ZIndex=2})
                Util.Corner(sw,5);Util.Stroke(sw,theme.Border,1,0)
                sw.MouseEnter:Connect(function()
                    Util.TweenFast(sw,{Size=UDim2.new(0,26,0,26)},0.1)
                    local s=sw:FindFirstChildOfClass("UIStroke");if s then Util.TweenFast(s,{Color=theme.Accent,Thickness=2},0.1) end
                end)
                sw.MouseLeave:Connect(function()
                    Util.TweenFast(sw,{Size=UDim2.new(0,24,0,24)},0.1)
                    local s=sw:FindFirstChildOfClass("UIStroke");if s then Util.TweenFast(s,{Color=theme.Border,Thickness=1},0.1) end
                end)
                sw.MouseButton1Click:Connect(function()
                    Window:ApplyTextColor(preset.Color)
                end)
            end

            -- Custom RGB input for text color
            local row=sMakeRow("Custom Text Color",48)
            local lbl=Util.Label(row,{Text="Custom (R,G,B)",Font=Window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(0,160,0,20),Position=UDim2.new(0,14,0.5,-10)})
            table.insert(Window._fontTargets,lbl); regText(lbl,"primary")
            local inputBox=Instance.new("TextBox")
            inputBox.Name="TextRgbInput";inputBox.PlaceholderText="240, 240, 245";inputBox.Text=""
            inputBox.Font=Window._currentFont;inputBox.TextSize=13;inputBox.TextColor3=theme.TextPrimary
            inputBox.PlaceholderColor3=theme.TextMuted;inputBox.BackgroundColor3=theme.ControlBg
            inputBox.BorderSizePixel=0;inputBox.ClearTextOnFocus=false;inputBox.Size=UDim2.new(0,150,0,30)
            inputBox.Position=UDim2.new(1,-162,0.5,-15);inputBox.TextXAlignment=Enum.TextXAlignment.Left;inputBox.Parent=row
            Util.Corner(inputBox,8);Util.Stroke(inputBox,theme.ControlBorder,1,0);Util.Padding(inputBox,0,0,0,10)
            table.insert(Window._fontTargets,inputBox)
            regSurface(inputBox,"ControlBg"); regText(inputBox,"primary")
            inputBox.Focused:Connect(function() Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.Accent},0.15) end)
            inputBox.FocusLost:Connect(function()
                Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.ControlBorder},0.15)
                local r,g,b=inputBox.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
                if r and g and b then
                    local c=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))
                    Window:ApplyTextColor(c)
                end
            end)

            -- Preview label
            local previewRow=sMakeRow("Text Preview",48); previewRow.BackgroundTransparency=0.6
            local prevLbl=Util.Label(previewRow,{Text="Preview: The quick brown fox",Font=Window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(1,-28,1,0),Position=UDim2.new(0,14,0,0),TextWrapped=false})
            table.insert(Window._fontTargets,prevLbl); regText(prevLbl,"primary")
        end

        -- ── Background Color ──────────────────────────────────────────
        sSection("Background Color")
        local swatchContainer=Util.Frame(scrollFrame,{Name="SwatchContainer",Size=UDim2.new(1,0,0,80),BackgroundColor3=theme.SurfaceElevated})
        Util.Corner(swatchContainer,10);Util.Stroke(swatchContainer,theme.Border,1,0);Util.Padding(swatchContainer,10,10,10,10)
        regSurface(swatchContainer,"SurfaceElevated")
        local swatchGrid=Instance.new("UIGridLayout")
        swatchGrid.CellSize=UDim2.new(0,24,0,24);swatchGrid.CellPadding=UDim2.new(0,6,0,6)
        swatchGrid.FillDirection=Enum.FillDirection.Horizontal;swatchGrid.HorizontalAlignment=Enum.HorizontalAlignment.Left
        swatchGrid.SortOrder=Enum.SortOrder.LayoutOrder;swatchGrid.Parent=swatchContainer
        swatchGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            swatchContainer.Size=UDim2.new(1,0,0,swatchGrid.AbsoluteContentSize.Y+20)
        end)
        for i,preset in ipairs(BackgroundPresets) do
            local sw=Util.Button(swatchContainer,{Name="Swatch_"..preset.Name,Text="",BackgroundColor3=preset.Color,Size=UDim2.new(0,24,0,24),LayoutOrder=i,ZIndex=2})
            Util.Corner(sw,5);Util.Stroke(sw,theme.Border,1,0)
            sw.MouseEnter:Connect(function() Util.TweenFast(sw,{Size=UDim2.new(0,26,0,26)},0.1);local s=sw:FindFirstChildOfClass("UIStroke");if s then Util.TweenFast(s,{Color=theme.Accent,Thickness=2},0.1) end end)
            sw.MouseLeave:Connect(function() Util.TweenFast(sw,{Size=UDim2.new(0,24,0,24)},0.1);local s=sw:FindFirstChildOfClass("UIStroke");if s then Util.TweenFast(s,{Color=theme.Border,Thickness=1},0.1) end end)
            sw.MouseButton1Click:Connect(function()
                -- Use the new unified ApplyBackground
                Window:ApplyBackground(preset.Color)
            end)
        end
        do
            local row=sMakeRow("Custom Color",48)
            local lbl=Util.Label(row,{Text="Custom Color (R,G,B)",Font=Window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(0,160,0,20),Position=UDim2.new(0,14,0.5,-10)})
            table.insert(Window._fontTargets,lbl); regText(lbl,"primary")
            local inputBox=Instance.new("TextBox")
            inputBox.Name="RgbInput";inputBox.PlaceholderText="255, 180, 30";inputBox.Text=""
            inputBox.Font=Window._currentFont;inputBox.TextSize=13;inputBox.TextColor3=theme.TextPrimary
            inputBox.PlaceholderColor3=theme.TextMuted;inputBox.BackgroundColor3=theme.ControlBg
            inputBox.BorderSizePixel=0;inputBox.ClearTextOnFocus=false;inputBox.Size=UDim2.new(0,150,0,30)
            inputBox.Position=UDim2.new(1,-162,0.5,-15);inputBox.TextXAlignment=Enum.TextXAlignment.Left;inputBox.Parent=row
            Util.Corner(inputBox,8);Util.Stroke(inputBox,theme.ControlBorder,1,0);Util.Padding(inputBox,0,0,0,10)
            table.insert(Window._fontTargets,inputBox)
            regSurface(inputBox,"ControlBg"); regText(inputBox,"primary")
            inputBox.Focused:Connect(function() Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.Accent},0.15) end)
            inputBox.FocusLost:Connect(function()
                Util.TweenFast(inputBox:FindFirstChildOfClass("UIStroke"),{Color=theme.ControlBorder},0.15)
                local r,g,b=inputBox.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
                if r and g and b then
                    local c=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))
                    Window:ApplyBackground(c)
                end
            end)
        end

        -- ── Transparency ──────────────────────────────────────────────
        sSection("Transparency")
        do
            local minVal=0;local maxVal=95;local step=5;local suffix="%";local value=0
            local row=sMakeRow("GUI Opacity",62)
            local nameLbl=Util.Label(row,{Text="GUI Opacity",Font=Window._currentFont,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(0,160,0,18),Position=UDim2.new(0,14,0,8)})
            table.insert(Window._fontTargets,nameLbl); regText(nameLbl,"primary")
            local valLbl=Util.Label(row,{Text=tostring(value)..suffix,Font=Window._currentFont,TextSize=13,TextColor3=theme.Accent,Size=UDim2.new(0,80,0,18),Position=UDim2.new(1,-94,0,8),TextXAlignment=Enum.TextXAlignment.Right})
            table.insert(Window._fontTargets,valLbl)
            local trackH=6
            local track=Util.Frame(row,{Size=UDim2.new(1,-28,0,trackH),Position=UDim2.new(0,14,1,-16),BackgroundColor3=theme.SliderTrack})
            Util.Corner(track,trackH/2); regSurface(track,"SliderTrack")
            local fill=Util.Frame(track,{Size=UDim2.new(0,0,1,0),BackgroundColor3=theme.SliderFill})
            Util.Corner(fill,trackH/2)
            local knobS=16
            local knob=Util.Frame(track,{Size=UDim2.new(0,knobS,0,knobS),Position=UDim2.new(0,-knobS/2,0.5,-knobS/2),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=5})
            Util.Corner(knob,knobS/2);Util.Stroke(knob,theme.Accent,2,0)
            local dragging=false
            local function upd(ix)
                local ratio=math.clamp((ix-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
                local snap=math.clamp(math.round((minVal+ratio*(maxVal-minVal))/step)*step,minVal,maxVal)
                value=snap;local nr=(snap-minVal)/(maxVal-minVal)
                fill.Size=UDim2.new(nr,0,1,0);knob.Position=UDim2.new(nr,-knobS/2,0.5,-knobS/2)
                valLbl.Text=tostring(snap)..suffix
                applyWindowTransparency(windowFrame, snap/100)
            end
            track.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;upd(inp.Position.X) end end)
            UserInputService.InputChanged:Connect(function(inp) if dragging and inp.UserInputType==Enum.UserInputType.MouseMovement then upd(inp.Position.X) end end)
            UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
        end

        -- ── Accent Color ──────────────────────────────────────────────
        sSection("Accent Color")
        local accentPresets={
            {Name="Honey",Color=Color3.fromRGB(255,180,30)},{Name="Violet",Color=Color3.fromRGB(139,92,246)},
            {Name="Blue",Color=Color3.fromRGB(59,130,246)},{Name="Green",Color=Color3.fromRGB(52,211,153)},
            {Name="Pink",Color=Color3.fromRGB(244,114,182)},{Name="Red",Color=Color3.fromRGB(239,68,68)},
            {Name="Teal",Color=Color3.fromRGB(20,184,166)},{Name="Orange",Color=Color3.fromRGB(251,146,60)},
        }
        local accentContainer=Util.Frame(scrollFrame,{Name="AccentContainer",Size=UDim2.new(1,0,0,50),BackgroundColor3=theme.SurfaceElevated})
        Util.Corner(accentContainer,10);Util.Stroke(accentContainer,theme.Border,1,0);Util.Padding(accentContainer,10,10,10,10)
        regSurface(accentContainer,"SurfaceElevated")
        local accentGrid=Instance.new("UIGridLayout")
        accentGrid.CellSize=UDim2.new(0,24,0,24);accentGrid.CellPadding=UDim2.new(0,6,0,6)
        accentGrid.FillDirection=Enum.FillDirection.Horizontal;accentGrid.HorizontalAlignment=Enum.HorizontalAlignment.Left
        accentGrid.SortOrder=Enum.SortOrder.LayoutOrder;accentGrid.Parent=accentContainer
        accentGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            accentContainer.Size=UDim2.new(1,0,0,accentGrid.AbsoluteContentSize.Y+20)
        end)
        for i,ap in ipairs(accentPresets) do
            local sw=Util.Button(accentContainer,{Text="",BackgroundColor3=ap.Color,Size=UDim2.new(0,24,0,24),LayoutOrder=i,ZIndex=2})
            Util.Corner(sw,5);Util.Stroke(sw,theme.Border,1,0)
            sw.MouseEnter:Connect(function() Util.TweenFast(sw,{Size=UDim2.new(0,26,0,26)},0.1) end)
            sw.MouseLeave:Connect(function() Util.TweenFast(sw,{Size=UDim2.new(0,24,0,24)},0.1) end)
            sw.MouseButton1Click:Connect(function()
                -- Update theme accent colors
                theme.Accent    = ap.Color
                theme.AccentHover = Color3.new(
                    math.min(ap.Color.R+0.12,1),
                    math.min(ap.Color.G+0.12,1),
                    math.min(ap.Color.B+0.12,1)
                )
                theme.SliderFill  = ap.Color
                theme.ToggleOn    = ap.Color
                theme.TabActive   = ap.Color
                Util.TweenFast(accentLine,{BackgroundColor3=ap.Color},0.3)
                -- Recolor all accent-colored descendants
                for _,desc in ipairs(windowFrame:GetDescendants()) do
                    if desc.Name=="AccentLine" then
                        pcall(function() desc.BackgroundColor3=ap.Color end)
                    end
                end
                -- Recolor tab active buttons
                for _,t in ipairs(Window._tabs) do
                    if t == Window._activeTab then
                        Util.TweenFast(t.Button,{BackgroundColor3=ap.Color},0.3)
                    end
                end
                if Window._settingsTabEntry and Window._activeTab==Window._settingsTabEntry then
                    Util.TweenFast(Window._settingsTabEntry.Button,{BackgroundColor3=ap.Color},0.3)
                end
                -- Recolor slider fills, toggle tracks (when on), knob strokes
                for _,desc in ipairs(windowFrame:GetDescendants()) do
                    pcall(function()
                        if desc.Name=="SliderFill" or desc.Name=="ProgressFill" then
                            desc.BackgroundColor3=ap.Color
                        end
                        if desc:IsA("UIStroke") and desc.Parent and desc.Parent.Name=="Knob" then
                            desc.Color=ap.Color
                        end
                    end)
                end
            end)
        end

        return {}
    end

    Window._settingsTab=buildSettingsTab()
    return Window
end

-- ══════════════════════════════════════════
--  BeeUI:Notify
-- ══════════════════════════════════════════
function BeeUI:Notify(config)
    config=config or {}
    local theme=self._activeTheme or self.Themes.Dark
    local holder=self._notifyHolder; if not holder then return end
    local typeColors={info=theme.Info,success=theme.Success,warning=theme.Warning,error=theme.Error}
    local accentColor=typeColors[config.Type or "info"] or theme.Accent
    local duration=config.Duration or 4
    local notify=Util.Frame(holder,{Name="Notify_"..tostring(tick()),Size=UDim2.new(1,0,0,0),BackgroundColor3=theme.NotifyBg,ClipsDescendants=true,BackgroundTransparency=0,LayoutOrder=self._notifyCount})
    self._notifyCount=self._notifyCount+1
    Util.Corner(notify,12);Util.Stroke(notify,theme.NotifyBorder,1,0)
    Util.Frame(notify,{Size=UDim2.new(0,3,1,0),BackgroundColor3=accentColor})
    local icons={info="ℹ",success="✓",warning="⚠",error="✕"}
    Util.Label(notify,{Text=icons[config.Type or "info"] or "ℹ",Font=Enum.Font.Ubuntu,TextSize=16,TextColor3=accentColor,Size=UDim2.new(0,24,0,24),Position=UDim2.new(0,14,0,14),TextXAlignment=Enum.TextXAlignment.Center})
    Util.Label(notify,{Text=config.Title or "Notification",Font=Enum.Font.Ubuntu,TextSize=14,TextColor3=theme.TextPrimary,Size=UDim2.new(1,-60,0,18),Position=UDim2.new(0,46,0,12)})
    Util.Label(notify,{Text=config.Message or "",Font=Enum.Font.Ubuntu,TextSize=12,TextColor3=theme.TextSecondary,Size=UDim2.new(1,-60,0,36),Position=UDim2.new(0,46,0,30),TextWrapped=true})
    local progressTrack=Util.Frame(notify,{Size=UDim2.new(1,-8,0,2),Position=UDim2.new(0,4,1,-6),BackgroundColor3=theme.Border})
    Util.Corner(progressTrack,1)
    local progressFill=Util.Frame(progressTrack,{Name="ProgressFill",Size=UDim2.new(1,0,1,0),BackgroundColor3=accentColor})
    Util.Corner(progressFill,1)
    Util.Tween(notify,{Time=0.45,Ease=Enum.EasingStyle.Back,Dir=Enum.EasingDirection.Out},{Size=UDim2.new(1,0,0,76)})
    Util.Tween(progressFill,TweenInfo.new(duration,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)})
    task.delay(duration,function()
        Util.TweenFast(notify,{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1},0.35)
        task.delay(0.3,function() notify:Destroy() end)
    end)
    return notify
end

function BeeUI:GetTheme() return self._activeTheme end

return BeeUI
