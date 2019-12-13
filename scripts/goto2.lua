-- Wireless Miner Turtle GPS goto program

local tArgs = {...}
local x = tonumber(tArgs[1])
local y = tonumber(tArgs[3])
local z = tonumber(tArgs[2])
local dirs = string
local dir, disx, disy, disz = 0, 0, 0, 0
local height, forward = 0, 0
local ox, oy, oz = 0, 0, 0

if #tArgs < 3 or #tArgs > 3 then
 print( "Usage: <Program> <x> <z> <y>" )
 return
end

function fuellevel()
 fuel = turtle.getFuelLevel()
 if fuel == "unlimited" then
  print("Fuel Level: Unlimited")
  return true
 end
 if fuel > 79 then
  print("Fuel Level: "..tostring(fuel))
  return true
 else
  print("Fuel Level: Low")
  print("Please refuel Turtle")
  return false
 end
end

function calc()
-- Getting current location
-- Original x (ox)...
 ox, oy, oz = gps.locate(3)
-- Solving for distance by subtracting new location from current location
-- Distance x (disx)...
 disx = ox - x
 disy = oy - y
 disz = oz - z
 getdir()
end

function getdir()
-- Solving for what direction the turtle is faceing
 if turtle.detect() == true then
  if not turtle.back() then
   print( "Please remove block in front or back of turtle" )
   sleep(5)
   os.reboot()
  else
-- When forward = 1, means the turtle went backwards
   forward = 1
-- Getting new GPS location
-- Directional new x (dnx) ...
   dnx, dny, dnz = gps.locate(3)
   sleep(0.2)
   turtle.forward()
   sleep(0.2)
  end
 else
-- When forward = 0, means the turtle went forwards
  forward = 0
  turtle.forward()
-- Getting new GPS location
-- Directional new x (dnx) ...
  dnx, dny, dnz = gps.locate(3)
  sleep(0.2)
  turtle.back()
  sleep(0.2)
 end
-- Solving direction by subtracting directional x/y from original x/y
-- Directional curent x (dcx)...
 dcx = ox - dnx
 dcz = oz - dnz
-- If the diferances in dcx or dcz are negative/Positive and if the turtle went backwards/forwards determins the direction
-- Direction (dir) and Direction String (dirs)
 if dcx > 0 then
  if forward == 0 then
   dirs = "West"
   dir = 1
  else
   dirs = "East"
   dir = 3
  end
 end
 if dcx < 0 then
  if forward == 0 then
   dirs = "East"
   dir = 3
  else
   dirs = "West"
   dir = 1
  end
 end
 if dcz > 0 then
  if forward == 0 then
   dirs = "North"
   dir = 2
  else
   dirs = "South"
   dir = 0
  end
 end
 if dcz < 0 then
  if forward == 0 then
   dirs = "South"
   dir = 0
  else
   dirs = "North"
   dir = 2
  end
 end
end

function tryfwd()
 while turtle.detect() == true do
  tryup()
  turtle.up()
  height = height + 1
 end
end

function dobck()
 while not turtle.back() do
  tryup()
  turtle.up()
  height = height + 1
 end
end

function tryup()
 if turtle.detectUp() == true then
  turtle.digUp()
 end
end

function trydwn()
 if turtle.detectDown() == true then
  turtle.digDown()
 end
end

function updown()
-- If distance y is a neagtive number then make it positive
-- Modified Distance Y (mdisy)...
 if disy < 0 then
  mdisy = disy * -1
  for a = 1, mdisy do
   tryup()
   turtle.up()
  end
 end
 if disy > 0 then
  for b = 1, disy do
   trydwn()
   turtle.down()
  end
 end
end

-- This block of code determins how far to go and what direction to go, baised off of what direction the turtle is facing,
-- and if disx/disy/disz is positive or negative
function move()
-- If facing West (1)
 if dir == 1 then
  updown()
  if disx < 0 then
   mdisx = disx * -1
   for c = 1, mdisx do
    dobck()
   end
  end
  if disx > 0 then
   for d = 1, disx do
    tryfwd()
    turtle.forward()
   end
  end
  if disz < 0 then
   mdisz = disz * -1
   turtle.turnLeft()
   for e = 1, mdisz do
    tryfwd()
    turtle.forward()
   end
  end
  if disz > 0 then
   turtle.turnRight()
   for f = 1, disz do
    tryfwd()
    turtle.forward()
   end
  end
 end
-- If facing North (2)
 if dir == 2 then
  updown()
  if disz < 0 then
   mdisz = disz * -1
   for i = 1, mdisz do
    dobck()
   end
  end
  if disz > 0 then
   for j = 1, disz do
    tryfwd()
    turtle.forward()
   end
  end
  if disx < 0 then
   mdisx = disx * -1
   turtle.turnRight()
   for k = 1, mdisx do
    tryfwd()
    turtle.forward()
   end
  end
  if disx > 0 then
   turtle.turnLeft()
   for l = 1, disx do
    tryfwd()
    turtle.forward()
   end
  end
 end
-- If facing East (3)
 if dir == 3 then
  updown()
  if disx < 0 then
   mdisx = disx * -1
   for o = 1, mdisx do
    tryfwd()
    turtle.forward()
   end
  end
  if disx > 0 then
   for p = 1, disx do
    dobck()
   end
  end
  if disz < 0 then
   mdisz = disz * -1
   turtle.turnRight()
   for q = 1, mdisz do
    tryfwd()
    turtle.forward()
   end
  end
  if disz > 0 then
   turtle.turnLeft()
   for r = 1, disz do
    tryfwd()
    turtle.forward()
   end
  end
 end
 -- If facing South (0)
 if dir == 0 then
  updown()
  if disz < 0 then
   mdisz = disz * -1
   for u = 1, mdisz do
    tryfwd()
    turtle.forward()
   end
  end
  if disz > 0 then
   for v = 1, disz do
    dobck()
   end
  end
  if disx < 0 then
   mdisx = disx * -1
   turtle.turnLeft()
   for w = 1, mdisx do
    tryfwd()
    turtle.forward()
   end
  end
  if disx > 0 then
   turtle.turnRight()
   for aa = 1, disx do
    tryfwd()
    turtle.forward()
   end
  end
 end
-- If the turtle had to go up because of an obstacle this will make the turtle go down to it's destination
 for ab = 1, height do
  trydwn()
  turtle.down()
 end
end

--rednet.open("left")
rednet.broadcast("going")
term.clear()
term.setCursorPos(1, 1)
if fuellevel() == true then
 calc()
 sleep(0.2)
 print("Facing: "..dirs)
 print("Distance: X = "..disx..", Z = "..disz..", Y = "..disy)
 print("")
 sleep(0.2)
 move()
-- Checking if the program was successful
-- Destination x (dx)...
 dx, dy, dz = gps.locate(3)
 if dx == x and dy == y and dz == z then
  print("Have arrived at "..x..", "..z..", "..y )
 else
  print("Something went wrong, try again")
  os.reboot() 
 end
end

os.version()
print( "exit" )
