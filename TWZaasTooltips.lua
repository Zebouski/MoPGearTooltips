local _G, _ = _G or getfenv()

local Zaz = CreateFrame("Frame", "ZazTooltip", GameTooltip)

function Zaz.explode(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from, 1, true)
    while delim_from do
        table.insert(result, string.sub(str, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from, true)
    end
    table.insert(result, string.sub(str, from))
    return result
end

local ZazHookSetInventoryItem = GameTooltip.SetInventoryItem
function GameTooltip.SetInventoryItem(self, unit, slot)
    GameTooltip.itemLink = GetInventoryItemLink(unit, slot)
    return ZazHookSetInventoryItem(self, unit, slot)
end

local ZazHookSetBagItem = GameTooltip.SetBagItem
function GameTooltip.SetBagItem(self, container, slot)
    GameTooltip.itemLink = GetContainerItemLink(container, slot)
    _, GameTooltip.itemCount = GetContainerItemInfo(container, slot)
    return ZazHookSetBagItem(self, container, slot)
end

Zaz:SetScript("OnShow", function()
    if GameTooltip.itemLink then

        local _, _, itemLink = string.find(GameTooltip.itemLink, "(item:%d+:%d+:%d+:%d+)");

        if not itemLink then
            return false
        end

        local data = {}
        local ini = 0
        local count = 0

        for i = 1, 30 do

            if _G['GameTooltipTextLeft' .. i] and _G['GameTooltipTextLeft' .. i]:IsVisible() and _G['GameTooltipTextLeft' .. i]:GetText() then

                local str = _G['GameTooltipTextLeft' .. i]:GetText()

                if string.find(str, "Increased Defense", 1, true) then
                    local defEx = Zaz.explode(str, "Increased Defense ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = defEx2[1] .. " Defense"
                    end
                end
                if string.find(str, "attacks with a shield by ", 1, true) then
                    local defEx = Zaz.explode(str, "attacks with a shield by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Block Chance"
                    end
                end
                if string.find(str, "value of your shield by ", 1, true) then
                    local defEx = Zaz.explode(str, "value of your shield by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Block Value"
                    end
                end
                if string.find(str, "dodge an attack by ", 1, true) then
                    local defEx = Zaz.explode(str, "dodge an attack by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Dodge"
                    end
                end
                if string.find(str, "critical strike by ", 1, true) then
                    local defEx = Zaz.explode(str, "critical strike by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Critical Strike"
                    end
                end
                if string.find(str, "chance to hit by ", 1, true) then
                    local defEx = Zaz.explode(str, "chance to hit by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Hit"
                    end
                end
                if string.find(str, "magical spells and effects by up to ", 1, true) then
                    local defEx = Zaz.explode(str, "magical spells and effects by up to ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Spell Damage"
                    end
                end
                if string.find(str, "Increases healing done by spells and effects by up to ", 1, true) then
                    local defEx = Zaz.explode(str, "Increases healing done by spells and effects by up to ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Healing Spells"
                    end
                end
                if string.find(str, "Attack Power.", 1, true) then
                    local defEx = Zaz.explode(Zaz.explode(str, " Attack Power.")[1], "Equip: +")
                    if defEx[2] then
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx[2] .. " Attack Power"
                    end
                end
                if string.find(str, "mana per ", 1, true) then
                    local defEx = Zaz.explode(Zaz.explode(str, " mana per ")[1], "Equip: Restores ")
                    if defEx[2] then
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx[2] .. " mana every 5 sec."
                    end
                end
                if string.find(str, "critical strike with spells by ", 1, true) then
                    local defEx = Zaz.explode(str, "critical strike with spells by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Spell Critical Strike"
                    end
                end
                if string.find(str, "chance to hit with spells by ", 1, true) then
                    local defEx = Zaz.explode(str, "chance to hit with spells by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = "+" .. defEx2[1] .. " Spell Hit"
                    end
                end
            end

        end

        local originalData = {}
        local insertPos = 0

        -- find an insert position and save originalData
        for i = 1, 30 do
            local str = _G['GameTooltipTextLeft' .. i]:GetText()
            if str then
                if string.find(str, "Durability", 1, true) then
                    insertPos = i
                    for j = 1, ini - insertPos do
                        originalData[j + insertPos - 1] = _G['GameTooltipTextLeft' .. j + insertPos - 1]:GetText()
                    end
                    break
                end
            end
        end
        if insertPos == 0 then
            for i = 1, 30 do
                local str = _G['GameTooltipTextLeft' .. i]:GetText()
                if str then
                    if string.find(str, "Classes", 1, true) then
                        insertPos = i
                        for j = 1, ini - insertPos do
                            originalData[j + insertPos - 1] = _G['GameTooltipTextLeft' .. j + insertPos - 1]:GetText()
                        end
                        break
                    end
                end
            end
        end
        if insertPos == 0 then
            for i = 1, 30 do
                local str = _G['GameTooltipTextLeft' .. i]:GetText()
                if str then
                    if string.find(str, "Requires", 1, true) then
                        insertPos = i
                        for j = 1, ini - insertPos do
                            originalData[j + insertPos - 1] = _G['GameTooltipTextLeft' .. j + insertPos - 1]:GetText()
                        end
                        break
                    end
                end
            end
        end
        if insertPos == 0 then
            for i = 1, 30 do
                local str = _G['GameTooltipTextLeft' .. i]:GetText()
                if str then
                    if string.find(str, "Equip:", 1, true) then
                        insertPos = i
                        for j = 1, ini - insertPos do
                            originalData[j + insertPos - 1] = _G['GameTooltipTextLeft' .. j + insertPos - 1]:GetText()
                        end
                        break
                    end
                end
            end
        end

        -- todo case where item doesnt have dura or requires lvl
        -- todo fix new tooltip height

        -- insert original data to offset spot
        for i = insertPos, ini - 1 do
            --recolor green text
            if string.find(originalData[i], "Equip:", 1, true)
                    or string.find(originalData[i], "Chance on hit:", 1, true)
                    or string.find(originalData[i], "Use:", 1, true) 
            then
                _G['GameTooltipTextLeft' .. i + count]:SetText("|cFF00ff00" .. originalData[i])
            else
                _G['GameTooltipTextLeft' .. i + count]:SetText("|cFFffffff" .. originalData[i])
            end
            _G['GameTooltipTextLeft' .. i + count]:Show()
        end

        -- insert new data to insert pos
        for i = 1, count do
            _G['GameTooltipTextLeft' .. insertPos + i - 1]:SetText("|cFF71D5FF" .. data[i])
            _G['GameTooltipTextLeft' .. insertPos + i - 1]:Show()
        end

    end
end)

Zaz:SetScript("OnHide", function()
    GameTooltip.itemLink = nil
end)
