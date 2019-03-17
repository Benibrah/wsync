-- WorldSync (wsync) Lua-file
-- Made by Benibrah (on GitHub)

-- Variables
print("Enter city name")
local PLACE = io.read()

--------------------------weather---------------------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card

-- Utility function which returns weather data
getWeather = function()
  -- Get API data from OpenWeathermap.org (Calls are limited per hour)
  local request = web.request("http://api.openweathermap.org/data/2.5/weather?q="..PLACE.."&units=metric&APPID=389f7c63dde7b6827ce720d61c4a8237")
  local data = json.decode(request())
  return data
end

--Initialize variable once
weatherStatus = ""

--Set new weather if it changed
setWeather = function(oldStatus)
  --Comparison of old/new value
  local newWeather = getWeather()["weather"][1]["main"]
  if oldStatus ~= newWeather then
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

--------------------------time------------------------------------------------------------------------------------------------


--------------------------Execution-------------------------------------------------------------------------------------------

while true do
  setWeather(weatherStatus)
  os.sleep(5)
end


