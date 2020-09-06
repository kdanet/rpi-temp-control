#!/bin/bash

# Global variables
t=-1
gpio mode 15 out

function tempCheck() {
  temp=`sudo cat /sys/class/thermal/thermal_zone0/temp`
  t=$(($temp / 1000))
}

function fanControl() {
  tempCheck
  if [ $t -gt 50 ]
  then
	echo "More 38 degrees"
	gpio write 15 1
	sleep 350
  else
    	echo "Low 38 degrees"
	gpio write 15 0
  fi
  echo $t
}

while true;
do
  fanControl
  sleep 120
done
