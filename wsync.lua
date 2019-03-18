-- WorldSync (wsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.luas as well as following components:
-- - Internet Card
-- - Debug Card

-- Variables
print("Enter city name")
local PLACE = io.read()

--------------------------weather---------------------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card

--Utility function which returns weather data
getWeather = function()
  -- Get API data from OpenWeathermap.org (Calls are limited per hour)
  local request = web.request("http://api.openweathermap.org/data/2.5/weather?q="..PLACE.."&units=metric&APPID=389f7c63dde7b6827ce720d61c4a8237")
  local data = json.decode(request())
  return data
end

--Initial Status
weatherStatus = ""

--Set new weather if it changed
setWeather = function()
  --Comparison of old/new value
  local newWeather = getWeather()["weather"][1]["main"]
  if newWeather ~= weatherStatus then
    weatherStatus = newWeather
    
    --Setting actual weather
    if weatherStatus == "Rain" or weatherStatus == "Drizzle" then
      debug.runCommand("weather rain")
    elseif weatherStatus == "Thunderstorm" then
      debug.runCommand("weather thunder")
    else
      debug.runCommand("weather clear")
    end
  end
end

--------------------------Execution-------------------------------------------------------------------------------------------

function start()
  while true do
    setWeather()
    os.sleep(360)
  end
end


