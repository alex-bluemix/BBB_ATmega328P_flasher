#!/bin/bash

# Script to reset the ATmega328p 

echo 0 > /sys/class/gpio/gpio49/value
echo 1 > /sys/class/gpio/gpio49/value
