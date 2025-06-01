
local S = moretools.translator

local adaptation = moretools.adaptation

local N = adaptation_lib.get_item_name

local inv_next_line_offset = adaptation.player_mod.next_line_offset_inv

local function action_add_clod(action, user, pos, node)
  local inv = user:get_inventory()
  local index = user:get_wield_index()
  local use_item = inv:get_stack("main", index+inv_next_line_offset)
  local fertilizer = composting.fertilize_items[use_item:get_name()]
  if fertilizer and (node.param2<255) then
    use_item:take_item(1)
    inv:set_stack("main", index+inv_next_line_offset, use_item)
    node.param2 = node.param2 + fertilizer
    if node.param2 > 255 then
      node.param2 = 255
    end
    core.swap_node(pos, node)
    return 1.0
  end
  return false
end

local function action_create_garden_soil(action, user, pos, node)
  local inv = user:get_inventory()
  local index = user:get_wield_index()
  local use_item = inv:get_stack("main", index+inv_next_line_offset)
  if use_item:get_name()=="composting:compost_clod" then
    use_item:take_item(1)
    inv:set_stack("main", index+inv_next_line_offset, use_item)
    core.set_node(pos, action.new_node)
    core.swap_node(pos, action.new_node)
    return 1.0
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
  [N(adaptation.soil)] = {
      action_on_use = action_create_garden_soil,
      new_node = {name = "composting:garden_soil", param2 = 127},
    },
  [N(adaptation.soil_wet)] = {
      action_on_use = action_create_garden_soil,
      new_node = {name = "composting:garden_soil_wet", param1 = 2, param2 = 127},
    },
}

local function trowel_on_use(itemstack, user, pointed_thing)
  if pointed_thing.type~="node" then
    return itemstack
  end
  local pos = pointed_thing.under;
  local node = core.get_node(pos);
  local def = core.registered_nodes[node.name]
  if def and def.buildable_to then
    pos.y = pos.y - 1;
    node = core.get_node(pos);
  end
  local action = moretools.trowel_actions[node.name];
  --print("node: "..node.name.." action: "..dump(action))
  if action then
    local wear = action.action_on_use(action, user, pos, node)
    if wear and wear > 0 then
      local def = itemstack:get_definition();
      itemstack:add_wear(math.ceil(def._trowel_wear*wear));
    end
  end
  return itemstack;
end

local trowels = {}

if adaptation.stick and adaptation.wood then
  trowels["wood"] = {
    desc = "Wooden",
    handle_mat = adaptation.stick,
    body_mat = adaptation.wood,
    _trowel_wear = 6000,
  }
end
if adaptation.stick and adaptation.stone then
  trowels["stone"] = {
    desc = "Stone",
    handle_mat = adaptation.stick,
    body_mat = adaptation.stone,
    _trowel_wear = 3000,
  }
end
if adaptation.stick and adaptation.bronze_ingot then
  trowels["bronze"] = {
    desc = "Bronze",
    tex_suffix = adaptation.is_hades and "_hades" or "",
    handle_mat = adaptation.stick,
    body_mat = N(adaptation.bronze_ingot),
    _trowel_wear = 1500,
  }
end
if adaptation.stick and adaptation.steel_ingot then
  trowels["steel"] = {
    desc = "Iron",
    handle_mat = adaptation.stick,
    body_mat = N(adaptation.steel_ingot),
    _trowel_wear = 2000,
  }
end
if adaptation.steel_rod and adaptation.mese_crystal then
  trowels["mese"] = {
    desc = "Mese",
    tex_suffix = adaptation.is_hades and "_hades" or "",
    handle_mat = N(adaptation.steel_rod),
    body_mat = N(adaptation.mese_crystal),
    _trowel_wear = 600,
  }
end
if adaptation.steel_rod and adaptation.prism then
  trowels["prism"] = {
    desc = "Prism",
    handle_mat = N(adaptation.steel_rod),
    body_mat = N(adaptation.prism),
    _trowel_wear = 200,
  }
elseif adaptation.steel_rod and adaptation.diamond then
  trowels["diamond"] = {
    desc = "Diamond",
    handle_mat = N(adaptation.steel_rod),
    body_mat = N(adaptation.diamond),
    _trowel_wear = 200,
  }
end

for material, data in pairs(trowels) do
  tex_suffix = data.tex_suffix or ""
  core.register_tool("moretools:garden_trowel_"..material, {
      description = S(data.desc.." Garden Trowel"),
      inventory_image = "moretools_garden_trowel_"..material..tex_suffix..".png",
      wield_image = "moretools_garden_trowel_"..material..tex_suffix..".png^[transformR270",
      sound = {breaks = "default_tool_breaks"},
      groups = {trowel = 1},
      _trowel_wear = data._trowel_wear,
      
      on_use = trowel_on_use,
    })
  core.register_craft({
      output = "moretools:garden_trowel_"..material,
      recipe = {
        {data.handle_mat},
        {data.body_mat}
      },
    })
end


