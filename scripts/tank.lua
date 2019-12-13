x = peripheral.wrap("back")

while true do

t = x.getTanks()[1].amount
term.clear()
term.setCursorPos(1,1)
print("Oil Level")

print(t,".. /576000")
os.sleep(5)
end
