local love = require("love")

local Player = require("objects/Player")
local Laser = require("objects/Laser")
local Game = require("states/Game")
-- local Laser = require("objects/Laser")

math.randomseed(os.time())
function love.load()
	_G.lasers = {}
	love.mouse.setVisible(false)
	mouse_x, mouse_y = 0, 0

	local show_debugging = true

	player = Player(show_debugging)
	game = Game()
	game:startNewGame(player, show_debugging)
end

-- KEYBINDINGS --
function love.keypressed(key)
	if game.state.running then -- only accept this if the game state is running
		if key == "w" or key == "up" or key == "kp8" then
			player.thrusting = true
		end

		if key == "space" then
			table.insert(lasers, 1, Laser(player.x, player.y, player.angle, true))
		end
		-- allows us to pause the game
		if key == "escape" then
			game:changeGameState("paused")
		end
	elseif game.state.paused then -- if game is paused
		if key == "escape" then -- allows us to unpause
			game:changeGameState("running")
		end
	end
end

function love.keyreleased(key)
	if key == "w" or key == "up" or key == "kp8" then
		player.thrusting = false
	end
end

function love.update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()

	if game.state.running then -- only execute below if game is running
		player:movePlayer()
		for _, ast in pairs(asteroids) do
			ast:move(dt)
		end
		for _, l in pairs(lasers) do
			l:move(dt)
		end
	end
end

function love.draw()
	-- only do the below if it's paused or running state
	if game.state.running or game.state.paused then
		player:draw(game.state.paused)
		for _, val in pairs(asteroids) do
			val:draw(game.state.paused)
		end
		for _, laser in pairs(lasers) do
			laser:draw(game.state.paused)
		end

		game:draw(game.state.paused) -- we can now draw the paused screen
	end

	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.print(love.timer.getFPS(), 10, 10)
end
