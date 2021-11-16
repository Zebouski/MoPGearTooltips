local _G, _ = _G or getfenv()

local Zaz = CreateFrame("Frame", "ZazTooltip", GameTooltip)

TOOLTIP_ENCHANT = "|cFF1EFF00" -- Green
TOOLTIP_RAWSTAT = "|cFF71D5FF" -- Teal

TOOLTIP_ENCHANTS = {
  {"HP +100", "+100 Health"},
  {"+20 Fire Resistance"},
  {"Mana +150", "+150 Mana"},
  {"Armor +125", "+125 Armor"},
  {"Strength +8", "+8 Strength"},
  {"Agility +8", "+8 Agility"},
  {"Stamina +8", "+8 Stamina"},
  {"Intellect +8", "+8 Intellect"},
  {"Spirit +8", "+8 Spirit"},
  {"Dodge +1%", "+1% Dodge"},
  {"Healing and Spell Damage +8", "+8 Spell Power"},
  {"Attack Speed +1%", "+1% Attack Speed"},
  {"+10 Nature Resistance"},
  {"Healing and Spell Damage +18/Spell Hit +1%", "+18 Spell Power/+1% Spell Hit"},
  {"Mana Regen +4/Stamina +10/Healing Spells +24", "+10 Stamina/+4 mana every 5 sec/+24 Healing Spells"},
  {"Healing and Spell Damage +18/Stamina +10", "+10 Stamina/+18 Spell Power"},
  {"Intellect +10/Stamina +10/Healing Spells +24", "+10 Stamina/+10 Intellect/+24 Healing Spells"},
  {"Attack Power +28/Dodge +1%", "+28 Attack Power/+1% Dodge"},
  {"Ranged Attack Power +24/Stamina +10/Hit +1%", "+10 Stamina/+24 Ranged Attack Power/+1% Hit"},
  {"Healing and Spell Damage +13/Intellect +15", "+15 Intellect/+13 Spell Power"},
  {"Defense +7/Stamina +10/Healing Spells +24", "+10 Stamina/+7 Defense/+24 Healing Spells"},
  {"Defense +7/Stamina +10/Block Value +15", "+10 Stamina/+7 Defense/+15 Block Value"},
  {"+5 Frost Resistance"},
  {"+5 Nature Resistance"},
  {"+5 Fire Resistance"},
  {"+5 Arcane Resistance"},
  {"+5 Shadow Resistance"},
  {"+5 All Resistances"},
  {"+30 Attack Power"},
  {"+18 Spell Damage and Healing", "+18 Spell Power"},
  {"+33 Healing Spells"},
  {"+1 All Resistances"},
  {"+3 All Resistances"},
  {"+7 Fire Resistance"},
  {"+15 Fire Resistance"},
  {"+15 Nature Resistance"},
  {"+10 Shadow Resistance"},
  {"Armor +10", "+10 Armor"},
  {"Armor +20", "+20 Armor"},
  {"Armor +30", "+30 Armor"},
  {"Armor +50", "+50 Armor"},
  {"Armor +70", "+70 Armor"},
  {"Agility +1", "+1 Agility"},
  {"Agility +3", "+3 Agility"},
  {"Subtlety"},
  {"Increased Stealth"},
  {"Health +5", "+5 Health"},
  {"Health +15", "+15 Health"},
  {"Health +25", "+25 Health"},
  {"Health +35", "+35 Health"},
  {"Health +50", "+50 Health"},
  {"Health +100", "+100 Health"},
  {"Mana +5", "+5 Mana"},
  {"Mana +30", "+30 Mana"},
  {"Mana +50", "+50 Mana"},
  {"Mana +65", "+65 Mana"},
  {"Mana +100", "+100 Mana"},
  {"Absorption (10)", "+10 Absorption"},
  {"Absorption (25)", "+25 Absorption"},
  {"All Stats +1", "+1 All Stats"},
  {"All Stats +2", "+2 All Stats"},
  {"All Stats +3", "+3 All Stats"},
  {"All Stats +4", "+4 All Stats"},
  {"Strength +1", "+1 Strength"},
  {"Strength +3", "+3 Strength"},
  {"Strength +5", "+5 Strength"},
  {"Strength +7", "+7 Strength"},
  {"Strength +9", "+9 Strength"},
  {"Strength +15", "+15 Strength"},
  {"Agility +1", "+1 Agility"},
  {"Agility +3", "+3 Agility"},
  {"Agility +5", "+5 Agility"},
  {"Agility +7", "+7 Agility"},
  {"Agility +15", "+15 Agility"},
  {"Stamina +1", "+1 Stamina"},
  {"Stamina +3", "+3 Stamina"},
  {"Stamina +5", "+5 Stamina"},
  {"Stamina +7", "+7 Stamina"},
  {"Stamina +9", "+9 Stamina"},
  {"Intellect +3", "+3 Intellect"},
  {"Intellect +5", "+5 Intellect"},
  {"Intellect +7", "+7 Intellect"},
  {"Spirit +1", "+1 Spirit"},
  {"Spirit +3", "+3 Spirit"},
  {"Spirit +5", "+5 Spirit"},
  {"Spirit +7", "+7 Spirit"},
  {"Spirit +9", "+9 Spirit"},
  {"Defense +1", "+1 Defense"},
  {"Defense +2", "+2 Defense"},
  {"Defense +3", "+3 Defense"},
  {"Healing Spells +24", "+24 Healing Spells"},
  {"Mana Regen 4 per 5 sec.", "+4 mana every 5 sec"},
  {"Fishing +2", "+2 Fishing"},
  {"Herbalism +2", "+2 Herbalism"},
  {"Herbalism +5", "+5 Herbalism"},
  {"Mining +2", "+2 Mining"},
  {"Mining +5", "+5 Mining"},
  {"Skinning +5", "+5 Skinning"},
  {"Minor Mount Speed Increase"},
  {"Minor Speed Increase"},
  {"Fishing +2", "+2 Fishing"},
  {"Fishing +2", "+2 Fishing"},
  {"Fishing +2", "+2 Fishing"},
  {"Threat +2%", "+2% Threat"},
  {"Fire Damage +20", "+20 Fire Spell Damage"},
  {"Frost Damage +20", "+20 Frost Spell Damage"},
  {"Shadow Damage +20", "+20 Shadow Spell Damage"},
  {"Healing Spells +30", "+30 Healing Spells"},
  {"Beastslaying +2", "+2 Beastslaying"},
  {"Beastslaying +6", "+6 Beastslaying"},
  {"Elemental Slayer +6", "+6 Elemental Slayer"},
  {"Demonslaying"},
  {"Weapon Damage +1", "+1 Weapon Damage"},
  {"Weapon Damage +2", "+2 Weapon Damage"},
  {"Weapon Damage +3", "+3 Weapon Damage"},
  {"Weapon Damage +4", "+4 Weapon Damage"},
  {"Weapon Damage +5", "+5 Weapon Damage"},
  {"Weapon Damage +7", "+7 Weapon Damage"},
  {"Weapon Damage +9", "+9 Weapon Damage"},
  {"Frost Spell Damage +7", "+7 Frost Spell Damage"},
  {"Icy Weapon"},
  {"Spell Damage +30", "+30 Spell Power"},
  {"Healing Spells +55", "+55 Healing Spells"},
  {"Crusader"},
  {"Fiery Weapon"},
  {"Unholy Weapon"},
  {"Lifestealing"},
  {"Agility +25", "+25 Agility"},
  {"Spirit +3", "+3 Spirit"},
  {"Spirit +9", "+9 Spirit"},
  {"Spirit +20", "+20 Spirit"},
  {"Intellect +3", "+3 Intellect"},
  {"Intellect +9", "+9 Intellect"},
  {"Intellect +22", "+22 Intellect"},
  {"Blocking +2%", "+2% Block Chance"},
  {"+8 Frost Resistance"},
  {"Minor Mana Oil"},
  {"Lesser Mana Oil"},
  {"Brilliant Mana Oil"},
  {"Minor Wizard Oil"},
  {"Lesser Wizard Oil"},
  {"Wizard Oil"},
  {"Brilliant Wizard Oil"},
  {"Blessed Wizard Oil"},
  {"Shadow Oil"},
  {"Frost Oil"},
  {"Rough Weightstone"},
  {"Coarse Weightstone"},
  {"Heavy Weightstone"},
  {"Solid Weightstone"},
  {"Dense Weightstone"},
  {"Heavy Weightstone"},
  {"Heavy Weightstone"},
  {"Heavy Weightstone"},
  {"Rough Sharpening Stone"},
  {"Coarse Sharpening Stone"},
  {"Heavy Sharpening Stone"},
  {"Solid Sharpening Stone"},
  {"Dense Sharpening Stone"},
  {"Elemental Sharpening Stone"},
  {"Consecrated Sharpening Stone"},
  {"Instant Toxin"},
  {"Instant Poison"},
  {"Instant Poison II"},
  {"Instant Poison III"},
  {"Instant Poison IV"},
  {"Instant Poison V"},
  {"Instant Poison VI"},
  {"Deadly Poison"},
  {"Deadly Poison II"},
  {"Deadly Poison III"},
  {"Deadly Poison IV"},
  {"Deadly Poison V"},
  {"Mind-numbing Poison"},
  {"Mind-numbing Poison II"},
  {"Mind-numbing Poison III"},
  {"Crippling Poison"},
  {"Crippling Poison II"},
  {"Wound Poison"},
  {"Wound Poison II"},
  {"Wound Poison III"},
  {"Wound Poison IV"},
  {"Flametongue 1"},
  {"Flametongue 2"},
  {"Flametongue 3"},
  {"Flametongue 4"},
  {"Flametongue 5"},
  {"Flametongue 6"},
  {"Rockbiter 1"},
  {"Rockbiter 2"},
  {"Rockbiter 3"},
  {"Rockbiter 4"},
  {"Rockbiter 5"},
  {"Rockbiter 6"},
  {"Rockbiter 7"},
  {"Windfury 1"},
  {"Windfury 2"},
  {"Windfury 3"},
  {"Windfury 4"},
  {"Windfury"},
  {"Aquadynamic Fish Attractor"},
  {"Bright Baubles"},
  {"Flesh Eating Worm"},
  {"Nightcrawlers"},
  {"Aquadynamic Fish Lens"},
  {"Shiny Bauble"}
}

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

        function checkForText(list, line)
          for _, item in ipairs(list) do
            if string.lower(line) == string.lower(item[1]) then
              return true
            end
          end
          return false
        end
        function substituteText(key, subList)
            for k,v in pairs(subList) do
                if v[1] == key then
                  return v[2] or v[1]
                end
            end
            return false
        end
        function incrementMatch()
          if ini == 0 then
            ini = i
          end
          count = count + 1
        end

        for i = 1, 30 do
            if _G['GameTooltipTextLeft' .. i] and _G['GameTooltipTextLeft' .. i]:IsVisible() and _G['GameTooltipTextLeft' .. i]:GetText() and not string.find(_G['GameTooltipTextLeft' .. i]:GetText(), "Set") then

                local str = _G['GameTooltipTextLeft' .. i]:GetText()

                if checkForText(TOOLTIP_ENCHANTS, str) then
                  if ini == 0 then
                    ini = i
                  end
                  count = count + 1
                  newText = substituteText(str, TOOLTIP_ENCHANTS)
                  data[count] = TOOLTIP_ENCHANT .. newText
                end
                if string.find(str, "Increased Defense", 1, true) then
                    local defEx = Zaz.explode(str, "Increased Defense ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. defEx2[1] .. " Defense"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Block Chance"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Block Value"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Dodge"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Critical Strike"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Hit"
                    end
                end
                if string.find(str, "spells and effects by up to ", 1, true) then
                    local defEx = Zaz.explode(str, "spells and effects by up to ")
                    local spellType = Zaz.explode(defEx[1], "Equip: Increases ")[2]
                    local spellNewtip = ""
                    if string.find(spellType, "damage", 1, true) then
                       local spellDamageType = Zaz.explode(spellType, "damage done by")[2]
                       if string.find(spellType, "magical", 1, true) then
                          spellNewtip = " Spell Power"
                       else 
                          spellNewtip = spellDamageType .. "Spell Damage"
                       end
                    else
                        spellNewtip = " Healing Spells"
                    end
             
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. spellNewtip
                    end
                end
                if string.find(str, "Attack Power.", 1, true) then
                    local defEx = Zaz.explode(Zaz.explode(str, " Attack Power.")[1], "Equip: +")
                    if defEx[2] then
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx[2] .. " Attack Power"
                    end
                end
                if string.find(str, "mana per ", 1, true) then
                    local defEx = Zaz.explode(Zaz.explode(str, " mana per ")[1], "Equip: Restores ")
                    if defEx[2] then
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx[2] .. " mana every 5 sec."
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Spell Critical Strike"
                    end
                end
                -- Ironbark Shield
                if string.find(str, "chance to get a critical strike with Nature spells by ", 1, true) then
                    local defEx = Zaz.explode(str, "chance to get a critical strike with Nature spells by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Nature Spell Critical Strike"
                    end
                end
                -- Benediction
                if string.find(str, "critical effect chance of your Holy spells by ", 1, true) then
                    local defEx = Zaz.explode(str, "critical effect chance of your Holy spells by ")
                    if defEx[2] then
                        local defEx2 = Zaz.explode(defEx[2], '.')
                        if ini == 0 then
                            ini = i
                        end
                        count = count + 1
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Holy Spell Critical Strike"
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
                        data[count] = TOOLTIP_RAWSTAT .. "+" .. defEx2[1] .. " Spell Hit"
                    end
                end
            end

        end

        local originalData = {}
        local insertPos = 0

        -- find an insert position and save originalData
--         for i = 1, 30 do
--           local line = _G['GameTooltipTextLeft' .. i]:GetText()
--
--           if line and checkForText(TOOLTIP_ENCHANTS, line) then
--             insertPos = i
--             for j = 1, ini - insertPos do
--               originalData[j + insertPos - 1] = _G['GameTooltipTextLeft' .. j + insertPos - 1]:GetText()
--             end
--             break
--           end
--         end
        if insertPos == 0 then
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
            _G['GameTooltipTextLeft' .. insertPos + i - 1]:SetText(data[i])
            _G['GameTooltipTextLeft' .. insertPos + i - 1]:Show()
        end

    end
end)

Zaz:SetScript("OnHide", function()
    GameTooltip.itemLink = nil
end)
