-- WorldSync (wsync) Lua-file
-- Made by Benibrah (on GitHub)
-- To use this you need json.lua as well as following components:
-- - Internet Card
-- - Debug Card

--------------------------weather---------------------------------------------------------------------------------------------

local web = require("internet") -- Load Internet lib
local json = require("json") -- Load JSON module
local debug = require("component").debug -- Get debug card
local thread = require("thread") -- Load Thread API for background process

-- Input
print("Name of your city:")
local city = io.read()


-- Weather changing function
local setWeather = function(status)
  if status == "Rain" or status == "Drizzle" then
    debug.runCommand("weather rain 360")
  elseif status == "Thunderstorm" then
    debug.runCommand("weather thunder 360")
  else
     debug.runCommand("weather clear 360")
  end
  print("City recognized! Setting weather")
  print("Press CTRL+ALT+C to continue")
end

--------------------------Execution-------------------------------------------------------------------------------------------

--Create thread to run in background
thread.create(function()
    while true do
      local request = web.request("http://api.openweathermap.org/data/2.5/weather?q="..city.."&units=metric&APPID=389f7c63dde7b6827ce720d61c4a8237")
      local data = json.decode(request())
      local status = data["weather"][1]["main"]
      setWeather(status)
      os.sleep(360)
    end
  end)
