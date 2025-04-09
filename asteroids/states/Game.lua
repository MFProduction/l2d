local love = require("love") -- we now require love

local Text = require("../components/Text") -- we are adding text
local Asteroids = require("../objects/Asteroids")

function Game()
	_G.asteroids = {}
	_G.lasers = {}
	return {
		state = {
			menu = false,
			paused = false,
			running = true,
			ended = false,
		},
		level = 1,

		changeGameState = function(self, state)
			self.state.menu = state == "menu"
			self.state.paused = state == "paused"
			self.state.running = state == "running"
			self.state.ended = state == "ended"
		end,

		-- we create the basics of the draw function
		draw = function(self, faded)
			if faded then
				Text(
					"PAUSED",
					0,
					love.graphics.getHeight() * 0.4,
					"h1",
					false,
					false,
					love.graphics.getWidth(),
					"center",
					1
				):draw()
			end
		end,
		startNewGame = function(self, player, show_debbuging)
			self:changeGameState("running")
			-- local as_x = math.floor(math.random(love.graphics.getWidth()))
			-- local as_y = math.floor(math.random(love.graphics.getHeight()))
			-- table.insert(asteroids, 1, Asteroids(as_x, as_y, 100, self.level, true))
			for i = 1, 10, 1 do
				local as_x = math.floor(math.random(love.graphics.getWidth()))
				local as_y = math.floor(math.random(love.graphics.getHeight()))
				table.insert(asteroids, i, Asteroids(as_x, as_y, 100, self.level, show_debbuging))
			end
		end,
	}
end

return Game

