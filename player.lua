player = {}

--this is where we set atributes of the player
function player.load()
   player.x = 10
   player.y = 10
   player.width = 10
   player.height = 10
   player.xvel = 0
   player.yvel = 0
   player.accel = 1000
   player.friction = 200
   player.maxspeed = 200
   player.xsign = 0
   player.ysign = 0
end

--this is where the player is drawn from
function player.draw()
   love.graphics.setColor(255,0,0)
   love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
end

--this is where the physics are handled
function player.physics(dt)
   player.x = player.x + player.xvel * dt
   player.y = player.y + player.yvel * dt

   player.xsign = player.xvel > 0 and 1 or player.xvel < 0 and -1 or 0;
   player.ysign = player.yvel > 0 and 1 or player.yvel < 0 and -1 or 0;

   player.xvel = math.floor(player.xvel - player.friction * dt * player.xsign)
   player.yvel = math.floor(player.yvel - player.friction * dt * player.ysign)
end

--this is where the movement is handled
function player.move(dt)
   if love.keyboard.isDown("d") and
   player.xvel < player.maxspeed then
      player.xvel = math.ceil(player.xvel + player.accel * dt)
   end

   if love.keyboard.isDown("a") and
   player.xvel > -player.maxspeed then
      player.xvel = math.ceil(player.xvel - player.accel * dt)
   end

   if love.keyboard.isDown("s") and
   player.yvel < player.maxspeed then
      player.yvel = math.ceil(player.yvel + player.accel * dt)
   end

   if love.keyboard.isDown("w") and
   player.yvel > -player.maxspeed then
      player.yvel = math.ceil(player.yvel - player.accel * dt)
   end
end

--functions are put here to be easily managaed in the main file
function player.LOAD()
   player.load()
end

function player.UPDATE(dt)
   player.physics(dt)
   player.move(dt)
end

function player.DRAW()
   player.draw()
   love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
   love.graphics.print("vel-x: "..player.xvel, 10, 30)
   love.graphics.print("vel-y: "..player.yvel, 10, 40)
end
