farmtest.lua

local rowSize = 7
local colSize = 7
local turnLeft = true
local skipMove = false

function goHome()
   local r,c
   turtle.turnLeft()
   turtle.turnLeft()
   for c=1,colSize-1 do
      turtle.forward()
   end
   turtle.turnLeft()
   for r=1,rowSize-1 do
      turtle.forward()
   end
   turtle.turnLeft()
   turtle.back()

function harvestRow()
   local c
   for c=1,colSize do
      if skipMove == true then
         skipMove = false
      else
         turtle.forward()
      end

      turtle.digDown()
   end
end

--
-- Move and orient turtle onto next row
--
function nextRow()
   if turnLeft == true then
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
      turnLeft = false
   else
      turtle.turnRight()
      turtle.forward()
      turtle.turnRight()
      turnLeft = true
   end
   skipMove = true
end

--
-- Call to start farming
--
function harvestField()
   local r
   for r=1,rowSize do
      harvestRow()

      -- go to next row unless its the last
      if r~=colSize then
         nextRow()
      end
   end
   goHome()
end