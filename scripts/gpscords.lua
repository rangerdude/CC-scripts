-- rednet.open("back")
-- id = os.computerID()
l = os.computerLabel()
peripheral.find("modem", rednet.open)
rednet.host(l,"ranger")

-- for i = 1,3 do
	-- startup write coords to file
	print ("saving gps for")
	local x, y, z=gps.locate(5)
	local coords={
	["x"]=x,
	["y"]=y,
	["z"]=z,
	}
	local f=fs.open("/gpscords" , "a")
	f.write(textutils.serialise(coords))
	f.close()
-- end	
rednet.broadcast(id,l ,textutils.serialise(coords))



