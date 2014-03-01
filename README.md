BBB_ATmega328P_flasher
======================

Scripts to flash an ATmega328P from a BeagleBone Black

Instructions
------------

1. sudo ./install.sh
2. sudo ./upload.sh Blink.cpp.hex

Python Server
---------

`python server.py'

Then upload the sketch with something like this from another client:

`curl -X POST --data-binary @Blink.cpp.hex 192.168.2.10:8080/sketch.hex`

