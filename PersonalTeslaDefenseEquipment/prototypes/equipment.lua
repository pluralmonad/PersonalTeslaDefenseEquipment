local util = require("__core__/lualib/util")
local mod_functions = require("mod_functions")

-- pull our settings
local range = settings.startup["PeronsalTeslaDefenseSetting-range"].value
local damage_modifier = settings.startup["PeronsalTeslaDefenseSetting-damage_modifier"].value
local grid_size = settings.startup["PeronsalTeslaDefenseSetting-grid_size"].value
local energy_consumption = settings.startup["PeronsalTeslaDefenseSetting-energy_consumption"].value
local shot_cooldown = settings.startup["PeronsalTeslaDefenseSetting-shot_cooldown"].value
local beam_type = settings.startup["PeronsalTeslaDefenseSetting-beam_type"].value

-- gather our beam and chain names dependent on beam type
local chain_and_beam = mod_functions.chain_and_beam(beam_type)

-- use the PLD prototype as our starting point
local mod_equipment = util.table.deepcopy(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"])

mod_equipment.name = "personal-tesla-defense-equipment"
mod_equipment.shape = mod_functions.grid_size_setting_to_shape(grid_size)
mod_equipment.energy_source.buffer_capacity = (mod_functions.compute_buffer_capacity(energy_consumption).."kJ")
mod_equipment.sprite.filename = MOD_PATH.."/graphics/thumbnail.png"
mod_equipment.attack_parameters.range = range
mod_equipment.attack_parameters.damage_modifier = damage_modifier
mod_equipment.attack_parameters.ammo_type.energy_consumption = (energy_consumption.."kJ")
mod_equipment.attack_parameters.cooldown = shot_cooldown --(120 for tesla turret and 40 for PLD)
mod_equipment.attack_parameters.ammo_category = "tesla" --("tesla" for tesla turret and "laser" for PLD)
mod_equipment.attack_parameters.ammo_type.action.action_delivery =
  {
    type = "instant",
    target_effects =
    {
      -- Chain effect must go first in case the beam kills the target
      {
        type = "nested-result",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "chain",
            chain = chain_and_beam.chain,
          }
        }
      },
      {
        type = "nested-result",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "beam",
            beam = chain_and_beam.beam,
            -- this was set to 40 when range was 30, so keep that spread with now dynamic set range
            max_length = (range + 10),
            duration = 30,
            add_to_shooter = false,
            destroy_with_source_or_target = false,
            source_offset = {0, -1.31439}
          }
        }
      }
    }
  }

data:extend({mod_equipment})