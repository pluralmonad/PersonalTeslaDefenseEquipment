local util = require("__core__/lualib/util")

local mod_item = util.table.deepcopy(data.raw["item"]["personal-laser-defense-equipment"])

mod_item.name = "personal-tesla-defense-equipment"
mod_item.icon = MOD_PATH.."/graphics/icon.png"
mod_item.place_as_equipment_result = "personal-tesla-defense-equipment"
mod_item.order = "b[active-defense]-a[personal-tesla-defense-equipment]"

data:extend({mod_item})