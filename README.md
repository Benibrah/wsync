# wsync
WorldSync Lua software for OpenComputers (Minecraft Mod)

Sync your local time and weather with Minecraft!

[Wsync]
1. After start you get prompted to input your City name. After submitting, the Ingame weather cycle gets set to "false"
2. Weather gets set according to your local weather. CommandFeedback in the Chat get's deactivated.
3. Time gets set (Uses your IP to determine position)
4. Time gets updated every 10 minutes and Weather updates every 6 minutes
5. To End press CTRL + Alt + C

[Uninstall]
1. Simply delete wsync.lua like this -> del wsync.lua
2. Run following commands to reset gamerules:
  /doWeatherCycle true
  /doTimeCycle true
  /sendCommandFeedback true
3. Finished! Everything should work like before
