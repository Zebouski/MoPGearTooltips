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
    { -- Jagged Obsidian Shield
        "All Resistances.",
        "%+",
        " All Resistances%.",
        "All Resistances"
    },
}

COOLTIP_SEC_STATS_COLOR = {
    r=0.44,
    g=0.84,
    b=1.00,
}
COOLTIP_SEC_STATS = {
  wotlk={
    {
        "Increases attack power by",
        "Increases attack power by ",
        "%.",
        "Attack Power"
    },
  },
  tbc={
  },
  vanilla={
    -- Tank Stats
    {
        "Increased Defense",
        "Increased Defense %+",
        "%.",
        "Defense"
    },
    {
        "Increases your chance to block attacks with a shield by ",
        "Increases your chance to block attacks with a shield by ",
        "%.",
        "Block Chance"
    },
    {
        "Increases the block value of your shield by ",
        "Increases the block value of your shield by ",
        "%.",
        "Block Value"
    },
    {
        "Increases your chance to dodge an attack by ",
        "Increases your chance to dodge an attack by ",
        "%.",
        "Dodge"
    },
    {
        "Increases your chance to parry an attack by ",
        "Increases your chance to parry an attack by ",
        "%.",
        "Parry"
    },

    -- DPS Stats
    {
        " Attack Power.",
        "%+",
        " Attack Power%.",
        "Attack Power"
    },
    {
        "Improves your chance to get a critical strike by ",
        "Improves your chance to get a critical strike by ",
        "%.",
        "Critical Strike"
    },
    {
        "Improves your chance to hit by ",
        "Improves your chance to hit by ",
        "%.",
        "Hit"
    },

    -- Caster Stats
    {
        "Increases damage and healing done by magical spells and effects by up to ",
        "Increases damage and healing done by magical spells and effects by up to ",
        "%.",
        "Spell Power"
    },
    {
        "Increases healing done by spells and effects by up to ",
        "Increases healing done by spells and effects by up to ",
        "%.",
        "Spell Healing"
    },
    { -- Another variation, as found on "Of Healing" gear
        "Healing Spells",
        "%+",
        " Healing Spells",
        "Spell Healing"
    },
    {
        " health per ",
        "Restores ",
        " health per 5 sec%.",
        "Health per 5s"
    },
    {
        " mana per ",
        "Restores ",
        " mana per 5 sec%.",
        "Mana Per 5s"
    },
    {
        "Improves your chance to get a critical strike with spells by ",
        "Improves your chance to get a critical strike with spells by ",
        "%.",
        "Spell Critical Strike"
    },
    {
        "Improves your chance to hit with spells by ",
        "Improves your chance to hit with spells by ",
        "%.",
        "Spell Hit"
    },
    {
        "Decreases the magical resistances of your spell targets by ",
        "Decreases the magical resistances of your spell targets by ",
        "%.",
        "Spell Penetration"
    },
    { -- Ironbark Shield
        "Improves your chance to get a critical strike with Nature spells by ",
        "Improves your chance to get a critical strike with Nature spells by ",
        "%.",
        "Nature Spell Critical Strike"
    },
    { -- Priest T1
        "Improves your chance to get a critical strike with Holy spells by ",
        "Improves your chance to get a critical strike with Holy spells by ",
        "%.",
        "Holy Spell Critical Strike"
    },
    { -- Benediction
        "Increases the critical effect chance of your Holy spells by ",
        "Increases the critical effect chance of your Holy spells by ",
        "%.",
        "Holy Spell Critical Strike"
    },
  },
  turtle={
    {
        " of the target's armor.", -- BRE's effect gets caught if we search the first term
        "Your attacks ignore ",
        " of the target's armor.",
        "Armor Penetration"
    },
    {
        " of your Mana regeneration to continue while casting.",
        "Allows ",
        " of your Mana regeneration to continue while casting.",
        "Casting Mana Regen"
    },
    {
        "Increases your attack and casting speed",
        "Increases your attack and casting speed by ",
        "%.",
        "Haste"
    },
    { -- In 1.12, just Azure Silk Belt
      -- On Turtle, this effect appears on multiple pieces of gear and stacks
        "Increases swim speed by ",
        "Increases swim speed by ",
        "%.",
        "Swim Speed"
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
        "Increases damage done by " .. school .. " spells and effects by up to ",
        "Increases damage done by " .. school .. " spells and effects by up to ",
        "%.",
        school .. " Spell Damage"
    })
end

for _,weapon in pairs( { "Swords", "Two-handed Swords", "Axes", "Two-handed Axes", "Maces", "Two-handed Maces", "Daggers", "Fist Weapons", "Polearms", "Staves", "Fishing" } ) do
    table.insert(COOLTIP_SEC_STATS.vanilla, {
        "Increased " .. weapon .. " +",
        "Increased " .. weapon .. " %+",
        "%.",
        weapon .. " Skill"
    })
end

for _,profession in pairs( { "Skinning", "Mining", "Herbalism", "Engineering" } ) do
    table.insert(COOLTIP_SEC_STATS.vanilla, {
        profession .. " +",
        profession .. " %+",
        "%.",
        profession .. " Skill"
    })
end
