-- TimeSync (tsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.lua as well as following components:
-- - Internet Card
-- - Debug Card

------------------------------------------------time----------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card

--Map real time to ingame time
mapTime = function(t)
  return ((t-6)/(24))*24000 % 24000
end

function start()
  while true do
    
    --Get Time data from IP
    local timeData = web.request("http://worldtimeapi.org/api/ip")
    local timeTable = json.decode(timeData())
    
    --Get exact hour
     local hour = string.sub(timeTable["datetime"],12,13)
     
    debug.runCommand("set time " .. tonumber(string.format("%18.0f", mapTime(hour))))
    os.sleep(10)
  end
end
