-- VLA decoder for Opus OS
-- Decodes "global_message" events and sends raw data as an virtual modem

local Event = require("opus.event")

local stub = function() end
local dev = {
  isOpen = function() return true end,
  isWireless = function() return true end,
  name = "modem",
  side = "global",
  type = "modem",
}
setmetatable(dev, {__index = function() return stub end})

_G.device["modem_global"] = dev

Event.on("global_message", function(event, chan, reply, msg, meta)
  os.queueEvent("modem_message", "global", chan, reply, msg, -1)
end)

print("Decoding \"global_message\" into a virtual modem")
print("Use the Sniff.lua app, config to use the \"global\" modem")

Event.pullEvents()