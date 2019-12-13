term.clear()
term.setCursorPos(1, 1)

repeat
print("Enter tunnel length (even digit): ")
tunnellength = read()
until tunnellength % 2 == 0

term.clear()
term.setCursorPos(1, 1)

print("Place Fuel in Slot 1")
print("Enter number for fuel type: ")
print("")
print("No Fuel Required = 0")
print("Coal/Charcoal/Peat = 1")
print("Coal Coke = 2")
print("Biofuel Can = 3 **")
print("Coalfuel Can = 4 **")
print("** Ensure these work in your version")
fueltype = read()

function fueltypeset()
if fueltype == "1" then
fueltype = 80
elseif fueltype == "2" then
fueltype = 160
elseif fueltype == "3" then
fueltype = 520
elseif fueltype == "4" then
fueltype = 1520
end
end
fueltypeset()
term.clear()
term.setCursorPos(1, 1)

print("Drop mined cobblestone? 0=No, 1=Yes")
cobblesetting = read()
term.clear()
term.setCursorPos(1, 1)
if cobblesetting == "1" then
if turtle.getItemCount(2) < 1 then
print("Place 1 cobblestone in Slot 2")
print("")
end
end

print("Place torches? 0=No, 1=Yes")
print("Place torches in Slot 3")
torchsetting = read()
term.clear()
term.setCursorPos(1, 1)
if torchsetting == "1" then
if turtle.getItemCount(3) < tunnellength/4 then
print("Warning: You will not have enough torches for entire tunnel length.")
print("")
print("")
end
end


print("Return and deposit items to chest if inventory nears full?")
print("0=No, 1=Yes")
returnsetting  = read()
term.clear()
term.setCursorPos(1, 1)
if returnsetting == "1" then
print("Place chest immediately behind turtle.")
print("")
end

print("Deposit inventory into chest upon completion?")
print("0=No, 1=Yes")
dcomplete  = read()
term.clear()
term.setCursorPos(1, 1)
if dcomplete == "1" then
print("Place chest immediately behind turtle.")
print("")
end

print("Terminate program once length is reached?")
print("Note: This will prevent the turtle from depositing items into a chest upon completion.")
print("0=No, 1=Yes")
tcomplete  = read()
term.clear()
term.setCursorPos(1, 1)
if tcomplete == "1" then
	if dcomplete == "1" then
	print("Turtle will NOT deposit items upon completion.")
 print("")
end
end

print("")
print("Begin mining?")
print("0=Cancel Program, Any Key=Yes")
beginmine = read()
if beginmine == "0" then
os.reboot()
end

term.clear()
term.setCursorPos(1,1)
if tcomplete == "1" then
  print("Tunneling " .. tunnellength .. " blocks, then terminating.")
  elseif tcomplete == "0" then
  print("Tunneling " .. tunnellength .. " blocks, then returning.")
end
sleep(2)

torchpos = 0

function progress()
term.setCursorPos(1,3)
print("Progress: " .. torchpos .. " of " .. tunnellength)
end

function fuelcheck()
	if turtle.getFuelLevel() ~= "unlimited" then
		if turtle.getFuelLevel()/fueltype < 0.26 then
		turtle.select(1)
		turtle.refuel(1)
		end
	end
end

function dropcobble()
    local stackSize = turtle.getItemCount(2)
	if cobblesetting == "1" then
		if turtle.getFuelLevel() ~= "unlimited" then
			if stackSize > 2 then
		        stackSize = stackSize-1
		        turtle.select(2)
		        turtle.drop(stackSize)
    			end
		elseif turtle.getFuelLevel() == "unlimited" then
			if stackSize > 2 then
		        	stackSize = stackSize-1
			        turtle.select(2)
			        turtle.drop(stackSize)
    				end
			turtle.select(1)
			if turtle.compareTo(2) then
				turtle.drop()
				end

			end
		end
end


function minewallRight()
fuelcheck()
turtle.select(1)
turtle.dig()
moveforward()
turtle.digUp()
turtle.digDown()
turtle.turnRight()
moveforward()
turtle.digDown()
turtle.digUp()
moveforward()
turtle.digDown()
turtle.digUp()
turtle.turnLeft()
torchpos = torchpos + 1
progress()
end

function minewallLeft()
fuelcheck()
turtle.select(1)
turtle.dig()
moveforward()
turtle.digUp()
turtle.digDown()
turtle.turnLeft()
moveforward()
turtle.digDown()
turtle.digUp()
moveforward()
turtle.digDown()
turtle.digUp()
turtle.turnRight()
torchpos = torchpos + 1
progress()
end

function minecycle()
for z = 1, tunnellength/2 do
minewallRight()
minewallLeft()
placetorch()
end
end

function placetorch()
	if torchsetting == "1" then
		if torchpos % 4 == 0 then
		turtle.turnLeft()
		turtle.dig()
		turtle.select(3)
		turtle.place()
		turtle.turnRight()
		dropcobble()
		fuelcheck()
		fullinventory()
		turtle.select(1)
		end
	else
		if torchpos % 4 == 0 then
		dropcobble()
		fuelcheck()
		fullinventory()
		turtle.select(1)
		end
	end
end

function moveforward()
while not turtle.forward() do
sleep(0.25)
turtle.dig()
end
end

function turtlehome()
for y = 1, tunnellength do
fuelcheck()
moveforward()
end
end


function fullinventory()
local invcount = 0
	if returnsetting == "1" then
		for c = 4, 16 do
			if turtle.getItemCount(c) > 0 then
			invcount = invcount+1
			end
		end
		if invcount > 12 then
			turtle.turnLeft()
			turtle.turnLeft()
			fuelcheck()
			for f = 1, torchpos+1 do
			moveforward()
			fuelcheck()
			end
			for d = 4, 16 do
			turtle.select(d)
			turtle.dropDown()
			end
			turtle.turnLeft()
			turtle.turnLeft()
			fuelcheck()
			for f = 1, torchpos+1 do
			moveforward()
			fuelcheck()
			end
			invcount = 0
		else
			invcount = 0
		end
	end
end

function depositcomplete()
	if dcomplete == "1" then
		for d = 1, 16 do
			turtle.select(d)
			turtle.drop()
		end
	end
end

function terminatecomplete()
	if tcomplete =="1" then
		turtle.down()
		os.reboot()
  sleep(3)
	end
end

fuelcheck()
turtle.digUp()
turtle.up()
minecycle()
terminatecomplete()
turtle.turnLeft()
turtle.turnLeft()
fuelcheck()
turtlehome()
turtle.down()
depositcomplete()
turtle.turnRight()
turtle.turnRight()
term.setCursorPos(1,5)
print("Mining Successful")
term.setCursorPos(1,7)