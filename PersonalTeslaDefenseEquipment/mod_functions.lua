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
    local beam_entity = {}
    if beam_type == "turret" then
        beam_entity = data.raw["electric-turret"]["tesla-turret"].attack_parameters
    else -- gun
        beam_entity = data.raw["ammo"]["tesla-ammo"]
    end
    local target_effects = util.table.deepcopy(beam_entity.ammo_type.action.action_delivery.target_effects)

    return {
        chain = target_effects[1].action.action_delivery.chain,
        beam = target_effects[2].action.action_delivery.beam
    }
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