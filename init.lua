
moretools = {
  translator = minetest.get_translator("moretools")
}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

if minetest.get_modpath("vines") then
  dofile(modpath.."/screwdrivers.lua")
end

if minetest.get_modpath("vines") then
  dofile(modpath.."/shears.lua")
end

if minetest.get_modpath("composting") then
  dofile(modpath.."/garden_trowels.lua")
end

