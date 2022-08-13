local _G, _ = _G or getfenv()

local Cooltip = CreateFrame("Frame", "Cooltip", GameTooltip)

TOOLTIP_COLOR_ENCHANT= "|cFF1EFF00" -- Green
TOOLTIP_COLOR_BONUSSTAT = "|cFF71D5FF" -- Teal

function Cooltip.explode(str, delimiter)
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

function adjustTooltip(tooltip, tooltipTypeStr)
    local data = {}
    local ini = 0
    local count = 0
    local line

    local function incrementMatch()
        if ini == 0 then
        ini = line
        end
        count = count + 1
    end
    local function searchReplace(str, searchStr, valuePrefixStr, valueSuffixStr, newSuffixStr)
        if string.find(str, searchStr, 1, true) then
            local defEx = Cooltip.explode(Cooltip.explode(str, valueSuffixStr)[1], valuePrefixStr)
            if defEx[2] then
                incrementMatch()
                data[count] = TOOLTIP_COLOR_BONUSSTAT .. "+" .. defEx[2] .. " " .. newSuffixStr
            end
        end
    end

    local function checkForText(list, line)
        for _, item in ipairs(list) do
        if string.lower(line) == string.lower(item[1]) then
            return true
        end
        end
        return false
    end
    local function substituteText(key, subList)
        for k,v in pairs(subList) do
            if v[1] == key then
                return v[2] or v[1]
            end
        end
        return false
    end

    for i = 1, 30 do -- generate new stats
        line = i
        if _G[tooltipTypeStr .. 'TextLeft' .. i] and _G[tooltipTypeStr .. 'TextLeft' .. i]:IsVisible() and _G[tooltipTypeStr .. 'TextLeft' .. i]:GetText() and not string.find(_G[tooltipTypeStr .. 'TextLeft' .. i]:GetText(), "Set") then

            local str = _G[tooltipTypeStr .. 'TextLeft' .. i]:GetText()

            -- Tank Stats
            searchReplace(str,
                "Equip: Increased Defense",
                "Equip: Increased Defense +",
                ".",
                "Defense")
            searchReplace(str,
                "Equip: Increases your chance to block attacks with a shield by ",
                "Equip: Increases your chance to block attacks with a shield by ",
                ".",
                "Block Chance")
            searchReplace(str,
                "Equip: Increases the block value of your shield by ",
                "Equip: Increases the block value of your shield by ",
                ".",
                "Block Value")
            searchReplace(str,
                "Equip: Increases your chance to dodge an attack by ",
                "Equip: Increases your chance to dodge an attack by ",
                ".",
                "Dodge")
            searchReplace(str,
                "Equip: Increases your chance to parry an attack by ",
                "Equip: Increases your chance to parry an attack by ",
                ".",
                "Parry")

            -- DPS Stats
            searchReplace(str,
                " Attack Power.",
                "Equip: +",
                " Attack Power.",
                "Attack Power")
            searchReplace(str,
                "Equip: Improves your chance to get a critical strike by ",
                "Equip: Improves your chance to get a critical strike by ",
                ".",
                "Critical Strike")
            searchReplace(str,
                "Equip: Improves your chance to hit by ",
                "Equip: Improves your chance to hit by ",
                ".",
                "Hit")
            for _,weapon in pairs( { "Swords", "Two-handed Swords", "Axes", "Two-handed Axes", "Maces", "Two-handed Maces", "Daggers", "Fist Weapons", "Polearms", "Staves", "Fishing" } ) do
                searchReplace(str,
                    "Equip: Increased " .. weapon .. " +",
                    "Equip: Increased " .. weapon .. " +",
                    ".",
                    weapon .. " Skill")
            end

            -- Caster Stats
            for _,school in pairs( { "Holy", "Nature", "Frost", "Fire", "Arcane", "Shadow" } ) do
                searchReplace(str,
                    "damage done by " .. school .. " spells and effects by up to ",
                    "damage done by " .. school .. " spells and effects by up to ",
                    ".",
                    school .. " Spell Damage")
            end
            searchReplace(str,
                "Equip: Increases damage and healing done by magical spells and effects by up to ",
                "Equip: Increases damage and healing done by magical spells and effects by up to ",
                ".",
                "Spell Power")
            searchReplace(str,
                "Equip: Increases healing done by spells and effects by up to ",
                "Equip: Increases healing done by spells and effects by up to ",
                ".",
                "Healing Spells")
            searchReplace(str,
                " mana per ",
                "Equip: Restores ",
                " mana per ",
                "mana every 5 sec.")
            searchReplace(str,
                "Equip: Improves your chance to get a critical strike with spells by ",
                "Equip: Improves your chance to get a critical strike with spells by ",
                ".",
                "Spell Critical Strike")
            searchReplace(str,
                "Equip: Improves your chance to hit with spells by ",
                "Equip: Improves your chance to hit with spells by ",
                ".",
                "Spell Hit")
            searchReplace(str,
                "Equip: Decreases the magical resistances of your spell targets by ",
                "Equip: Decreases the magical resistances of your spell targets by ",
                ".",
                "Spell Penetration")

            -- Ironbark Shield
            searchReplace(str,
                "Equip: Improves your chance to get a critical strike with Nature spells by ",
                "Equip: Improves your chance to get a critical strike with Nature spells by ",
                ".",
                "Nature Spell Critical Strike")
            -- Benediction
            searchReplace(str,
                "Equip: Increases the critical effect chance of your Holy spells by ",
                "Equip: Increases the critical effect chance of your Holy spells by ",
                ".",
                "Holy Spell Critical Strike")

            --turtle
            searchReplace(str,
                "Equip: Your attacks ignore ",
                "Equip: Your attacks ignore ",
                " of the target's armor",
                "Armor Penetration")
            searchReplace(str,
                "Equip: Increases your attack and casting speed",
                "Equip: Increases your attack and casting speed by ",
                ".",
                "Haste")
        end

    end

    -- find an insert position and save originalData
    local originalData = {}
    local insertPos = 0

    local function findPos(searchTerm)
        for i = 1, 30 do
            local str = _G[tooltipTypeStr.. 'TextLeft' .. i]:GetText()
            if str then
                local stringFound
                if (type(searchTerm) == "table") then
                    stringFound = checkForText(searchTerm, str)
                else
                    stringFound = string.find(str, searchTerm, 1, true)
                end
                if stringFound then
                    for j = 1, ini - i do
                        originalData[j + i - 1] = _G[tooltipTypeStr .. 'TextLeft' .. j + i - 1]:GetText()
                    end
                    insertPos = i
                    break
                end
            end
        end
    end

    findPos(TOOLTIP_ENCHANTS)
    if insertPos == 0 then
    findPos("Durability")
    end
    if insertPos == 0 then
    findPos("Classes")
    end
    if insertPos == 0 then
    findPos("Requires Level")
    end
    if insertPos == 0 then
    findPos("Equip:")
    end

    -- insert original data to offset spot
    for i = insertPos, ini - 1 do
        --recolor green text
        if string.find(originalData[i], "Equip:", 1, true)
                or string.find(originalData[i], "Chance on hit:", 1, true)
                or string.find(originalData[i], "Use:", 1, true) then
            _G[tooltipTypeStr .. 'TextLeft' .. i + count]:SetText(TOOLTIP_COLOR_ENCHANT .. originalData[i])
        elseif checkForText(TOOLTIP_ENCHANTS, originalData[i]) then
            _G[tooltipTypeStr .. 'TextLeft' .. i + count]:SetText(TOOLTIP_COLOR_ENCHANT .. substituteText(originalData[i], TOOLTIP_ENCHANTS))
        else
            _G[tooltipTypeStr .. 'TextLeft' .. i + count]:SetText("|cFFffffff" .. originalData[i])
        end
        _G[tooltipTypeStr .. 'TextLeft' .. i + count]:Show()
    end

    -- insert new data to insert pos
    for i = 1, count do
        _G[tooltipTypeStr .. 'TextLeft' .. insertPos + i - 1]:SetText(data[i])
        _G[tooltipTypeStr .. 'TextLeft' .. insertPos + i - 1]:Show()
    end

    tooltip:Show()
