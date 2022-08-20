function love.load()
  arenaWidth = 800
  arenaHeight = 600
  
  shipX = arenaWidth / 2
  shipY = arenaHeight / 2
  shipAngle = 0
  shipSpeedX = 0
  shipSpeedY = 0
  shipRadius = 30
  
  bullets = {}
  bulletTimerLimit = 0.5
  bulletTimer = bulletTimerLimit
  
  asteroids = {
    {
      x = 100,
      y = 100
    },
    {
      x = arenaWidth - 100,
      y = 100
    },
    {
      x = arenaWidth / 2,
      y = arenaHeight - 100
    }
  }
end

function love.update(dt)
  local turnSpeed = 10
  
  if love.keyboard.isDown('right') then
    shipAngle = shipAngle + turnSpeed * dt
  end
  
  if love.keyboard.isDown('left') then
    shipAngle = shipAngle - turnSpeed * dt
  end
  
  shipAngle = shipAngle % (2 * math.pi)
  
  if love.keyboard.isDown('up') then
    local shipSpeed = 100
    shipSpeedX = shipSpeedX + math.cos(shipAngle) * shipSpeed * dt
    shipSpeedY = shipSpeedY + math.sin(shipAngle) * shipSpeed * dt
  end
  
  shipX = (shipX + shipSpeedX * dt) % arenaWidth
  shipY = (shipY + shipSpeedY * dt) % arenaHeight
  
  for bulletIndex = #bullets, 1, -1 do
    local bullet = bullets[bulletIndex]
    
    bullet.timeLeft = bullet.timeLeft - dt
    
    if bullet.timeLeft <= 0 then
      table.remove(bullets, bulletIndex)
    else
      local bulletSpeed = 500
      bullet.x = (bullet.x + math.cos(bullet.angle) * bulletSpeed * dt)
        % arenaWidth
      bullet.y = (bullet.y + math.sin(bullet.angle) * bulletSpeed * dt)
        % arenaHeight
    end
  end
  
  bulletTimer = bulletTimer + dt
  
  if love.keyboard.isDown('s') then
    if bulletTimer >= bulletTimerLimit then
      bulletTimer = 0
      
      table.insert(bullets, {
        x = shipX + math.cos(shipAngle) * shipRadius,
        y = shipY + math.sin(shipAngle) * shipRadius,
        angle = shipAngle,
        timeLeft = 4
      })
    end
  end
end

function love.draw()
  for y = -1, 1 do
    for x = -1, 1 do
      love.graphics.origin()
      love.graphics.translate(x * arenaWidth, y * arenaHeight)
      
      love.graphics.setColor(0, 0, 1)
      love.graphics.circle('fill', shipX, shipY, shipRadius)
      
      local shipCircleDistance = 20
      love.graphics.setColor(0, 1, 1)
      love.graphics.circle(
        'fill',
        shipX + math.cos(shipAngle) * shipCircleDistance,
        shipY + math.sin(shipAngle) * shipCircleDistance,
        5
      )
      
      for bulletIndex, bullet in ipairs(bullets) do
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle('fill', bullet.x, bullet.y, 5)
      end
      
      for asteroidIndex, asteroid in ipairs(asteroids) do
        love.graphics.setColor(1, 1, 0)
        love.graphics.circle('fill', asteroid.x, asteroid.y, 80)
      end
    end
  end
end