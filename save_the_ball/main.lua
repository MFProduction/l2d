local enemy = require("Enemy")
local button = require("Button")

math.randomseed(os.time())

local game = {
	dificulty = 1,
	state = {
		menu = true,
		paused = false,
		running = false,
		ended = false,
	},
	points = 0,
	levels = { 3, 15, 30, 60, 120 },
}
local player = {
	radius = 20,
	x = 30,
	y = 30,
}

local buttons = {
	menu_state = {},
	ended_state = {},
}

local enemies = {}

local fonts = {
	medium = {
		font = love.graphics.newFont(16),
		size = 16,
	},
	massive = {
		font = love.graphics.newFont(60),
		size = 60,
	},
	big = {
		font = love.graphics.newFont(24),
		size = 24,
	},
}

function changeGameState(state)
	game.state["menu"] = state == "menu"
	game.state["running"] = state == "running"
	game.state["paused"] = state == "paused"
	game.state["ended"] = state == "ended"
end
function startNewGame()
	changeGameState("running")
	game.points = 0
	enemies = {
		enemy(1),
	}
end

function love.load()
	love.mouse.setVisible(false)
	buttons.menu_state.play_button = button("Play Game", startNewGame, nil, 120, 40)
	buttons.menu_state.setting_button = button("Settings", nil, nil, 120, 40)
	buttons.menu_state.quit_button = button("Quit Game", love.event.quit, nil, 120, 40)

	buttons.ended_state.play_button = button("Replay Game", startNewGame, nil, 120, 40)
	buttons.ended_state.setting_button = button("Menu", changeGameState, "menu", 120, 40)
	buttons.ended_state.quit_button = button("Quit Game", love.event.quit, nil, 120, 40)
end

function love.update(dt)
	player.x, player.y = love.mouse.getPosition()
	if game.state["running"] then
		for i = 1, #enemies do
			if not enemies[i]:checkTouched(player) then
				enemies[i]:move(player)

				for j = 1, #game.levels, 1 do
					if math.floor(game.points) == game.levels[j] then
						table.insert(enemies, 1, enemy(game.dificulty * (j + 1)))
						game.points = game.points + 1
					end
				end
			else
				changeGameState("ended")
			end
		end
		game.points = game.points + dt
	end

	if love.mouse.isDown(1) then
		if not game.state["running"] then
			if game.state["menu"] then
				for index in pairs(buttons.menu_state) do
					buttons.menu_state[index]:check_pressed(player.x, player.y, player.radius)
				end
			end
			if game.state["ended"] then
				for index in pairs(buttons.ended_state) do
					buttons.ended_state[index]:check_pressed(player.x, player.y, player.radius)
				end
			end
		end
	end
end

function love.draw()
	love.graphics.setFont(fonts.medium.font)
	love.graphics.printf(
		"FPS" .. love.timer.getFPS(),
		fonts.medium.font,
		10,
		love.graphics.getHeight() - 10,
		love.graphics.getWidth()
	)
	if game.state["running"] then
		love.graphics.printf(math.floor(game.points), fonts.big.font, 0, 10, love.graphics.getWidth(), "center")
		for i = 1, #enemies do
			enemies[i]:draw()
		end
		love.graphics.circle("fill", player.x, player.y, player.radius)
	elseif game.state["menu"] then
		buttons.menu_state.play_button:draw(20, 20, 10, 20)
		buttons.menu_state.setting_button:draw(20, 80, 10, 20)
		buttons.menu_state.quit_button:draw(20, 140, 10, 20)
	elseif game.state["ended"] then
		buttons.ended_state.play_button:draw(20, 20, 10, 20)
		buttons.ended_state.setting_button:draw(20, 80, 10, 20)
		buttons.ended_state.quit_button:draw(20, 140, 10, 20)
		love.graphics.printf("Game over", fonts.massive.font, 0, 10, love.graphics.getWidth(), "center")
	end
	if not game.state["running"] then
		love.graphics.circle("fill", player.x, player.y, player.radius / 2)
	end
end
