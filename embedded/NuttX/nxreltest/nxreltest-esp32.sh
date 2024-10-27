#!/usr/bin/env bash
# NuttX RTOS Release Build Test script.
# 20241026, tomek@cedro.info.

TARGET="ESP32"
BOARD="esp32-devkitc"
CONFIGS="nsh ostest coremark"
ESP_PORT_FILTER="--port-filter vid=0x10c4 --port-filter pid=0xea60"
CROSSDEV="xtensa-esp32-elf-"

. nxreltest-setup.sh

set +x
printf "\n\n=>\n=> BUILDING $TARGET\n=>\n\n"

printf "==> LOGFILE: $LOGFILE\n\n"

printf "Press Return when ready.\n"
read a
set -x

$CROSSDEV"gcc --version

for CFG in $CONFIGS; do
    set +x
    printf "\n\n===>\n===> $TARGET: $BOARD:$CFG \n===>\n\n"
    set -x
    /usr/bin/time -h gmake clean distclean $MFLAGS
    /usr/bin/time -h ./tools/configure.sh -B $BOARD:$CFG
    /usr/bin/time -h gmake $MFLAGS
    /usr/bin/time -h gmake flash $ESP_PORT $MFLAGS
    cu -l /dev/cuaU0 -s 115200
done

/usr/bin/time -h gmake clean distclean $MFLAGS
