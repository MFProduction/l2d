---@diagnostic disable: lowercase-global
local love = require("love")

local Game = require("states/Game")

local Player = require("Player")

function love.load()
	love.mouse.setVisible(false)
	mouse_x, mouse_y = 0, 0

	local show_debugging = true

	player = Player(show_debugging)
	game = Game()
end
function love.keyreleased(key)
	if key == "w" or key == "up" or key == "kp8" then
		player.thrusting = false
	elseif key == "escape" then
		if game.state.running then
			game:changeGameState("paused")
		elseif game.state.paused then
			game:changeGameState("running")
		end
	end
end
function love.update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
	if game.state.running then
		player:move()
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("kp8") then
			player.thrusting = true
		end
	end
end

function love.draw()
	if game.state.paused or game.state.running then
		love.graphics.print("Hello World", 400, 300)
		player:draw()
		game.draw(game.state.paused)
	end

	love.graphics.setColor(1, 1, 1, 1)
end
