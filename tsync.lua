-- TimeSync (tsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.lua as well as following components:
-- - Internet Card
-- - Debug Card

------------------------------------------------time----------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card

--Get Time data from IP
local timeData = web.request("http://worldtimeapi.org/api/ip")
local timeTable = json.decode(timeData())

local timeString timeTable["datetime"]

function start()
end
