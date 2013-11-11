#!/bin/bash

enable_pin(){
    #gpio1_17 for arduino reset pin, pull high to turn on
    #GPIOb_p = b * 32 + p = N

    #enable the pin
    echo $1 > /sys/class/gpio/export
    #set for output
    echo "out" > /sys/class/gpio/gpio$1/direction
    #set HIGH
    echo 1 > /sys/class/gpio/gpio$1/value
}

download_dtc(){

    wget -c https://raw.github.com/RobertCNelson/tools/master/pkgs/dtc.sh
    chmod +x dtc.sh
    ./dtc.sh
}

compile_dtc(){

    dtc -O dtb -o enable-uart5-00A0.dtbo -b 0 -@ enable-uart5.dts
}

enable_overlay(){

    cp enable-uart5-00A0.dtbo /lib/firmware/
    echo enable-uart5 > /sys/devices/bone_capemgr.*/slots
}

install_avr_tools(){
    apt-get install gcc-avr binutils-avr gdb-avr avr-libc avrdude
}

check_install(){
    echo "You should see your TTY in dmesg..."
    dmesg | grep ttyO4
}

# main
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

enable_pin 49
install_avr_tools
download_dtc
compile_dtc
enable_overlay
check_install

