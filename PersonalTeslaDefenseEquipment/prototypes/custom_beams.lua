-- beams.lua does not export a table so will have to use its global functions directly from global space :(
-- local beams = require("__space-age__.prototypes.entity.beams")

-- private function found in active-triggers.lua
local function _make_tesla_chain_lightning_chain(name, beam_name, config)
    return {
      name = name,
      type = "chain-active-trigger",
      max_jumps = config.max_jumps,
      max_range_per_jump = config.jump_range,
      jump_delay_ticks = 6,
      fork_chance = config.fork_chance,
      fork_chance_increase_per_quality_level = config.fork_chance_per_quality,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "beam",
          beam = beam_name,
          max_length = config.jump_range + 0.5,
          duration = config.beam_duration,
          add_to_shooter = false,
          destroy_with_source_or_target = false,
          source_offset = {0, 0}, -- should match beam's target_offset
        },
      },
    }
end

-- original vanilla values
-- local tesla_gun = {
-- max_jumps = 12,
-- jump_range = 12,
-- fork_chance = 0.3,
-- fork_chance_per_quality = 0.05,
-- beam_duration = 30
-- }
-- local tesla_turret = {
-- max_jumps = 10,
-- jump_range = 12,
-- fork_chance = 0.05,
-- fork_chance_per_quality = 0.05,
-- beam_duration = 30
-- }

-- only create the custom beam data if it is selected by the user
local beam_type = settings.startup["PeronsalTeslaDefenseSetting-beam_type"].value

if beam_type == "custom" then
  -- pull all our custom beam settings
  local beam_config = {
    max_jumps = settings.startup["PeronsalTeslaDefenseSetting-beam_max_jumps"].value,
    jump_range = settings.startup["PeronsalTeslaDefenseSetting-beam_jump_range"].value,
    fork_chance = settings.startup["PeronsalTeslaDefenseSetting-beam_fork_chance"].value,
    fork_chance_per_quality = settings.startup["PeronsalTeslaDefenseSetting-beam_fork_chance_per_quality"].value,
    beam_duration = settings.startup["PeronsalTeslaDefenseSetting-beam_duration"].value
  }

  local beam_base_damage = settings.startup["PeronsalTeslaDefenseSetting-beam_base_damage"].value
  local chain_base_damage = settings.startup["PeronsalTeslaDefenseSetting-beam_fork_base_damage"].value

  -- from active-triggers.lua
  data:extend({
      _make_tesla_chain_lightning_chain("chain-personal-tesla-defense-chain", "chain-personal-tesla-defense-beam-bounce", beam_config)
  })
  -- unexported global functions from beams.lua
  data:extend(
  {
      make_tesla_beam("chain-personal-tesla-defense-beam-start", true, beam_base_damage), --30 for gun and 120 for turret
      make_tesla_beam_chain("chain-personal-tesla-defense-beam-bounce", true, chain_base_damage)--30 for gun and 120 for turret
  })
end