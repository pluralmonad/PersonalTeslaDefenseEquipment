data:extend({
    {
        name = "PeronsalTeslaDefenseSetting-tech_requirement",
        setting_type = "startup",
        type = "string-setting",
        default_value = "none",
        allowed_values = 
        {
            "none",
            "personal-laser-defense-equipment",
            "tesla-weapons"
        },
        order = "a1"
    },
    {
        name = "PeronsalTeslaDefenseSetting-beam_type",
        setting_type = "startup",
        type = "string-setting",
        default_value = "turret",
        allowed_values = 
        {
            "turret",
            "gun"
        },
        order = "a2"
    },
    {
        name = "PeronsalTeslaDefenseSetting-grid_size",
        setting_type = "startup",
        type = "string-setting",
        default_value = "2X2",
        allowed_values = 
        {
            "1X1",
            "2X2",
            "3X3",
            "4X4",
            "5X5"
        },
        order = "a3"
    },
    {
        name = "PeronsalTeslaDefenseSetting-range",
        setting_type = "startup",
        type = "int-setting",
        default_value = 30,
        order = "b1"
    },
    {
        name = "PeronsalTeslaDefenseSetting-damage_modifier",
        setting_type = "startup",
        type = "double-setting",
        default_value = 1,
        -- I don't know what zero or tiny numbers would do here so cut off at 0.1
        minimum_value = 0.1,
        order = "b2"
    },
    {
        name = "PeronsalTeslaDefenseSetting-energy_consumption",
        setting_type = "startup",
        type = "int-setting",
        default_value = 50,
        minimum_value = 1,
        order = "b3"
    },
    {
        name = "PeronsalTeslaDefenseSetting-shot_cooldown",
        setting_type = "startup",
        type = "int-setting",
        default_value = 120,
        minimum_value = 20,
        order = "b4"
    }
 })