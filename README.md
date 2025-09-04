# How To: Inheritance in PICO-8

This repository demonstrates a common method for achieving class-like inheritance in PICO-8 Lua using metatables. The project is a simple PICO-8 cartridge where a `Player` object and several `Enemy` objects inherit common properties and methods from a base `Entity` object.

The code here expands on the examples in [How to Create Class-Like Objects and Constructors in PICO-8](https://github.com/pixelrip/howto-p8-constructor), which may provide additional useful context.


## Prerequisites

1. **Pico-8** - Install from [lexaloffle.com](https://www.lexaloffle.com/pico-8.php)
2. **Python 3.4+** - Required for picotool
3. **picotool** - Install from [GitHub](https://github.com/dansanderson/picotool)
3. **Git** (recommended) - For version control

## Quick Start

   ```bash
   ./scripts/build.sh
   ```
   Load `inheritance.p8` in Pico-8 and run it.


## Project Structure

```
project/
├── .vscode                # VS Code settings
├── src/                   # Source code
│   ├── main.lua           # Entry point with _init, _update, _draw
│   ├── entities/
│   │   ├── base/entity.lua # The "base class"
│   │   ├── player.lua     # The "subclass"
│   │   └── enemy.lua      # Another "subclass"
│   └── utils/
│       └── log.lua        # Logging utility
├── assets/                
│       ├── audio.p8       # Audio Data
│       └── sprites.p8     # Spritesheet Data
├── build/                 # Generated files (dev/prod builds)
├── scripts/               # Build automation
└── docs/                  # Documentation
```

## How This Demonstrates Inheritance in Lua
Lua doesn't have built-in classes like Java or C++, but it provides a powerful mechanism called metatables that allows us to simulate them. This project uses **metatables** to create an inheritance chain.

### 1. The Base "Class": `Entity`

The `src/entities/base/entity.lua` file defines our base object. It's a simple Lua table with a new function that acts as a constructor. It establishes the properties that all of our game objects will share: `x`, `y`, `w` (width), and `h` (height). It also defines placeholder methods like `update` and `draw` that we expect its children to implement.

### 2. The "Subclass": `Player` and `Enemy`

The `Player` and `Enemy` objects act as our subclasses. They "inherit" from `Entity`. The magic happens with this line:

```lua
-- src/entities/player.lua
setmetatable(Player, {__index = Entity})
```

This tells Lua: "When looking for a key (a function or property) in the `Player` table, if you can't find it, look for it in the `Entity` table instead." This links `Player` to `Entity`, forming the basis of our inheritance.


### 3. The Constructor Chain

Inside the `Player.new` constructor, we first create a base `Entity` instance and then mold it into a `Player` by setting its metatable and adding player-specific properties like `speed`.

```lua
-- src/entities/player.lua
function Player.new(opts)
    -- 1. Create the base entity:
    local self = Entity.new({
        x = opts.x or 0,
        y = opts.y or 0,
        w = Player.W,
        h = Player.H
    })

    -- 2. Turn it into a Player:
    setmetatable(self, Player)

    -- 3. Add Player-specific properties:
    self.speed = opts.speed or Player.SPEED

    return self
end
```

Now, an instance of `Player` has its own `speed` property, but it can also access the `x` and `y` properties and the `update` and `draw` methods established by Entity.


## A Note on Composition over Inheritance

While **inheritance** is a powerful tool, it's worth knowing about its alternative: **composition**.

- **Inheritance** creates an "is-a" relationship (e.g., "a `Player` is an `Entity`").

- **Composition** creates a "has-a" relationship (e.g., "a `Player` has a `position`" and "a `Player` has a `sprite`").

For larger games, many developers prefer composition because it's more flexible. However, there's a ton to unpack with composition, so we'll save that for another day.