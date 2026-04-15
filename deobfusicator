local M = {}

local BEE   = "🐝"
local HONEY = "🍯"
local SEP   = "🌸"
local MARK  = "🌻"

local function byte_to_bee(b)
    local result = {}
    for i = 7, 0, -1 do
        result[#result+1] = (math.floor(b / (2^i)) % 2 == 1) and BEE or HONEY
    end
    return table.concat(result)
end

local function bee_to_byte(s)
    local chars = {}
    local i = 1
    while i <= #s do
        local b = s:byte(i)
        local len = 1
        if b >= 0xF0 then len = 4
        elseif b >= 0xE0 then len = 3
        elseif b >= 0xC0 then len = 2
        end
        chars[#chars+1] = s:sub(i, i + len - 1)
        i = i + len
    end
    local value = 0
    for j = 1, 8 do
        value = value * 2
        if chars[j] == BEE then value = value + 1 end
    end
    return value
end

function M.encrypt(code)
    local parts = { MARK }
    for i = 1, #code do
        parts[#parts+1] = byte_to_bee(code:byte(i))
        if i < #code then parts[#parts+1] = SEP end
    end
    return table.concat(parts)
end

function M.decrypt(enc)
    local body = enc
    if body:sub(1, #MARK) == MARK then
        body = body:sub(#MARK + 1)
    end
    local bytes = {}
    for segment in (body .. SEP):gmatch("(.-)" .. SEP) do
        if segment ~= "" then
            bytes[#bytes+1] = string.char(bee_to_byte(segment))
        end
    end
    return table.concat(bytes)
end

function M.run(enc)
    local code = M.decrypt(enc)
    local fn, err = load(code)
    if fn then
        return fn()
    else
        error("BeeHoney: ошибка загрузки кода: " .. tostring(err))
    end
end

return M
