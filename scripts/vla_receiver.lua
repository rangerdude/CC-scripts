local modem = peripheral.find("modem", function(n,o) return o.isWireless() end)
local origin = nil
local toid = 31415
modem.open(toid)

local function printHeader(str, ny)
	local w, h = term.getSize()
	local x, y = term.getCursorPos()
	term.setCursorPos(math.ceil(w/2) - math.floor(#str/2), ny or 1)
	term.clearLine()
	term.write(str)
	term.setCursorPos(x, y)
end

local function select_caster()
	print("Scanning for casters")

	local pingmsg = "Cast_Ping"
	local origins = {}
	local timeout = os.startTimer(1)

	modem.transmit(0, 0, pingmsg)
	while true do
		local event, side, chan, reply, msg = os.pullEvent()
		if event == "modem_message" and chan == toid and type(msg) == "table" and msg.origin and msg.senderChannel == 0 and msg.replyChannel == 0 and msg.dimension and type(msg.message) == "string" and msg.message == pingmsg then
			origins[#origins+1] = msg.origin
		elseif event == "timer" and side == timeout then break
		end
	end

	if #origins == 0 then return false
	elseif #origins == 1 then return origins[1]
	end

	local sel = 1
	while true do
		term.clear()
		term.setCursorPos(1,1)
		term.write("Select a caster")
		for i = 1, #origins do
			term.setCursorPos(1, i+2)
			term.write(("%s%s%s"):format(i==sel and "[" or " ", origins[i], i==sel and "]" or " "))
		end
		local event, char = os.pullEvent("key")
		if char == keys.up then sel = sel-1
		elseif char == keys.down then sel = sel+1
		elseif char == keys.enter then break
		end
		sel = math.max(1, math.min(#origins, sel))
	end
	return origins[sel]
end

term.setTextColor(colors.yellow)
if not origin then
	origin = select_caster()
	if not origin then
		error("No casters found", 0)
	end
end

term.clear()
term.setCursorPos(1, 3)
while true do
	printHeader("Connected to", 1)
	printHeader(origin, 2)
	local event, side, chan, reply, msg = os.pullEvent()
	if event == "modem_message" then
		if chan == toid and type(msg) == "table" and msg.origin == origin and msg.senderChannel and msg.replyChannel and msg.message and msg.dimension then
			os.queueEvent("global_message", msg.senderChannel, msg.replyChannel, msg.message, msg.senderDistance)
		end
	elseif event == "key" then
		if side == keys.q then sleep(0) return
		elseif side == keys.c then
			origin = select_caster() or origin
			term.clear()
			term.setCursorPos(1, 3)
		end
	end
end