function love.load()
  shipX = 800 / 2
  shipY = 600 / 2
  shipAngle = 0
  shipSpeedX = 0
  shipSpeedY = 0
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
  
  shipX = shipX + shipSpeedX * dt
  shipY = shipY + shipSpeedY * dt
end

function love.draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.circle('fill', shipX, shipY, 30)
  
  local shipCircleDistance = 20
  love.graphics.setColor(0, 1, 1)
  love.graphics.circle(
    'fill',
    shipX + math.cos(shipAngle) * shipCircleDistance,
    shipY + math.sin(shipAngle) * shipCircleDistance,
    5
  )
  
  -- Temporary
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(table.concat({
    'shipAngle: '..shipAngle,
    'shipX: '..shipX,
    'shipY: '..shipY,
    'shipSpeedX: '..shipSpeedX,
    'shipSpeedY: '..shipSpeedY
  }, '\n'))
end