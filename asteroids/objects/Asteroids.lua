local love = require("love")

function Asteroid(x, y, size, level, debugging)
	debugging = debugging or false

	local ASTEROID_VERT = 10
	local ASTEROID_JAG = 0.4
	local ASTEROID_SPEED = math.random(50) + (level * 2)
	local vel = -1
	if math.random() < 0.5 then
		vel = 1
	end

	local vert = math.ceil(math.random(ASTEROID_VERT + 1) + ASTEROID_VERT / 2)
	local offset = {}
	for i = 1, vert + 1, 1 do
		table.insert(offset, math.random() * ASTEROID_JAG * 2 + 1 - ASTEROID_JAG)
	end

	return {
		x = x,
		y = y,
		x_vel = math.random() * ASTEROID_SPEED * vel,
		y_vel = math.random() * ASTEROID_SPEED * vel,
		radius = math.ceil(size / 2),
		vert = vert,
		offset = offset,
		angle = math.rad(math.random(math.pi)),
		draw = function(self, faded)
			local opacity = 1
			if faded then
				opacity = 0.5
			end

			love.graphics.setColor(186 / 255, 189 / 255, 182 / 255, opacity)
			local points = {
				self.x + self.radius * self.offset[1] * math.cos(self.angle),
				self.y + self.radius * self.offset[1] * math.sin(self.angle),
			}

			for i = 1, vert - 1, 1 do
				table.insert(
					points,
					self.x + self.radius * self.offset[i + 1] * math.cos(self.angle + i * math.pi * 2 / self.vert)
				)
				table.insert(
					points,
					self.y + self.radius * self.offset[i + 1] * math.sin(self.angle + i * math.pi * 2 / self.vert)
				)
			end

			love.graphics.polygon("line", points)

			if debugging then
				love.graphics.setColor(1, 0, 0)
				love.graphics.circle("line", self.x, self.y, self.radius)
				love.graphics.setColor(1, 1, 1)
			end
		end,
		move = function(self, dt)
			self.x = self.x + self.x_vel * dt
			self.y = self.y + self.y_vel * dt

			-- make sure the ship can't go off screen on x axis
			if self.x + self.radius < 0 then
				self.x = love.graphics.getWidth() + self.radius
			elseif self.x - self.radius > love.graphics.getWidth() then
				self.x = -self.radius
			end

			-- make sure the ship can't go off screen on y axis
			if self.y + self.radius < 0 then
				self.y = love.graphics.getHeight() + self.radius
			elseif self.y - self.radius > love.graphics.getHeight() then
				self.y = -self.radius
			end
		end,
	}
end

return Asteroid
