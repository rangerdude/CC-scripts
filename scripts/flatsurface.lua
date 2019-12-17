-- Area Flatten Script 1.4 by oneupe1even of OmegaTEK Industries on the OniTech server

-- Variables

local tArgs = {...}

if #tArgs == 0 then 
  print("Usage: flat [length] [width] [flags]") 
  return
else
  length = tonumber(tArgs[1])
  width = tonumber(tArgs[2])
end

local turnFlag

if tArgs[3] == "right" then
  turnFlag = true
elseif tArgs[3] == "left" then
  turnFlag = false
end

-- Functions

local function tFuel(amount) -- By Guude
  if turtle.getFuelLevel() < 5 then
    turtle.select(16)
    turtle.refuel(amount)
    turtle.select(1)
  end
end

local function digMove()
  if turtle.detect() then
    repeat
      turtle.dig()
      sleep(.25)
    until turtle.detect() == false
    tFuel(1)
    turtle.forward()
  else
    tFuel(1)
    turtle.forward()
  end
end

local function checkTop()
  if turtle.detectUp() then
    repeat
      tFuel(1)
      repeat
        turtle.digUp()
        sleep(.25)
      until turtle.detectUp() == false
      turtle.up()
    until turtle.detectUp() == false
    repeat
      tFuel(1)
      turtle.down()
    until turtle.detectDown()
  end
end

local function uTurn()
  for i = 1, 2 do
    turtle.turnRight()
  end
end

local function checkBottom()
  if turtle.detectDown() == false then
    turtle.placeDown()
  end
end

local function mineLine()
  for i = 1, length do
    tFuel(1)
    digMove()
    checkTop()
    checkBottom()
  end
end

-- Main Script

for i = 1, width do
  mineLine()
  if turnFlag then
    turtle.turnRight()
    digMove()
    checkTop()
    checkBottom()
    turtle.turnRight()
    turnFlag = false
  else
    turtle.turnLeft()
    digMove()
    checkTop()
    checkBottom()
    turtle.turnLeft()
    turnFlag = true
  end
end