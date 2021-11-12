
local S = moretools.translator


local shears = {
  --[[
  wood = {
    desc = "Wooden",
    handle_mat = "group:stick",
    body_mat = "group:wood",
  },
  stone = {
    desc = "Stone",
    handle_mat = "group:stick",
    body_mat = "group:stone",
  },
  --]]
  bronze = {
    desc = "Bronze",
    handle_mat = "group:stick",
    body_mat = "hades_core:bronze_ingot",
    tool_capabilities = {
      full_punch_interval = 1.0,
      max_drop_level = 1,
      groupcaps = {
        snappy = {times = {[3] = 0.2}, uses = 75, maxlevel = 3},
      }
    },
  },
  --[[
  steel = {
    desc = "Iron",
    handle_mat = "group:stick",
    body_mat = "hades_core:steel_rod",
    tool_capabilities = {
      full_punch_interval = 1.0,
      max_drop_level = 1,
      groupcaps = {
        snappy = {times = {[3] = 0.2}, uses = 60, maxlevel = 3},
      }
    },
  },
  --]]
  mese = {
    desc = "Mese",
    handle_mat = "hades_core:steel_rod",
    body_mat = "hades_core:mese_crystal",
    tool_capabilities = {
      full_punch_interval = 1.0,
      max_drop_level = 1,
      groupcaps = {
        snappy = {times = {[3] = 0.2}, uses = 90, maxlevel = 3},
      }
    },
  },
  prism = {
    desc = "Prism",
    handle_mat = "hades_core:steel_rod",
    body_mat = "hades_core:prismatic_gem",
    tool_capabilities = {
      full_punch_interval = 1.0,
      max_drop_level = 1,
      groupcaps = {
        snappy = {times = {[3] = 0.2}, uses = 180, maxlevel = 3},
      }
    },
  },
}

for material, data in pairs(shears) do
  minetest.register_tool("hades_moretools:shears_"..material, {
      description = S(data.desc.." Shears"),
      inventory_image = "moretools_shears_"..material..".png",
      wield_image = "moretools_shears_"..material..".png",
      sound = {breaks = "default_tool_breaks"},
      groups = {trowel = 1},
      stack_max = 1,
      max_drop_level = 3,
      tool_capabilities = data.tool_capabilities,
    })
  minetest.register_craft({
      output = "hades_moretools:shears_"..material,
      recipe = {
        {"", data.body_mat, ""},
        {data.handle_mat, "group:wood", data.body_mat},
        {"", "", data.handle_mat}
      },
    })
end


