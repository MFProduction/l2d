function love.load()
	jack = {
		x = 0,
		t = 0,
		sprite = love.graphics.newImage("sprites/jack.png"),
	}
	SPX, SPY = 5352, 569
	QUAD_W = 669
	QUAD_H = SPY
	quads = {}
	for i = 1, 8, 1 do
		quads[i] = love.graphics.newQuad(QUAD_W * (i - 1), 0, QUAD_W, QUAD_H, SPX, SPY)
	end
end

function love.update(dt) end

function love.draw()
	love.graphics.scale(0.3)
	love.graphics.draw(jack.sprite, quads[1], jack.x, jack.y)
end
