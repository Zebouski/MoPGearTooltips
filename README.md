# MoPGearTooltips for 1.12
Post-launch Vanilla through Cata had a really messy afterthought of a format for how non-primary gear stats were displayed on items.
MoP fixed this by incorporating every regular "Equip:" stat back alongside the primary stats, just colored green.

This addon hooks into tooltip and itemlink frames to try and reformat the designs to a similar clean format,
which leaves the special, out of the ordinary effects their proper chance to visually stand out:

![image](https://user-images.githubusercontent.com/11151284/184475717-f26752f0-42ca-4241-8e7d-c63ca69db73c.png)![image](https://user-images.githubusercontent.com/11151284/184475990-aa2a2526-c322-4f3c-9323-5dc83da1f726.png)


Enchantments that are simple stats, are also brought into the standardized format while retaining their distinct green coloring.

## Known Issues
* Enchantments aren't fixed on gear that is otherwise already in standard format
* \<Made By Player\> text can pop in late and temporarily revert the fixed tooltip
* AuctionHouse listings, "Currently Equiped" comparisons, 3rd party addons like AtlasLoot, are all not currently hooked and modified by this addon
