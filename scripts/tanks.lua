term.clear()
term.setCursorPos(1,1)

while true do

x = peripheral.wrap("front")
	

   t1n = "Fuel  ."
 	  t1 = x.getTanks()[1].amount
	term.setCursorPos(1,2)
  	t2 = x.getTanks()[2].amount
   t2n = x.getTanks()[2].name	
 term.setCursorPos(1,3)
	  t3 = x.getTanks()[3].amount


    term.setCursorPos(5,1)
    print("ENG 1   .")
    term.setCursorPos(5,2)
    term.clearLine()
    print(t1n,t1)
    term.clearLine()
    term.setCursorPos(5,3)
    term.clearLine()
    print(t2n,t2)
    term.setCursorPos(5,4)
    term.clearLine()
    print("risdue", t3)


end
