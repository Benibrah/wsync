-- WorldSync (wsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.lua as well as following components:
-- - Internet Card
-- - Debug Card

--------------------------weather---------------------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card

-- Input
print("Name of your city:")
local city = io.read()

-- Deactivate Ingame weather cycle
debug.runCommand("gamerule doWeatherCycle false")

-- Weather changing function
local setWeather = function()
    --Getting weather
    local request = web.request("http://api.openweathermap.org/data/2.5/weather?q="..city.."&units=metric&APPID=389f7c63dde7b6827ce720d61c4a8237")
    local data = json.decode(request())
    local status = data["weather"][1]["main"]

    -- Setting Weather
    if status == "Rain" or status == "Drizzle" then
        debug.runCommand("weather rain 360")
    elseif status == "Thunderstorm" then
        debug.runCommand("weather thunder 360")
    else
        debug.runCommand("weather clear 360")
    end
end

-----------------------------time--------------------------------------------------------------------------------------------

-- Map real time to ingame time
local mapTime = function(h)
    return ((h-6)/(24))*24000 % 24000
end

-- Ingame time cycle gets deactivated
debug.runCommand("gamerule doDaylightCycle false")

-- Deactivates nasty chat messages from commands
debug.runCommand("gamerule sendCommandFeedback false")

local setTime = function()
    -- Get time through IP based location
    local timeData = web.request("http://worldtimeapi.org/api/ip")
    local timeTable = json.decode(timeData())

    -- Get exact hour
    local hour = string.sub(timeTable["datetime"],12,13)

    -- Set time
    debug.runCommand("time set " .. tonumber(string.format("%18.0f", mapTime(hour))))
end


--------------------------Execution-------------------------------------------------------------------------------------------
while true do
    setWeather()
    setTime()
    os.sleep(300)
    print("Updated Time & Weather")
end

