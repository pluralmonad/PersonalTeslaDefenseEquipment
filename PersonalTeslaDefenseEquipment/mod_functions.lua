local util = require("__core__/lualib/util")

local mod_functions = {}

--#region private functions
--TODO: parse the setting string and set dimensions using parsed values
local function _grid_size_setting_to_shape(grid_size_setting)
    --default is 2X2
    local shape =
    {
      width = 2,
      height = 2,
      type = "full"
    }
    if grid_size_setting == "1X1" then
        shape.width=1
        shape.height=1
    elseif grid_size_setting == "3X3" then
        shape.width=3
        shape.height=3
    elseif grid_size_setting == "4X4" then
        shape.width=4
        shape.height=4
    elseif grid_size_setting == "5X5" then
        shape.width=5
        shape.height=5
    end

    return shape
end

local function _compute_buffer_capacity(energy_consumption)
    -- original personal laser defense had energy_consumption = 50KJ and buffer_capacity = 220KJ
    -- let's preserve this ratio (4.4:1) since I am not sure of a better one
    return math.ceil(energy_consumption * 4.4)
end

local function _chain_and_beam(beam_type)
    -- start with our custom names and update if we are not configured for custom beam
    local chain_and_beam = {
        chain = "chain-personal-tesla-defense-chain",
        beam = "chain-personal-tesla-defense-beam-start"
    }

    if beam_type == "turret" then
        local target_effects = util.table.deepcopy(data.raw["electric-turret"]["tesla-turret"].attack_parameters.ammo_type.action.action_delivery.target_effects)
        chain_and_beam.chain = target_effects[1].action.action_delivery.chain
        chain_and_beam.beam = target_effects[2].action.action_delivery.beam
    elseif beam_type == "gun" then
        local target_effects = util.table.deepcopy(data.raw["ammo"]["tesla-ammo"].ammo_type.action.action_delivery.target_effects)
        chain_and_beam.chain = target_effects[1].action.action_delivery.chain
        chain_and_beam.beam = target_effects[2].action.action_delivery.beam
    end

    return chain_and_beam
end
--#endregion private functions

--#region modules public interface
function mod_functions.grid_size_setting_to_shape(grid_size_setting)
    return _grid_size_setting_to_shape(grid_size_setting)
end

function mod_functions.compute_buffer_capacity(energy_consumption)
    return _compute_buffer_capacity(energy_consumption)
end

function mod_functions.chain_and_beam(beam_type)
    return _chain_and_beam(beam_type)
end
--#endregion modules public interface

return mod_functions