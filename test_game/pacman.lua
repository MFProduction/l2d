function love.load()
	_G.number = 0
	love.graphics.setBackgroundColor(0.5, 0.5, 1)
	_G.pacman = {}
	pacman.x = 200
	pacman.y = 250

	_G.food = {}
	food.x = 600
	food.eten = false
end

function love.update(dt)
	number = number + 1
	-- pacman.x = pacman.x + 1
	if love.keyboard.isDown("d") then
		pacman.x = pacman.x + 1
	end
	if love.keyboard.isDown("a") then
		pacman.x = pacman.x - 1
	end
	if love.keyboard.isDown("w") then
		pacman.y = pacman.y - 1
	end
	if love.keyboard.isDown("s") then
		pacman.y = pacman.y + 1
	end

	if pacman.x >= food.x then
		food.eaten = true
	end
end

function love.draw()
	love.graphics.print(number)
	if not food.eaten then
		love.graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", food.x, 250, 100, 100)
	end
	love.graphics.setColor(250, 250, 0)
	love.graphics.arc("fill", pacman.x, pacman.y, 60, 1, 5)
	--	love.gra
end
