local _G, _ = _G or getfenv()

local Cooltip = CreateFrame("Frame", "Cooltip", GameTooltip)

function Cooltip.adjustTooltip(tooltip, tooltipTypeStr)
    local stats = {}
    local setbonuses = {}

    -- Collect all rows into lua table for analization
    local originalTooltip = {}
    for row = 1, 30 do
        local tooltipRow = _G[tooltipTypeStr .. 'TextLeft' .. row]
        if tooltipRow then
            local rowtext = tooltipRow:GetText()
            if rowtext then
                originalTooltip[row] = {}
                originalTooltip[row].text = rowtext
                originalTooltip[row].color = {}
                originalTooltip[row].color.r,
                originalTooltip[row].color.g,
                originalTooltip[row].color.b,
                originalTooltip[row].color.a
                    = tooltipRow:GetTextColor()
            end
        end
    end

    -- Find out if the tooltip we're looking at is a piece of gear
    -- and what row the stats we want to edit start at
    stats.OrigLength = table.getn(originalTooltip)
    stats.StartRow = 0
    stats.EndRow = 0
    setbonuses.StartRow = nil
    local isGear = false

    for row = 1, stats.OrigLength do
        -- Gear is guaranteed to be labeled with the slot it occupies.
        for _, slot in ipairs(COOLTIP_GEARSLOTS) do
            if slot == originalTooltip[row].text then
                isGear = true
                stats.StartRow = row + 1
            end
        end
        local isEnchant, _ = Cooltip.parseEnchant(originalTooltip[row])
        if isEnchant or
            string.find(originalTooltip[row].text, "Socket", 1, true) or -- TBC
            string.find(originalTooltip[row].text, "Durability", 1, true) or
            string.find(originalTooltip[row].text, "Classes:", 1, true) or
            string.find(originalTooltip[row].text, "Item Level", 1, true) or -- WotLK
            string.find(originalTooltip[row].text, "Requires Level", 1, true) or
            string.find(originalTooltip[row].text, "—", 1, true) or -- emdash used only in rep reqs, like Requires The League of Arathor — Exalted
            string.find(originalTooltip[row].text, "Equip:", 1, true) or
            -- I know this next part is a complicated mess but this should catch every edge case
            (
                string.find(originalTooltip[row].text, "+", 1, true) and -- Catch lines starting with positive stats
                not string.find(originalTooltip[row].text, "-", 1, true) -- but not when both + and - on one line means elemental wep e.g. + 16 - 30 Nature Damage
            )
            or
            (
                row > 2 and -- don't catch -'s in the item name nor turtle xmog
                string.find(originalTooltip[row].text, "-", 1, true) and -- Catch items starting with negative stats
                not string.find(originalTooltip[row].text, "Damage", 1, true) and -- But don't count Weapon Damage lines
                not string.find(originalTooltip[row].text, "Hand", 1, true) and -- or the equip slot text Two-Hand, One-Hand
                not string.find(originalTooltip[row].text, "Equipped", 1, true) -- or gear marked Unique-Equipped
            )
        then
            -- We have found the first case of a +X Stat line,
            -- Or we have found that there are no normal stats and are at the bottom of where stats would be
            -- Either way we are definitely past the gear slot check.
            stats.StartRow = row
            break
        end
    end
    if not isGear then
        return
    end

    -- find out if this gear has set bonuses where we end the stats section early
    for row = stats.StartRow, stats.OrigLength do
        if string.find(originalTooltip[row].text, "Set: ", 1, true) then
            stats.EndRow = row - 1
            setbonuses.StartRow = row
            break
        end
        -- if the above test never succeeds, the stats row
        -- will just naturally be the last row of the tooltip
        stats.EndRow = row
    end

    -- check if has Armor, Damage, Durability, Stats, Slots...
    -- Get all stats, enchants, and meta info like dura, lv

    -- Correct lines and then sort them, sort lines, put enchant, then dura/lv/etc at bottom
    local fixedTooltips = {}
    local unchangedTooltips = {}
    for i = 1, stats.EndRow - stats.StartRow + 1 do
        local row = i + stats.StartRow - 1

        local rowSlotted = false
        local isEnchant, replaceStr = Cooltip.parseEnchant(originalTooltip[row])
        if isEnchant then
            table.insert(unchangedTooltips, {
                text=replaceStr,
--              color=originalTooltip[row].color
                color=COOLTIP_ENCHANTS_COLOR
            })
            rowSlotted = true
        elseif string.find(originalTooltip[row].text, "Chance on Hit:", 1, true) or
            string.find(originalTooltip[row].text, "Use:", 1, true)
        then
            -- These effects need to be left as is
            -- continue
        else
            -- Check against our db\Stats.lua table to see if this is a stat we can fix
            for _, statSet in ipairs({
                { stats=COOLTIP_PRIM_STATS,        color=COOLTIP_PRIM_STATS_COLOR },
                { stats=COOLTIP_SEC_STATS.vanilla, color=COOLTIP_SEC_STATS_COLOR },
                { stats=COOLTIP_SEC_STATS.turtle,  color=COOLTIP_SEC_STATS_COLOR },
            }) do
                -- stat = { searchStr, valuePrefixStr, valueSuffixStr, newSuffixStr }
                for _,stat in ipairs(statSet.stats) do
                    if string.find(originalTooltip[row].text, stat[1], 1, false) then
                        local sign = string.find(originalTooltip[row].text, "^%-", 1, false) and "-" or "+"
                        local suffixRemoved = string.gsub(originalTooltip[row].text, stat[3], "")
                        local foundValue = string.gsub(suffixRemoved, stat[2], "")
                        if foundValue then
                            foundValue = string.gsub(foundValue, "Equip: ", "")
                            table.insert(fixedTooltips, {
                                text=sign .. foundValue .. " " .. stat[4],
                                color=statSet.color,
                            })
                            rowSlotted = true
                        end
                    end
                end
            end
        end
        -- this isn't an enchant nor a stat we've corrected.
        -- put it in unchangedTooltips
        if not rowSlotted then
            table.insert(unchangedTooltips, {
                text=originalTooltip[row].text,
                color=originalTooltip[row].color
            })
        end
    end

    -- Combine fixedTooltips with unchangedTooltips
    for i = 1, table.getn(unchangedTooltips) do
        table.insert(fixedTooltips, unchangedTooltips[i])
    end

    -- Insert data from start to end row
    stats.Length = table.getn(fixedTooltips)
    for i = 1, stats.Length do
        local row = i + stats.StartRow - 1
        _G[tooltipTypeStr .. 'TextLeft' .. row]:SetText(fixedTooltips[i].text)
        _G[tooltipTypeStr .. 'TextLeft' .. row]:SetTextColor(
            fixedTooltips[i].color.r,
            fixedTooltips[i].color.g,
            fixedTooltips[i].color.b,
            fixedTooltips[i].color.a)
        _G[tooltipTypeStr .. 'TextLeft' .. row]:Show()
    end
    tooltip:Show()


    if not setbonuses.StartRow then
        return
    end

    -- Analize set bonuses rows for problems, fix them, and make the change
    -- all in one go since we don't need to rearrange any lines here, they are in proper order.
    -- A repeat of code above, but compacted and with checks only relevant for sets
    -- Could use refactor
    for row = setbonuses.StartRow, stats.OrigLength do
        for _, statSet in ipairs({
                { stats=COOLTIP_PRIM_STATS,        color=COOLTIP_PRIM_STATS_COLOR },
                { stats=COOLTIP_SEC_STATS.vanilla, color=COOLTIP_SEC_STATS_COLOR },
                { stats=COOLTIP_SEC_STATS.turtle,  color=COOLTIP_SEC_STATS_COLOR },
        }) do
            -- stat = { searchStr, valuePrefixStr, valueSuffixStr, newSuffixStr }
            for _,stat in ipairs(statSet.stats) do
                if string.find(originalTooltip[row].text, stat[1], 1, false) then
                    local suffixRemoved = string.gsub(originalTooltip[row].text, stat[3], "")
                    local foundValue = string.gsub(suffixRemoved, stat[2], "")
                    if foundValue then
                        local setPrefix = ""
                        local statStart, foundValueStart = string.find(foundValue, "Set: ", 1, true)
                        setPrefix = string.sub(foundValue, 1, foundValueStart)
                        foundValue = string.gsub(foundValue, ".*Set: ", "")
                        foundValue = string.gsub(foundValue, "%.", "") -- There are an awful amount of set bonuses with random ass periods wtf
                        _G[tooltipTypeStr .. 'TextLeft' .. row]:SetText(
                            setPrefix .. "+" .. foundValue .. " " .. stat[4])
                        _G[tooltipTypeStr .. 'TextLeft' .. row]:SetTextColor(
                            originalTooltip[row].color.r,
                            originalTooltip[row].color.g,
                            originalTooltip[row].color.b,
                            originalTooltip[row].color.a)
                        _G[tooltipTypeStr .. 'TextLeft' .. row]:Show()
                    end
                end
            end
        end
    end
end

function Cooltip.parseEnchant(row)
    if row.color.r == 0 and  --
        row.color.b == 0 and -- Green
        row.color.g > 0.999  --
    then
        for _, enchantSet in ipairs({
            COOLTIP_ENCHANTS.vanilla,
            COOLTIP_ENCHANTS.turtle,
        }) do
            for _, item in ipairs(enchantSet) do
                if string.lower(row.text) == string.lower(item[1]) then
                    return true, item[2] or item[1]
                end
            end
        end
    end
    return false, nil
end

Cooltip:SetScript("OnHide", function()
    GameTooltip.itemLink = nil
end)

Cooltip:SetScript("OnShow", function()
    if GameTooltip.itemLink then
        local _, _, itemLink = string.find(GameTooltip.itemLink, "(item:%d+:%d+:%d+:%d+)");
        if not itemLink then
            return false
        end
        Cooltip.adjustTooltip(GameTooltip, "GameTooltip")
    end
end)

