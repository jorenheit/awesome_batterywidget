Simple textbox-based battery widget for Awesome 3.5
Will warn at 30%, then at 20%.

INSTALLATION:
1)
  cd ~/.config/awesome
  git clone https://github.com/jorenheit/awesome_alttab.git alttab

2) Add to rc.lua:
   local alttab = require("alttab")

3) Add to panel:
    right_layout:add(batterywidget)

