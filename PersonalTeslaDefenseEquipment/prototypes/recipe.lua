local tech_req = settings.startup["PeronsalTeslaDefenseSetting-tech_requirement"].value

--recipe used for "none" tech req option
local mod_recipe =
{
    type = "recipe",
    name = "personal-tesla-defense-equipment",
    enabled = true,
    energy_required = 5,
    ingredients =
    {
        {type = "item", name = "steel-plate", amount = 20},
        {type = "item", name = "copper-plate", amount = 50}
    },
    results = {{type="item", name="personal-tesla-defense-equipment", amount=1}}
}

-- adjust recipe based on technology requirement
if tech_req == "tesla-weapons" then
    mod_recipe.ingredients = data.raw["recipe"]["teslagun"].ingredients
    mod_recipe.category = "electromagnetics"
    mod_recipe.enabled = false
    mod_recipe.energy_required = 30

elseif tech_req == "personal-laser-defense-equipment" then
    mod_recipe.ingredients = data.raw["recipe"]["personal-laser-defense-equipment"].ingredients
    mod_recipe.enabled = false
    mod_recipe.energy_required = 10 
end

data:extend({mod_recipe})