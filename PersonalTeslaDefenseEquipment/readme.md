# Why this exists

I wanted a powerful personal defense equipment and really like the new tesla weapons. So I decided to build my first official mod.

# What it does

- This mod adds a copy of the personal laser defense equipment that shoots the same beam/weapon as the tesla turret.

- The recipe for the equipment is set based on what technology requirement you select in settings. This seemed like a simple implementation that wouldn't inflate the mod settings too much.

# Configurables

The following settings are exposed through the Mod Settings interface in-game. All settings are "start-up" settings unless otherwise noted.

### Tech Requirement
Which technology will unlock the Personal Tesla Defense
- none (default)
- personal-laser-defense-equipment
- tesla-weapons

### Beam type
Whether to use the tesla turret or tesla gun beam
- tesla-turret (default)
- tesla-gun

NOTE: this dramatically changes the damage output. If tesla-turret is too OP for your play style, try setting it to tesla-gun.

### Equipment Grid Size
The space the equipment will take up in the equipment grid
- 1X1
- 2X2 (default)
- 3X3
- 4X4
- 5X5

NOTE: Increasing the size of an existing save using the equipment will produce equipment overlap until you remove and replace the equipment.

### Range
Set the effective range for the Personal Tesla Defense
- any integer value (default=30)

### Damage Modifier
Set the damage modifier for the Personal Tesla Defense
- any double value >= 0.1 (default=1.0)

### Energy Consumption
Amount of energy consumed per shot (in kJ)
- any integer value >= 1 (default=50)

NOTE: this scales the internal "buffer_capacity" to maintain the original personal laser defense ratio (4.4 buffer_capacity:1 energy_consumption)

### Shot Cooldown
The number of ticks before the equipment will shoot again
- any integer >= 20 (default 120)

# Notes

- Graphics/icons are terrible. I am a GIMP novice :)

- There is little or no runtime overhead as it uses only things already built into the game (UPS friendly).

- It has not been extensively tested, but shouldn't break much, if anything, as it only adds and does not modify any entities.

- You should be able to add it to an existing save without issue and I see no reason why it wouldn't work in multiplayer.

- I'm surprised it was this easy. Kudos to the Factorio devs for an amazingly extensible piece of software.

# Conflicts / Bugs

I took care to not replace or update anything existing, only adding components. Should not conflict with anything.

# Future Plans

- Maybe create a custom beam type to take control of all the control values, like number of jumps, fork chance, etc.

- Better graphics.

- Translations.

- Open to suggestions.