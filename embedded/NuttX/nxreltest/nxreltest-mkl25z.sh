#!/usr/bin/env bash
# NuttX RTOS Release Build Test script.
# 20241026, tomek@cedro.info.

TARGET="MKL25Z128"
BOARD="freedom-kl25z"
CONFIGS="nsh"
ESP_PORT_FILTER=""
CROSSDEV="arm-none-eabi-"

. nxreltest-setup.sh

set +x
printf "\n\n=>\n=> BUILDING $TARGET\n=>\n\n"

printf "==> LOGFILE: $LOGFILE.\n\n"

printf "Press Return when ready.\n"
read a
set -x

"$CROSSDEV"gcc --version

for CFG in $CONFIGS; do
    set +x
    printf "\n\n===>\n===> $TARGET: $BOARD:$CFG \n===>\n\n"
    set -x
    gmake clean distclean $MFLAGS
    /usr/bin/time -h ./tools/configure.sh -B $BOARD:$CFG
    /usr/bin/time -h gmake -j8 $MFLAGS
    printf "\n\n\n===> FIRMWARE IS READY COPY TO OpenSDA DRIVE TO FLASH <===\n\n"
    #/usr/bin/time -h gmake flash $ESP_PORT CROSSDEV=$CROSSDEV
#    /usr/bin/time -h openocd -f 'board/frdm-kl25z.cfg' -c 'program nuttx.bin 0x08000000; reset run; exit'
#    cu -l /dev/cuaU0 -s 115200
done

#gmake clean distclean $MFLAGS
