
moretools.adaptation = {}
local adaptation = moretools.adaptation

-- items
adaptation.steel_rod = adaptation_lib.get_item({"rod_steel", "ingot_steel", "ingot_iron"})
adaptation.bronze_ingot = adaptation_lib.get_item({"ingot_bronze"})
adaptation.steel_ingot = adaptation_lib.get_item({"ingot_steel", "ingot_iron"})

adaptation.mese_crystal = adaptation_lib.get_item({"mese_crystal"})

adaptation.prism = adaptation_lib.get_item({"gem_prismatic"})
adaptation.diamond = adaptation_lib.get_item({"gem_diamond"})

adaptation.soil = adaptation_lib.get_item({"soil"})
adaptation.soil_wet = adaptation_lib.get_item({"soil_wet"})

adaptation.shears_steel = adaptation_lib.get_item({"shears_steel"})
-- groups
adaptation.stick = adaptation_lib.get_group("stick")
adaptation.wood = adaptation_lib.get_group("wood")
adaptation.stone = adaptation_lib.get_group("stone")

-- mods
adaptation.screwdriver_mod = adaptation_lib.get_mod("screwdriver") or {}
adaptation.player_mod = adaptation_lib.get_mod("player")

-- game
adaptation.is_hades = core.get_modpath("hades_core")~=nil
