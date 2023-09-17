Map = {}

local grid = love.graphics.newImage("assets/grid.png")

function Map:new(o)
   local o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Map:init(id, x, y, width, height)
   self.id = id or 0
   self.x = x or 0
   self.y = y or 0
   self.width = width or 0
   self.height = height or 0
   self.backColor = {1,1,1}

   self.gridQuad = love.graphics.newQuad(0, 0, self.width, self.height, grid)

   self.tileSheets = self:newTileSheet()
end

function Map:update(dt)
end

function Map:draw()
   love.graphics.setColor(1,1,1)
   love.graphics.draw(grid, self.gridQuad, self.x, self.y)

   for sheet, tiles in pairs(self.tileSheets) do
      for i = 1, #tiles["tiles"] do
         local quad = tiles["tiles"][i]["quad"]
         local x = tiles["tiles"][i]["x"]
         local y = tiles["tiles"][i]["y"]
         love.graphics.draw(tiles["image"], quad, x, y)
      end 
   end
end

function Map:mousepressed(x, y, button, istouch)
end

function Map:mousereleased(x, y, button, istouch)
end

function Map:keypressed(key, code)
end

function Map:wheelmoved(x, y)
end

function Map:load()
   local file = "/home/will-roy/dev/pokemon3/pokemon/db/tiles.snorlax"
   local f = io.open(file, "r")
   if f then f:close() end
   if f == nil then return false end

   local newTileSheets = self:newTileSheet()

   local currentSheet = ""
   for line in io.lines(file) do
      if string.sub(line, 1, 1) == "=" then
         currentSheet = string.sub(line, 3, line:len())
      else
         local lineSplit = {}
         for str in string.gmatch(line, "([^,]+)") do
            table.insert(lineSplit, str)
         end

         local quadX = lineSplit[1]
         local quadY = lineSplit[2]
         local quadW = lineSplit[3]
         local quadH = lineSplit[4]
         local x = lineSplit[5]
         local y = lineSplit[6]

         newTileSheets[currentSheet]["tiles"][#newTileSheets[currentSheet]["tiles"]+1] = {
            ["quad"]=love.graphics.newQuad(lineSplit[1], lineSplit[2], lineSplit[3], lineSplit[4], newTileSheets[currentSheet]["image"]),
            ["quadX"]=lineSplit[1], 
            ["quadY"]=lineSplit[2],
            ["quadW"]=lineSplit[3], 
            ["quadH"]=lineSplit[4], 
            ["x"]=lineSplit[5], 
            ["y"]=lineSplit[6]
         }
      end
   end

   self.tileSheets = newTileSheets
end

function Map:newTileSheet()
   return {
      ["interior_electronics"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-electronics.png"), ["tiles"]={}},
      ["interior_flooring"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-flooring.png"), ["tiles"]={}},
      ["interior_general"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-general.png"), ["tiles"]={}},
      ["interior_misc"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-misc.png"), ["tiles"]={}},
      ["interior_misc2"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-misc2.png"), ["tiles"]={}},
      ["interior_stairs"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-stairs.png"), ["tiles"]={}},
      ["interior_tables"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-tables.png"), ["tiles"]={}},
      ["interior_walls"] = {["image"]=love.graphics.newImage("assets/tilesheets/interior-walls.png"), ["tiles"]={}},
      ["outside_buildings"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-buildings.png"), ["tiles"]={}},
      ["outside_ground"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-ground.png"), ["tiles"]={}},
      ["outside_items"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-items.png"), ["tiles"]={}},
      ["outside_misc"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-misc.png"), ["tiles"]={}},
      ["outside_rocks"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-rocks.png"), ["tiles"]={}},
      ["outside_vegetation"] = {["image"]=love.graphics.newImage("assets/tilesheets/outside-vegetation.png"), ["tiles"]={}}
   }
end