#!/bin/bash

# Global variables
t=-1
gpio mode 15 out

function tempCheck() {
  temp=`sudo cat /sys/class/thermal/thermal_zone0/temp`
  t=$(($temp / 1000))
}

function fanControl() {
  date
  tempCheck
  echo "CPU temperature: ${t}"
  echo ""
  if [ $t -gt 50 ]
  then
	gpio write 15 1
	sleep 350
  else
	gpio write 15 0
  fi
}

while true;
do
  fanControl
  sleep 120
done
