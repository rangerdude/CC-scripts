
start = gps.locate()


function plant()

print(start)

	for i=1,5 do
	turtle.forward()
	turtle.digDown()
	turtle.select(3)
	turtle.placeDown()
    end

dofile("goto.lua" start)

end

plant()
