
moretools = {
	translator = core.get_translator("moretools")
}

local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)
	
dofile(modpath.."/adaptation.lua")

local adaptation = moretools.adaptation

if adaptation.screwdriver_mod then
	dofile(modpath.."/screwdrivers.lua")
end

if adaptation.shears_steel then
	dofile(modpath.."/shears.lua")
end

if core.get_modpath("composting") then
	dofile(modpath.."/garden_trowels.lua")
end

