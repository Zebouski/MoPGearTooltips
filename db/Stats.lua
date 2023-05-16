-- COOLTIP_STATS.xpac = {
--   {
--     search string: that can be uniquely used to string.find() a matching line,
--     value prefix: the part of the string that comes before the value,
--     value suffix: ^ after the value. pre/suffix must use % on chars to escape string.gsub(),
--     new suffix: that will be placed after the value in the new format
--   }, for each entry
-- }

COOLTIP_PRIM_STATS_COLOR = {
    r=1,
    g=1,
    b=1,
}
COOLTIP_PRIM_STATS = {
    {
        "Strength",
        "%+",
        " Strength",
        "Strength",
    },
    {
        "Agility",
        "%+",
        " Agility",
        "Agility",
    },
    {
        "Stamina",
        "%+",
        " Stamina",
        "Stamina",
    },
    {
        "Intellect",
        "%+",
        " Intellect",
        "Intellect",
    },
    {
        "Spirit",
        "%+",
        " Spirit",
        "Spirit",
    },
}

COOLTIP_SEC_STATS_COLOR = {
    r=0.44,
    g=0.84,
    b=1.00,
}
COOLTIP_SEC_STATS = {
  wotlk={
  },
  tbc={
  },
  vanilla={
    -- Tank Stats
    {
        "Equip: Increased Defense",
        "Equip: Increased Defense %+",
        "%.",
        "Defense"
    },
    {
        "Equip: Increases your chance to block attacks with a shield by ",
        "Equip: Increases your chance to block attacks with a shield by ",
        "%.",
        "Block Chance"
    },
    {
        "Equip: Increases the block value of your shield by ",
        "Equip: Increases the block value of your shield by ",
        "%.",
        "Block Value"
    },
    {
        "Equip: Increases your chance to dodge an attack by ",
        "Equip: Increases your chance to dodge an attack by ",
        "%.",
        "Dodge"
    },
    {
        "Equip: Increases your chance to parry an attack by ",
        "Equip: Increases your chance to parry an attack by ",
        "%.",
        "Parry"
    },

    -- DPS Stats
    {
        " Attack Power.",
        "Equip: %+",
        " Attack Power%.",
        "Attack Power"
    },
    {
        "Equip: Improves your chance to get a critical strike by ",
        "Equip: Improves your chance to get a critical strike by ",
        "%.",
        "Critical Strike"
    },
    {
        "Equip: Improves your chance to hit by ",
        "Equip: Improves your chance to hit by ",
        "%.",
        "Hit"
    },

    -- Caster Stats
    {
        "Equip: Increases damage and healing done by magical spells and effects by up to ",
        "Equip: Increases damage and healing done by magical spells and effects by up to ",
        "%.",
        "Spell Power"
    },
    {
        "Equip: Increases healing done by spells and effects by up to ",
        "Equip: Increases healing done by spells and effects by up to ",
        "%.",
        "Spell Healing"
    },
    {
        "Healing Spells", -- as found on Of Healing gear
        "%+",
        " Healing Spells",
        "Spell Healing"
    },
    {
        " health per ",
        "Equip: Restores ",
        " health per 5 sec%.",
        "Health per 5s"
    },
    {
        " mana per ",
        "Equip: Restores ",
        " mana per 5 sec%.",
        "Mana Per 5s"
    },
    {
        "Equip: Improves your chance to get a critical strike with spells by ",
        "Equip: Improves your chance to get a critical strike with spells by ",
        "%.",
        "Spell Critical Strike"
    },
    {
        "Equip: Improves your chance to hit with spells by ",
        "Equip: Improves your chance to hit with spells by ",
        "%.",
        "Spell Hit"
    },
    {
        "Equip: Decreases the magical resistances of your spell targets by ",
        "Equip: Decreases the magical resistances of your spell targets by ",
        "%.",
        "Spell Penetration"
    },
    -- Ironbark Shield
    {
        "Equip: Improves your chance to get a critical strike with Nature spells by ",
        "Equip: Improves your chance to get a critical strike with Nature spells by ",
        "%.",
        "Nature Spell Critical Strike"
    },
    -- Benediction
    {
        "Equip: Increases the critical effect chance of your Holy spells by ",
        "Equip: Increases the critical effect chance of your Holy spells by ",
        "%.",
        "Holy Spell Critical Strike"
    },
  },
  turtle={
    {
        "Equip: Your attacks ignore ",
        "Equip: Your attacks ignore ",
        " of the target's armor",
        "Armor Penetration"
    },
    {
        " of your Mana regeneration to continue while casting.",
        "Equip: Allows ",
        " of your Mana regeneration to continue while casting.",
        "Casting Mana Regen"
    },
    {
        "Equip: Increases your attack and casting speed",
        "Equip: Increases your attack and casting speed by ",
        "%.",
        "Haste"
    },
  }
}

for _,school in pairs( { "Nature", "Frost", "Fire", "Arcane", "Shadow" } ) do
    table.insert(COOLTIP_PRIM_STATS, {
        school .. " Resistance",
        "%+",
        " " .. school .. " Resistance",
        school .. " Resistance"
    })
end

for _,school in pairs( { "Nature", "Frost", "Fire", "Arcane", "Shadow", "Holy" } ) do
    table.insert(COOLTIP_SEC_STATS.vanilla, {
        "Equip: Increases damage done by " .. school .. " spells and effects by up to ",
        "Equip: Increases damage done by " .. school .. " spells and effects by up to ",
        "%.",
        school .. " Spell Damage"
    })
end

for _,weapon in pairs( { "Swords", "Two-handed Swords", "Axes", "Two-handed Axes", "Maces", "Two-handed Maces", "Daggers", "Fist Weapons", "Polearms", "Staves", "Fishing" } ) do
    table.insert(COOLTIP_SEC_STATS.vanilla, {
        "Equip: Increased " .. weapon .. " +",
        "Equip: Increased " .. weapon .. " %+",
        "%.",
        weapon .. " Skill"
    })
end