end


-- Hooks
-- Source: https://github.com/shagu/ShaguValue

Cooltip:SetScript("OnHide", function()
    GameTooltip.itemLink = nil
end)

Cooltip:SetScript("OnShow", function()
    if GameTooltip.itemLink then
        local _, _, itemLink = string.find(GameTooltip.itemLink, "(item:%d+:%d+:%d+:%d+)");
        if not itemLink then
            return false
        end
        adjustTooltip(GameTooltip, "GameTooltip")
    end
end)

local HookSetItemRef = SetItemRef
SetItemRef = function(link, text, button)
  local item, _, id = string.find(link, "item:(%d+):.*")
  HookSetItemRef(link, text, button)
  if not IsAltKeyDown() and not IsShiftKeyDown() and not IsControlKeyDown() and item then
    adjustTooltip(ItemRefTooltip, "ItemRefTooltip")
  end
end


local HookSetBagItem = GameTooltip.SetBagItem
function GameTooltip.SetBagItem(self, container, slot)
  GameTooltip.itemLink = GetContainerItemLink(container, slot)
  _, GameTooltip.itemCount = GetContainerItemInfo(container, slot)
  return HookSetBagItem(self, container, slot)
end

local HookSetQuestLogItem = GameTooltip.SetQuestLogItem
function GameTooltip.SetQuestLogItem(self, itemType, index)
  GameTooltip.itemLink = GetQuestLogItemLink(itemType, index)
  if not GameTooltip.itemLink then return end
  return HookSetQuestLogItem(self, itemType, index)
