-- * Platform maker 1.2
-- * Made by: Acuena
-- * Usage: platform length width
 
-- Variables
curslot = 2
fuelused = 0
blocksplaced = -1
totalnrblocks = 0
 
-- Functions
 
function moveforward()
        while not turtle.forward() do
                checkfuel()
        end
end
 
function moveback()
        while not turtle.back() do
                checkfuel()
        end
end
 
function checkfuel()
        if turtle.getFuelLevel() < 1 then
                turtle.select(1)
                if not turtle.refuel(1) then
                        print("No fuel in slot 1, awaiting fuel")
                        while not turtle.refuel(1) do
                        end
                        print("Successfully refueld, continuing")
                end
                fuelused = fuelused + 1
                turtle.select(curslot)
        end
end
 
function turnright()
        turtle.turnRight()
        moveforward()
        turtle.turnRight()
end
 
function turnleft()
        turtle.turnLeft()
        moveforward()
        turtle.turnLeft()
end
 
function checkblockcount()
        if turtle.getItemCount(curslot) == 0 then
                selnextslot()
        end
end
 
function selnextslot()
        curslot = curslot + 1
        if curslot > 16 then
                print("Out of blocks, terminating")
                error()
        end
        turtle.select(curslot)
end
 
function place()
        checkblockcount()
        turtle.placeDown()
        blocksplaced = blocksplaced + 1
end
 
function countblocks()
        for i = 2,16 do
                turtle.select(i)
                totalnrblocks = totalnrblocks + turtle.getItemCount(i)
        end
        if not totalnrblocks == 0 then
                totalnrblocks = totalnrblocks + 1
        end
        turtle.select(curslot)
end
 
function returntostart()
        if orient == true then
                turtle.turnRight()
                for i = 1, width - 1 do
                        moveforward()
                end
                turtle.turnRight()
                moveback()
            elseif orient == false then
                turtle.turnLeft()
                for i = 1, width - 1 do
                        moveforward()
                end
                turtle.turnRight()
				for i = 1, length do
					turtle.back()
				end
        end
end
 
-- Code
 
local args = {...}
orient=false
if #args ~= 2 then
        print("Usage: platform length width")
        return
end
 
length = tonumber(args[1])
width = tonumber(args[2])
 
countblocks()
need = length * width
 
if need > 960 then
        print("Unable to carry more than 960 block's")
        print("A platform with the size of:")
        print(length.."x"..width.." will need "..need.." blocks")
        print("Aborting run")
        error()
end
 
if totalnrblocks < need then
        print("Not enough blocks, aborting")
        print("Need: "..need)
        print("Have: "..totalnrblocks.." block's")
        error()
end
 
moveforward()
place()
for xx = 1,width - 1  do
        for x = 1, length-1 do
        moveforward()
        place()
end
 
if orient == false then -- Should turn right
        turnright()
        place()
else -- Should turn left
        turnleft()
        place()
end
orient = not orient
end
for x = 1, length-1 do
        moveforward()
        place()
end
print("Orient: "..tostring(orient))
returntostart()
print("Platform done")
print("Block's placed: "..blocksplaced)
print("Fuel used: "..fuelused)