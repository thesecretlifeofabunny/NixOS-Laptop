# yoinked and modified from https://unix.stackexchange.com/questions/473788/simple-swaybar-example

# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT1/status)

# Returns the battery charge level out of 100
battery_level=$(cat /sys/class/power_supply/BAT1/capacity)

echo $battery_status $battery_level"%" $date_formatted

