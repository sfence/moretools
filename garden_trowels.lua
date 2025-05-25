
local trowels = {
	wood = true,
	stone = true,
	bronze = true,
	steel = true,
	mese = true,
	prism = true
}

for material, _ in pairs(trowels) do
	core.register_alias("hades_moretools:garden_trowel_"..material,
		"moretools:garden_trowel_"..material)
end


