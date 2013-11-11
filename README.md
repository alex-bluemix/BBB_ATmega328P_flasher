BBB_ATmega328P_flasher
======================

Scripts to flash an ATmega328P from a BeagleBone Black

Instructions
------------

1. sudo ./install.sh
2. sudo ./upload.sh sketch.cpp.hex

That's it.

Details
-------

This will enable your BBB to act as a programmer for the ATmega328P over serial.  It will install various avr-tools and compile and enable a device tree overlay.
