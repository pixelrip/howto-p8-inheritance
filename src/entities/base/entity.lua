-- Base Entity Class
Entity = {}
Entity.__index = Entity

function Entity.new(opts)
    local opts = opts or {}
    local self = setmetatable({}, Entity)
    
    -- Core Properties
    self.x = opts.x or 0
    self.y = opts.y or 0
    self.w = opts.w or 0
    self.h = opts.h or 0
    
    return self
end

-- Core Methods
-- Sets up all entities to have these methods available

function Entity:update() end
function Entity:draw() end
function Entity:destroy() end
