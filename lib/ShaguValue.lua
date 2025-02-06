-- Source: https://github.com/shagu/ShaguValue
-- Copied 2023-05-11
local last_search_name
local last_result
local function GetItemLinkByName(name)
  if name ~= last_search_name then
    for itemID = 1, 99999 do
      local itemName, hyperLink, itemQuality = GetItemInfo(itemID)
      if (itemName and itemName == name) then
        local _, _, _, hex = GetItemQualityColor(tonumber(itemQuality))
        last_result = hex.. "|H"..hyperLink.."|h["..itemName.."]|h|r"
        break
      end
    end
    last_search_name = name
  end
  return last_result
end

local HookSetItemRef = SetItemRef
SetItemRef = function(link, text, button)
  local item, _, id = string.find(link, "item:(%d+):.*")
  HookSetItemRef(link, text, button)
  if not IsAltKeyDown() and not IsShiftKeyDown() and not IsControlKeyDown() and item then
    Cooltip.adjustTooltip(ItemRefTooltip, "ItemRefTooltip")
  end
end

local HookSetHyperlink = GameTooltip.SetHyperlink
function GameTooltip.SetHyperlink(self, arg1)
  if arg1 then
    local _, _, linktype = string.find(arg1, "^(.-):(.+)$")
    if linktype == "item" then
      GameTooltip.itemLink = arg1
    end
  end

  return HookSetHyperlink(self, arg1)
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

local HookSetTradeSkillItem = GameTooltip.SetTradeSkillItem
function GameTooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
  if reagentIndex then
    GameTooltip.itemLink = GetTradeSkillReagentItemLink(skillIndex, reagentIndex)
  else
    GameTooltip.itemLink = GetTradeSkillItemLink(skillIndex)
  end
  return HookSetTradeSkillItem(self, skillIndex, reagentIndex)
end

local HookSetAuctionItem = GameTooltip.SetAuctionItem
function GameTooltip.SetAuctionItem(self, atype, index)
  local itemName, _, itemCount = GetAuctionItemInfo(atype, index)
  GameTooltip.itemCount = itemCount
  GameTooltip.itemLink = GetItemLinkByName(itemName)
  return HookSetAuctionItem(self, atype, index)
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

local invtype_to_index = {
  INVTYPE_AMMO = {0},
  INVTYPE_HEAD = {1},
  INVTYPE_NECK = {2},
  INVTYPE_SHOULDER = {3},
  INVTYPE_BODY = {4},
  INVTYPE_CHEST = {5},
  INVTYPE_ROBE = {5},
  INVTYPE_WAIST = {6},
  INVTYPE_LEGS = {7},
  INVTYPE_FEET = {8},
  INVTYPE_WRIST = {9},
  INVTYPE_HAND = {10},
  INVTYPE_FINGER = {11, 12},
  INVTYPE_TRINKET = {13, 14},
  INVTYPE_CLOAK = {15},
  INVTYPE_2HWEAPON = {16, 17},
  INVTYPE_WEAPONMAINHAND = {16, 17},
  INVTYPE_WEAPON = {16, 17},
  INVTYPE_WEAPONOFFHAND = {16, 17},
  INVTYPE_HOLDABLE = {16, 17},
  INVTYPE_SHIELD = {16, 17},
  INVTYPE_RANGED = {18},
  INVTYPE_RANGEDRIGHT = {18},
  INVTYPE_TABARD = {19},
}

local function slot_index(invtype)
  if not invtype_to_index[invtype] then
    return
  end
  return unpack(invtype_to_index[invtype])
end

local HookSetMerchantCompareItem = ShoppingTooltip1.SetMerchantCompareItem
function ShoppingTooltip1.SetMerchantCompareItem(self, buttonID, tooltipIndex)
  local link = GameTooltip.itemLink
  local _, _, id = string.find(link, "item:(%d+)")
  local _, _, _, _, _, _, _, invtype = GetItemInfo(id)
  local index1, index2 = slot_index(invtype)
  ShoppingTooltip1.itemLink = GetInventoryItemLink("player", index1 or 0)
  ShoppingTooltip2.itemLink = GetInventoryItemLink("Player", index2 or 0)
  return HookSetMerchantCompareItem(self, buttonID, tooltipIndex)
end

local HookSetAuctionCompareItem = ShoppingTooltip1.SetAuctionCompareItem
function ShoppingTooltip1.SetAuctionCompareItem(self, type, index, tooltipIndex)
  local link = GameTooltip.itemLink
  local _, _, id = string.find(link, "item:(%d+)")
  local _, _, _, _, _, _, _, invtype = GetItemInfo(id)
  local index1, index2 = slot_index(invtype)
  ShoppingTooltip1.itemLink = GetInventoryItemLink("player", index1 or 0)
  ShoppingTooltip2.itemLink = GetInventoryItemLink("Player", index2 or 0)
  return HookSetAuctionCompareItem(self, type, index, tooltipIndex)
end