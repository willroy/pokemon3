local mapREQ = require("src/core/map")
local paletteREQ = require("src/core/palette")

local tileSheetNames = {"interior_electronics","interior_flooring","interior_general","interior_misc","interior_misc2","interior_stairs","interior_tables","interior_walls","outside_buildings","outside_ground","outside_items","outside_misc","outside_rocks","outside_vegetation","text"}
local tileSheets = {
   ["interior_electronics"] = love.graphics.newImage("assets/tilesheets/interior-electronics.png"),
   ["interior_flooring"] = love.graphics.newImage("assets/tilesheets/interior-flooring.png"),
   ["interior_general"] = love.graphics.newImage("assets/tilesheets/interior-general.png"),
   ["interior_misc"] = love.graphics.newImage("assets/tilesheets/interior-misc.png"),
   ["interior_misc2"] = love.graphics.newImage("assets/tilesheets/interior-misc2.png"),
   ["interior_stairs"] = love.graphics.newImage("assets/tilesheets/interior-stairs.png"),
   ["interior_tables"] = love.graphics.newImage("assets/tilesheets/interior-tables.png"),
   ["interior_walls"] = love.graphics.newImage("assets/tilesheets/interior-walls.png"),
   ["outside_buildings"] = love.graphics.newImage("assets/tilesheets/outside-buildings.png"),
   ["outside_ground"] = love.graphics.newImage("assets/tilesheets/outside-ground.png"),
   ["outside_items"] = love.graphics.newImage("assets/tilesheets/outside-items.png"),
   ["outside_misc"] = love.graphics.newImage("assets/tilesheets/outside-misc.png"),
   ["outside_rocks"] = love.graphics.newImage("assets/tilesheets/outside-rocks.png"),
   ["outside_vegetation"] = love.graphics.newImage("assets/tilesheets/outside-vegetation.png"),
   ["text"] = love.graphics.newImage("assets/tilesheets/text.png")
}

palette = Palette:new()
map = Map:new()

Game = {}

function Game:new(o)
   local o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Game:init(mainX, mainY, project, new)
   self.project = project or "project1"

   if new then
      if self.project == "" then self.project = "New-Project" end
      self:save()
   end

   palette:init(1, 40, 38, 224, mainY-40, tileSheets["outside_buildings"], "outside_buildings")

   map:init(1, 38, 38, mainX-40, mainY-32)
   map:load(self.project)

   self.selectedTileSheet = 0
end

function Game:update(dt)
   palette:update(dt)
   map:update(dt)
end

function Game:draw()
   map:draw(dt)
   palette:draw(dt)
end

function Game:mousepressed(x, y, button, istouch)
   palette:mousepressed(x, y, button, istouch)
   map:mousepressed(x, y, button, istouch)
end

function Game:mousereleased(x, y, button, istouch)
   palette:mousereleased(x, y, button, istouch)
   map:mousereleased(x, y, button, istouch)
end

function Game:keypressed(key, code)
   if key == "escape" then
      self:save()
      setCurrent("menu")
   end

   -- if key == "s" then self:save() end
   -- if key == "l" then self:load() end
   if key == "right" and self.selectedTileSheet < #tileSheetNames then
      self.selectedTileSheet = self.selectedTileSheet + 1
      palette:setTileSheet(tileSheets[tileSheetNames[self.selectedTileSheet]],tileSheetNames[self.selectedTileSheet])
   end
   if key == "left" and self.selectedTileSheet > 1 then
      self.selectedTileSheet = self.selectedTileSheet - 1
      palette:setTileSheet(tileSheets[tileSheetNames[self.selectedTileSheet]],tileSheetNames[self.selectedTileSheet])
   end

   palette:keypressed(key, code)
   map:keypressed(key, code)
end

function Game:wheelmoved(x, y)
   palette:wheelmoved(x, y)
   map:wheelmoved(x, y)
end

function Game:save()
   map:save(self.project)
end

function Game:load()
   map:load(self.project)
end

function Game:setFolder(project)
   self.project = project
end