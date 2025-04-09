local love = require("love")

function Laser(x, y, angle, debugging)
	debugging = debugging or false

	local LASER_SPPED = 1000
	local opacity = 1

	return {
		x = x,
		y = y,
		draw = function(self, faded)
			love.graphics.setColor(186 / 255, 189 / 255, 182 / 255, opacity)
			love.graphics.rectangle("fill", self.x, self.y, 5, 5)

			-- if debugging then
			-- 	love.graphics.setColor(1, 0, 0)
			-- 	love.graphics.circle("line", self.x, self.y, self.radius)
			-- 	love.graphics.setColor(1, 1, 1)
			-- end
		end,
		move = function(self, dt)
			self.x = self.x + LASER_SPPED * math.cos(angle) * dt
			self.y = self.y - LASER_SPPED * math.sin(angle) * dt

			-- make sure the ship can't go off screen on x axis
			if self.x < 0 then
				-- delete this instance of laser
			elseif self.x > love.graphics.getWidth() then
			end

			-- make sure the ship can't go off screen on y axis
			if self.y < 0 then
			elseif self.y > love.graphics.getHeight() then
			end
		end,
	}
end

return Laser
