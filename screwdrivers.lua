
local S = moretools.translator

local adaptation = moretools.adaptation

local N = adaptation_lib.get_item_name

local screwdrivers = {
}

if adaptation.stick and adaptation.bronze_ingot then
	screwdrivers["bronze"] = {
		desc = "Bronze",
		tex_suffix = adaptation.is_hades and "_hades" or "",
		handle_mat = adaptation.stick,
		body_mat = N(adaptation.bronze_ingot),
		_screwdriver_uses = 150,
	}
end
if adaptation.steel_rod and adaptation.mese_crystal then
	screwdrivers["mese"] = {
		desc = "Mese",
		tex_suffix = adaptation.is_hades and "_hades" or "",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.mese_crystal),
		_screwdriver_uses = 500,
	}
end
if adaptation.steel_rod and adaptation.prism then
	screwdrivers["prism"] = {
		desc = "Prism",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.prism),
		_screwdriver_uses = 1000,
	}
elseif adaptation.steel_rod and adaptation.diamond then
	screwdrivers["diamond"] = {
		desc = "Diamond",
		handle_mat = N(adaptation.steel_rod),
		body_mat = N(adaptation.diamond),
		_screwdriver_uses = 1000,
	}
end

for material, data in pairs(screwdrivers) do
	tex_suffix = data.tex_suffix or ""
	core.register_tool("moretools:screwdriver_"..material, {
			description = S(data.desc.." Screwdriver"),
			inventory_image = "moretools_screwdriver_"..material..tex_suffix..".png",
			wield_image = "moretools_screwdriver_"..material..tex_suffix..".png",
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
	core.register_craft({
			output = "moretools:screwdriver_"..material,
			recipe = {
				{data.body_mat},
				{data.handle_mat}
			},
		})
end



