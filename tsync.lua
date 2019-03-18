-- TimeSync (tsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.lua as well as following components:
-- - Internet Card
-- - Debug Card

------------------------------------------------time----------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card
local thread = require("thread")

os.execute("echo 'tsync.lua'>.shrc")

--Map real time to ingame time
mapTime = function(t)
  return ((t-6)/(24))*24000 % 24000
end

-- Ingame time Cycle gets deactivated
debug.runCommand("gamerule doDaylightCycle false")

--Deactivates nasty chat messages from commands
debug.runCommand("gamerule sendCommandFeedback false")   

print("Started TSync, wait some seconds then press CTRL + ALT + C to continue")
t = thread.create(function()
  while true do
    --Get Time data from IP
    local timeData = web.request("http://worldtimeapi.org/api/ip")
    local timeTable = json.decode(timeData())
    
    --Get exact hour
    local hour = string.sub(timeTable["datetime"],12,13)
        
    --Sets time
    debug.runCommand("time set " .. tonumber(string.format("%18.0f", mapTime(hour))))
       
    --Wait   
    os.sleep(3)
  end
end)
