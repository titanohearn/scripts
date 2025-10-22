#!/bin/bash

#wifis=$(nmcli device wifi list | awk '{print $2}')
#wifi=$(nmcli connection show | grep 'wifi' | awk '{print $1}' | rofi -dmenu -p 'WIFIs')
wifi=$(nmcli -t -f BARS,SSID device wifi list | tr ':' '\t' | rofi -dmenu -p 'Wifi' | awk -F'\t' '{print $2}')
#text=$(rofi -dmenu -p 'type text')
#echo $text;
#echo $wifi;

if [ -n "$wifi" ]; then
  password=$(rofi -dmenu -p "Password for $wifi")  
  #echo $password;
  nmcli device wifi connect "$wifi" password "$password" &> /tmp/filer
  result=$(nmcli device wifi connect "$wifi" password "$password")
  notify-send "$(cat /tmp/filer)"
fi

