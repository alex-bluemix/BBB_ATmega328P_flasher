#!/bin/bash
if [ "$#" -ne 1 ]
then
  echo "Usage: $0 sketch.cpp.hex"
  exit 1
fi

pin=49
serial=/dev/ttyO4
#Time to Sleep
tts=0.8

(echo 0 > /sys/class/gpio/gpio$pin/value && sleep $tts && echo 1 > /sys/class/gpio/gpio$pin/value) &
avrdude -c arduino -p m328p -v -v -v -v -P $serial  -U flash:w:$1
