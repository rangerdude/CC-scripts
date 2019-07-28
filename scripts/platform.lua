function getInventoryCount ()
  inventoryCount = 0

  for slot = 1, 16 do
    inventoryCount = inventoryCount
      + turtle.getItemCount(slot)
  end

  return inventoryCount
end

function scanForItem ()
  for slot = 1, 16 do
    if turtle.getItemCount(slot) > 0 then
      turtle.select(slot)

      return true
    end
  end

  return false
end

function getItem ()
  while not scanForItem() do
    print("Need more items")
    print("Press any key when ready...")
    io.read()
  end
end

function buildRow (rowLength)
  for i = 1, rowLength do
    getItem()
    turtle.placeDown()

    if i < rowLength then
      repeat until turtle.forward()
    end
  end
end

function buildPlatform (rows, rowLength)
  for i = 1, rows do
    buildRow(rowLength)

    if i < rows then
      if i % 2 == 1 then
        turtle.turnLeft()
        repeat until turtle.forward()
        turtle.turnLeft()
      else
        turtle.turnRight()
        repeat until turtle.forward()
        turtle.turnRight()
      end
    end
  end
end

-- Get dimensions
term.setCursorPos(1, 1)
term.clear()
print "Platform Builder v0.1 (C) LayZee 2013"

term.write("Row length: ")
local rowLength = tonumber(io.read())

term.write("Number of rows: ")
local rows = tonumber(io.read())

local itemsNeeded = rows * rowLength
local itemsInInventory = getInventoryCount()

while itemsInInventory < itemsNeeded do
  print("Need " .. itemsNeeded - itemsInInventory
    .. " additional items to build platform")
  print("Press any key when ready...")
  io.read()

  itemsInInventory = getInventoryCount()
end

buildPlatform(rows, rowLength)