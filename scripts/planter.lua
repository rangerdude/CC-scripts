
start = gps.locate()


function plant()

print(start)

	for i=1,25 do
	turtle.forward()
	turtle.digDown()
	turtle.select(3)
	turtle.placeDown()
    end

end

plant()
