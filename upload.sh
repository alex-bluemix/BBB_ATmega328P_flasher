#!/bin/bash
if [ "$#" -lt 1 ]
then
  echo "Usage: $0 sketch.cpp.hex [time to sleep]"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

pin=49
serial=/dev/ttyO4

if [ "$2" == "" ]; then
   tts=.9
else
   tts=$2
fi

echo Waiting $tts seconds

(echo 0 > /sys/class/gpio/gpio$pin/value \
    && sleep $tts \
    && echo 1 > \
    /sys/class/gpio/gpio$pin/value) &

avrdude -c arduino -p m328p -b 57600 -v \
    -P $serial -U flash:w:$1
