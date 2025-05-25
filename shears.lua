
local shears = {
	bronze = true,
	mese = true,
	prism = true
}

for material, _ in pairs(shears) do
	core.register_alias("hades_moretools:shears_"..material,
		"moretools:shears_"..material)
end

