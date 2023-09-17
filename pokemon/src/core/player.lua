local characters = love.graphics.newImage("assets/characters.png")
local character = {
	["front"] = love.graphics.newQuad(206, 0, 28, 42, characters),
	["frontWalk"] = love.graphics.newQuad(296, 0, 30, 42, characters),
	["back"] = love.graphics.newQuad(236, 0, 28, 42, characters),
	["backWalk"] = love.graphics.newQuad(328, 0, 28, 42, characters),
	["left"] = love.graphics.newQuad(266, 0, 28, 42, characters),
	["leftWalk"] = love.graphics.newQuad(358, 0, 28, 42, characters),
	["right"] = love.graphics.newQuad(266, 0, 28, 42, characters),
	["rightWalk"] = love.graphics.newQuad(358, 0, 28, 42, characters)
}

Player = {}

function Player:new(o)
	local o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Player:init(x, y)
	self.x = x or 0
	self.y = y or 0
end

function Player:update(dt)
end

function Player:draw()
	love.graphics.draw(characters, character["back"], self.x, self.y)
end

function Player:mousepressed(x, y, button, istouch)
end

function Player:mousereleased(x, y, button, istouch)
end

function Player:keypressed(key, code)
end

function Player:wheelmoved(x, y)
end