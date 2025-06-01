
local S = moretools.translator

local adaptation = moretools.adaptation

local N = adaptation_lib.get_item_name

local shears = {}

if adaptation.stick and adaptation.bronze_ingot then
	shears["bronze"] = {
		desc = "Bronze",
		tex_suffix = adaptation.is_hades and "_hades" or "",
		handle_mat = adaptation.stick,
		body_mat = N(adaptation.bronze_ingot),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[3] = 0.2}, uses = 75, maxlevel = 3},
			}
		},
	}
end
--[[
if adaptation.stick and adaptation.steel_ingot then
	steel = {
		desc = "Iron",
		handle_mat = "group:stick",
		body_mat = "default:steel_ingot",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[3] = 0.2}, uses = 60, maxlevel = 3},
			}
		},
	},
end
--]]
if adaptation.steel_rod and adaptation.mese_crystal then
	shears["mese"] = {
		desc = "Mese",
		tex_suffix = adaptation.is_hades and "_hades" or "",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.mese_crystal),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[3] = 0.2}, uses = 90, maxlevel = 3},
			}
		},
	}
end
if adaptation.steel_rod and adaptation.prism then
	shears["prism"] = {
		desc = "Prism",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.gem_prismatic),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[3] = 0.2}, uses = 180, maxlevel = 3},
			}
		},
	}
elseif adaptation.steel_rod and adaptation.diamond then
	shears["diamond"] = {
		desc = "Diamond",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.diamond),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[3] = 0.2}, uses = 180, maxlevel = 3},
			}
		},
	}
end

for material, data in pairs(shears) do
	tex_suffix = data.tex_suffix or ""
	core.register_tool("moretools:shears_"..material, {
			description = S(data.desc.." Shears"),
			inventory_image = "moretools_shears_"..material..tex_suffix..".png",
			wield_image = "moretools_shears_"..material..tex_suffix..".png",
			sound = {breaks = "default_tool_breaks"},
			groups = {trowel = 1},
			stack_max = 1,
			max_drop_level = 3,
			tool_capabilities = data.tool_capabilities,
		})
	core.register_craft({
			output = "moretools:shears_"..material,
			recipe = {
				{"", data.body_mat, ""},
				{data.handle_mat, adaptation.wood, data.body_mat},
				{"", "", data.handle_mat}
			},
		})
end


