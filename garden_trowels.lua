
local S = moretools.translator

local function action_add_clod(action, user, pos, node)
  local inv = user:get_inventory()
  local index = user:get_wield_index()
  local use_item = inv:get_stack("main", index+8)
  local fertilizer = composting.fertilize_items[use_item:get_name()]
  if fertilizer and (node.param2<255) then
    use_item:take_item(1)
    inv:set_stack("main", index+8, use_item)
    node.param2 = node.param2 + fertilizer
    if node.param2 > 255 then
      node.param2 = 255
    end
    minetest.swap_node(pos, node)
    return true
  end
  return false
end

local function action_create_garden_soil(action, user, pos, node)
  local inv = user:get_inventory()
  local index = user:get_wield_index()
  local use_item = inv:get_stack("main", index+8)
  if use_item:get_name()=="composting:compost_clod" then
    use_item:take_item(1)
    inv:set_stack("main", index+8, use_item)
    minetest.set_node(pos, action.new_node)
    minetest.swap_node(pos, action.new_node)
    return true
  end
  return false
end

moretools.trowel_actions = {
  ["composting:garden_soil"] = {
      action_on_use = action_add_clod,
    },
  ["composting:garden_soil_wet"] = {
      action_on_use = action_add_clod,
    },
  ["farming:soil"] = {
      action_on_use = action_create_garden_soil,
      new_node = {name = "composting:garden_soil", param2 = 127},
    },
  ["farming:soil_wet"] = {
      action_on_use = action_create_garden_soil,
      new_node = {name = "composting:garden_soil_wet", param1 = 2, param2 = 127},
    },
}

local function trowel_on_use(itemstack, user, pointed_thing)
  local pos = pointed_thing.under;
  local node = minetest.get_node(pos);
  local def = minetest.registered_nodes[node.name]
  if def and def.buildable_to then
    pos.y = pos.y - 1;
    node = minetest.get_node(pos);
  end
  local action = moretools.trowel_actions[node.name];
  if action then
    local wear = action.action_on_use(action, user, pos, node)
    if wear then
      local def = itemstack:get_definition();
      itemstack:add_wear(def._trowel_wear);
    end
  end
  return itemstack;
end

local trowels = {
  wood = {
    desc = "Wooden",
    handle_mat = "group:stick",
    body_mat = "group:wood",
    _trowel_wear = 6000,
  },
  stone = {
    desc = "Stone",
    handle_mat = "group:stick",
    body_mat = "group:stone",
    _trowel_wear = 3000,
  },
  bronze = {
    desc = "Bronze",
    handle_mat = "group:stick",
    body_mat = "default:bronze_ingot",
    _trowel_wear = 1500,
  },
  steel = {
    desc = "Iron",
    handle_mat = "group:stick",
    body_mat = "default:steel_ingot",
    _trowel_wear = 2000,
  },
  mese = {
    desc = "Mese",
    handle_mat = "default:steel_ingot",
    body_mat = "default:mese_crystal",
    _trowel_wear = 600,
  },
  diamond = {
    desc = "Diamond",
    handle_mat = "default:steel_ingot",
    body_mat = "default:diamond",
    _trowel_wear = 200,
  },
}

for material, data in pairs(trowels) do
  minetest.register_tool("moretools:garden_trowel_"..material, {
      description = S(data.desc.." Garden Trowel"),
      inventory_image = "moretools_garden_trowel_"..material..".png",
      wield_image = "moretools_garden_trowel_"..material..".png^[transformR270",
      sound = {breaks = "default_tool_breaks"},
      groups = {trowel = 1},
      _trowel_wear = data._trowel_wear,
      
      on_use = trowel_on_use,
    })
  minetest.register_craft({
      output = "moretools:garden_trowel_"..material,
      recipe = {
        {data.handle_mat},
        {data.body_mat}
      },
    })
end