end

local HookSetQuestItem = GameTooltip.SetQuestItem
function GameTooltip.SetQuestItem(self, itemType, index)
  GameTooltip.itemLink = GetQuestItemLink(itemType, index)
  return HookSetQuestItem(self, itemType, index)
end

local HookSetLootItem = GameTooltip.SetLootItem
function GameTooltip.SetLootItem(self, slot)
  GameTooltip.itemLink = GetLootSlotLink(slot)
  HookSetLootItem(self, slot)
end

local HookSetInboxItem = GameTooltip.SetInboxItem
function GameTooltip.SetInboxItem(self, mailID, attachmentIndex)
  local itemName, itemTexture, inboxItemCount, inboxItemQuality = GetInboxItem(mailID)
  GameTooltip.itemLink = GetItemLinkByName(itemName)
  return HookSetInboxItem(self, mailID, attachmentIndex)
end

local HookSetInventoryItem = GameTooltip.SetInventoryItem
function GameTooltip.SetInventoryItem(self, unit, slot)
  GameTooltip.itemLink = GetInventoryItemLink(unit, slot)
  return HookSetInventoryItem(self, unit, slot)
end

local HookSetLootRollItem = GameTooltip.SetLootRollItem
function GameTooltip.SetLootRollItem(self, id)
  GameTooltip.itemLink = GetLootRollItemLink(id)
  return HookSetLootRollItem(self, id)
end

local HookSetLootRollItem = GameTooltip.SetLootRollItem
function GameTooltip.SetLootRollItem(self, id)
  GameTooltip.itemLink = GetLootRollItemLink(id)
  return HookSetLootRollItem(self, id)
end

local HookSetMerchantItem = GameTooltip.SetMerchantItem
function GameTooltip.SetMerchantItem(self, merchantIndex)
  GameTooltip.itemLink = GetMerchantItemLink(merchantIndex)
  return HookSetMerchantItem(self, merchantIndex)
end

local HookSetCraftItem = GameTooltip.SetCraftItem
function GameTooltip.SetCraftItem(self, skill, slot)
  GameTooltip.itemLink = GetCraftReagentItemLink(skill, slot)
  return HookSetCraftItem(self, skill, slot)
end

local HookSetCraftSpell = GameTooltip.SetCraftSpell
function GameTooltip.SetCraftSpell(self, slot)
  GameTooltip.itemLink = GetCraftItemLink(slot)
  return HookSetCraftSpell(self, slot)
end

local HookSetAuctionSellItem = GameTooltip.SetAuctionSellItem
function GameTooltip.SetAuctionSellItem(self, slot)
  GameTooltip.itemLink = GetAuctionSellItemLink(slot)
  return HookSetAuctionSellItem(self, slot)
end
local HookSetTradeSkillItem = GameTooltip.SetTradeSkillItem
function GameTooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
  if reagentIndex then
    GameTooltip.itemLink = GetTradeSkillReagentItemLink(skillIndex, reagentIndex)
  else
    GameTooltip.itemLink = GetTradeSkillItemLink(skillIndex)
  end
  return HookSetTradeSkillItem(self, skillIndex, reagentIndex)
end

local HookSetAuctionSellItem = GameTooltip.SetAuctionSellItem
function GameTooltip.SetAuctionSellItem(self)
  local itemName, _, itemCount = GetAuctionSellItemInfo()
  GameTooltip.itemCount = itemCount
  GameTooltip.itemLink = GetItemLinkByName(itemName)
  return HookSetAuctionSellItem(self)
end

local HookSetTradePlayerItem = GameTooltip.SetTradePlayerItem
function GameTooltip.SetTradePlayerItem(self, index)
  GameTooltip.itemLink = GetTradePlayerItemLink(index)
  return HookSetTradePlayerItem(self, index)
end

local HookSetTradeTargetItem = GameTooltip.SetTradeTargetItem
function GameTooltip.SetTradeTargetItem(self, index)
  GameTooltip.itemLink = GetTradeTargetItemLink(index)
  return HookSetTradeTargetItem(self, index)
end
