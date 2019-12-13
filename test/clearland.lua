local function refuel()
	if turtle.getFuelLevel() < 10 then
		turtle.select(16)
		turtle.refuel(1)
	end
end

local function moveForward()
	repeat
		turtle.dig()
	until turtle.forward()
end

local function clear()
	local z = 0
	if turtle.detectUp() then
		while turtle.detectUp() do
			repeat
				turtle.digUp()
			until turtle.up()
			z = z + 1
		end
		repeat
			turtle.down()
			z = z - 1
			if z < 0 then
				repeat
					turtle.up()
					z = z + 1
				until z == 0
			end
		until z == 0
	end
end

local function test()
	turtle.select(15)
	if turtle.detectDown() then
		turtle.digDown()
	end
	if not turtle.placeDown() then
		turtle.digDown()
		turtle.down()
		turtle.digDown()
		turtle.select(14)
		turtle.placeDown()
		turtle.up()
	end
	turtle.digDown()
end

print("How wide is this foundation?")
x = tonumber(read())
print("How long?")
y = tonumber(read())
print("Please place fuel in slot 16, two torches in slot 15, and dirt/stone in 14. Press any key to start.")
sleep(0)
os.pullEvent("key")

x = x - 1
y = math.floor(y / 2)

refuel()
turtle.turnLeft()
turtle.digUp()
turtle.up()
for i = 1, x / 2 do
	test()
	clear()
	moveForward()
	refuel()
end
turtle.turnLeft()
turtle.turnLeft()
for i = 1, x do
	test()
	clear()
	moveForward()
	refuel()
end

for i = 1, y + 0.5 do
	turtle.turnLeft()
	test()
	clear()
	moveForward()
	refuel()
	turtle.turnLeft()
	for i = 1, x do
		test()
		clear()
		moveForward()
		refuel()
	end
	turtle.turnRight()
	test()
	clear()
	moveForward()
	refuel()
	turtle.turnRight()
	for i = 1, x do
		test()
		clear()
		moveForward()
		refuel()
	end
end

test()
clear()