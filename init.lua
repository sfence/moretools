
local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)

if core.get_modpath("screwdriver") then
	dofile(modpath.."/screwdrivers.lua")
end

if core.get_modpath("hades_vines") then
	dofile(modpath.."/shears.lua")
end

if core.get_modpath("composting") then
	dofile(modpath.."/garden_trowels.lua")
end

if core.get_modpath("hades_grass_divot") then
	core.register_alias("hades_moretools:grass_divot",
		"hades_grass_divot:grass_divot")
	core.register_alias("hades_garden_trowel:grass_divot",
		"hades_grass_divot:grass_divot")
end

