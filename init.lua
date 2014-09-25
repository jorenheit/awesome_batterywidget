local wibox = require("wibox")
local timer = timer
local io = io
local string = string
local tonumber = tonumber
module ("batterywidget")


local batterywidget = wibox.widget.textbox()
local batterywarning = {false, false}
local function updateBatteryWidget() 

   p1 = io.popen("acpi | cut -d: -f 2 | cut -d, -f 1 | sed 's|\ ||'")
   p2 = io.popen("acpi | cut -d: -f 2 | cut -d, -f 2 | sed 's|\ ||'")
   
   state = p1:read("*l")
   level = p2:read("*l")
   io.close(p1)
   io.close(p2)
   
   if level and state then
      txt = " | " .. level .. " (" .. state .. ") |";
      batterywidget:set_text(txt)
   else
      return 
   end
   
   if state == "Charging" then
      batterywarning = {false, false}
   else
      lev = tonumber(string.sub(level, 1, string.find(level, "%%") - 1));
      if lev < 20 and not batterywarning[2] then
	 naughty.notify({text = "Warning: Battery Critical", timeout = 0, 
			 bg = "#FF0000", fg = "#FFFFFF"})
	 batterywarning[1] = true
	 batterywarning[2] = true

      elseif lev < 30 and not batterywarning[1] then 
	 naughty.notify({text = "Warning: Battery Low", timeout = 0, 
			 bg = "#FF6600", fg = "#FFFFFF" })
	 batterywarning[1] = true
      end
   end
   
end

local batterywidgettimer = timer({timeout = 5})
batterywidgettimer:connect_signal("timeout", updateBatteryWidget)
batterywidgettimer:start()

return batterywidget
