
local screwdrivers = {
	bronze = true,
	mese = true,
	prism = true
}

for material, _ in pairs(screwdrivers) do
	core.register_alias("hades_moretools:screwdriver_"..material,
		"moretools:screwdrivers_"..material)
end

