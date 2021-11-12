
local S = moretools.translator

local screwdrivers = {
  --[[
  wood = {
    desc = "Wooden",
    handle_mat = "group:stick",
    body_mat = "group:wood",
    _screwdriver_uses = 100,
  },
  stone = {
    desc = "Stone",
    handle_mat = "group:stick",
    body_mat = "group:stone",
    _screwdriver_uses = 120,
  },
  --]]
  bronze = {
    desc = "Bronze",
    handle_mat = "group:stick",
    body_mat = "default:bronze_ingot",
    _screwdriver_uses = 150,
  },
  --[[
  steel = {
    desc = "Iron",
    handle_mat = "group:stick",
    body_mat = "default:steel_ingot",
    _screwdriver_uses = 200,
  },
  --]]
  mese = {
    desc = "Mese",
    handle_mat = "default:steel_ingot",
    body_mat = "default:mese_crystal",
    _screwdriver_uses = 500,
  },
  diamond = {
    desc = "Diamond",
    handle_mat = "default:steel_ingot",
    body_mat = "default:diamond",
    _screwdriver_uses = 1000,
  },
}

for material, data in pairs(screwdrivers) do
  minetest.register_tool("moretools:screwdriver_"..material, {
      description = S(data.desc.." Screwdriver"),
      inventory_image = "moretools_screwdriver_"..material..".png",
      wield_image = "moretools_screwdriver_"..material..".png",
      sound = {breaks = "default_tool_breaks"},
      groups = {tool = 1},
      on_use = function(itemstack, user, pointed_thing)
        screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, data._screwdriver_uses)
        return itemstack
      end,
      on_place = function(itemstack, user, pointed_thing)
        screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, data._screwdriver_uses)
        return itemstack
      end,
    })
  minetest.register_craft({
      output = "moretools:screwdriver_"..material,
      recipe = {
        {data.body_mat},
        {data.handle_mat}
      },
    })
end



