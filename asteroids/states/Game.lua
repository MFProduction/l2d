local Text = require("../components/text")
function Game()
	return {
		state = {
			menu = false,
			running = true,
			paused = false,
			ended = false,
		},
		changeGameState = function(self, state)
			self.state.menu = state == "menu"
			self.state.running = state == "running"
			self.state.paused = state == "paused"
			self.state.ended = state == "ended"
		end,

		draw = function(self, faded)
			love.graphics.printf("test2", 200, 200, 200, "center")
			if faded == true then
				Text(
					"PAUSED",
					0,
					love.graphics.getHeight() * 0.4,
					"h1",
					false,
					false,
					love.graphics.getWidth(),
					"center"
				):draw()
			end
		end,
	}
end

return Game
