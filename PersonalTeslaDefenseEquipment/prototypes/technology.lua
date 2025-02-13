local util = require("__core__/lualib/util")

local tech_req = settings.startup["PeronsalTeslaDefenseSetting-tech_requirement"].value

-- if a required tech is set, create a copy of it and set it to unlock the mod item
if tech_req ~= "none" then
	local mod_tech = util.table.deepcopy(data.raw["technology"][tech_req])

	mod_tech.name = "personal-tesla-defense-equipment"
	mod_tech.icons = util.technology_icon_constant_equipment(MOD_PATH.."/graphics/tech-icon.png")
	mod_tech.effects =
		{
			{
				type = "unlock-recipe",
				recipe = "personal-tesla-defense-equipment"
			}
		}

	data:extend({mod_tech})
end
