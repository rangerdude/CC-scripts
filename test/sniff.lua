-- sniff for messages

while rednet.isOpen("left") do

local id, message, protocol = rednet.receive()
print(id,message,protocol)


end
