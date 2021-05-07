#!/usr/bin/env bash
# THIS SCRIPT CREATES A LOCAL WORKING ENVIRONMENT FOR ZEPHYR.
# ZEPHYR USES PYTHON VENV AND WEST FOR BASIC OPERATIONS.
# ZEPHYR_BASE ENVIRONMENT VARIABLE CAN OVERRIDE ZEPHYR LOCATION.
# CeDeROM / TOMEK@CEDRO.INFO
set -e
VERSION="20210507.2"
PREFIX="$HOME/usr/local"
PYBIN="python3.7"
PYUTILS="pip wheel west nrfutil"
export PYVENVLOC="$PREFIX/venv37zephyr"
export ZEPHYRLOC="$PREFIX/zephyrproject"
export ZEPHYR_TOOLCHAIN_VARIANT="gnuarmemb"
export GNUARMEMB_TOOLCHAIN_PATH="/usr/local/gcc-arm-embedded"

###############################################################
# FUNCTIONS DEFINITION
###############################################################

shell_run()
{
 case $SHELL in
  *zsh*) $SHELL -f;;
  *) $SHELL --norc
 esac
}

shell_install_self()
{
 echo "COPYING MYSELF TO: $PREFIX/bin"
 mkdir -p $PREFIX/bin
 cp $0 $PREFIX/bin/
 echo "export PATH=\"$PREFIX/bin\":$PATH" >> $HOME/.profile
 echo "DONE :-)"
}

python_setup_venv()
{
 echo "SETTING UP $PYBIN VIRTUAL ENVIRONMENT AT: $PYVENVLOC"
 $PYBIN -m venv --copies $PYVENVLOC
}

python_run_venv()
{
 echo "STARTING PYTHON VIRTUAL ENVIRONMENT AT: $PYVENVLOC"
 source "$PYVENVLOC/bin/activate"
}

python_update_venv()
{
 echo "UPDATING PYTHON VIRTUAL ENVIRONMENT AT: $PYVENVLOC"
 pip install -U $PYUTILS
}

zephyr_find_env()
{
 if [ $ZEPHYR_BASE ]; then
  ZEPHYRLOC="$ZEPHYR_BASE/.."
  echo "USING ZEPHYR_BASE FROM ENV: $ZEPHYR_BASE"
 else
  ZEPHYR_BASE="$ZEPHYRLOC/zephyr"
  echo "USING DEFAULT ZEPHYR_BASE: $ZEPHYR_BASE"
 fi
}

zephyr_setup_env()
{
 echo "SETTING UP ZEPHYR AT: $ZEPHYRLOC"
 pip install $PYUTILS
 zephyr_find_env
 if [ ! -e $ZEPHYRLOC ]; then
  west init $ZEPHYRLOC
 fi
 cd $ZEPHYRLOC
 west update
 west zephyr-export
 pip install -Ur "$ZEPHYRLOC/zephyr/scripts/requirements.txt"
}

zephyr_run_env()
{
 source "$ZEPHYR_BASE/zephyr-env.sh"
}

zephyr_update_env()
{
 zephyr_find_env
 python_run_venv
 zephyr_run_env
 west update
}

command_usage()
{
 echo "================================================================"
 echo " ZEPHYR + PYTHON VIRTUALENV SDK HELPER BY CeDeROM ($VERSION)"
 echo "================================================================"
 echo
 echo " This script quckly lands you in Python+Zephyr SDK VENV."
 echo " By default script sets up SDK then spawns shell."
 echo " Adjust script parameters in its source code."
 echo " Script location: $0"
 echo
 echo "Available commands:"
 echo "    help : Display this help."
 echo "    init : Initialize Python and Zephyr SDK."
 echo "  update : Update Python and Zephyr SDK."
 echo " install : Install this sctipt to $PREFIX/bin."
 echo "   shell : Spawn Python VirtualEnv shell."
 echo "   flash : Your own way to flash a Target." 
 echo "           -dfu  : (optional) generate and flash the DFU ZIP."
 echo "           fwloc : (optional) use this firmware location."
 echo "    uart : Your own way to spawn UART CLI with Target."
 echo "           port  : (optional) use this UART port." 
 echo
 echo " If none of above is provided then command is run in zephyr venv!"
 echo
}

command_flash()
{
 # FLASH FIRMWARE TO THE TARGET OVER DAPLINK OR USB DFU.
 # DEFAULTS
 FLASHTYPE="UMS"
 FWLOC="build/zephyr/zephyr.hex"
 MNTPT="$HOME/tmp/mount"
 UMSDEV="/dev/da0"
 # CHECK FOR OPTIONAL PARAMETERS
 if [ $# -ge 1 ]; then
  if [ "$2" == "-dfu" ]; then
   FLASHTYPE="DFU"
   if [ $# -eq 3 ]; then FWLOC=$3; fi
  elif [ $# -eq 2 ]; then FWLOC=$2; fi
 fi
 echo "Flashing $FWLOC over $FLASHTYPE."
 # VERIFY FIRMWARE EXISTENCE.
 if [ ! -e $FWLOC ]; then
  echo "Firmware not found at: $FWLOC. Ejecting!"
  exit 1
 fi
 if [ "$FLASHTYPE" == "UMS" ]; then
  if [ ! -e $MNTPT ]; then mkdir -p $MNTPT; fi
  echo "Flashing From : $FWLOC"
  echo "Flashing TO   : $UMSDEV"
  echo "Flashing Over : $MNTPT"
  mount_msdosfs $UMSDEV $MNTPT
  cp build/zephyr/zephyr.hex $MNTPT
  umount $MNTPT
 elif [ "$FLASHTYPE" == "DFU" ]; then
  echo "CONVERTING HEX TO DFU ZIP."
  nrfutil pkg generate --debug-mode --application $FWLOC --hw-version 52 --sd-req 0 $FWLOC.zip
  echo "FLASHING DFU ZIP. REMEMBER TO TOGGLE BOARD DFU MODE."
  nrfutil --verbose dfu usb-serial -p /dev/cuaU0 -pkg $FWLOC.zip
 else
  echo "Invalid flashing type provided ($FLASHTYPE). Ejecting!"
  exit 1
 fi
 echo "Flashing Complete :-)"
}

command_uart()
{
 PORT="/dev/cuaU0"
 if [ $# -ge 2 ]; then
  if [ ! -e $PORT ]; then
   echo "Port $PORT does not exist. Ejecting!"
   exit 1
  else
   PORT=$2
  fi
 fi
 echo "Launching MINICOM at port $PORT."
 minicom -b 115200 -D $PORT
}


###############################################################
# HANDLE PROVIDED COMMANDLINE PARAMETERS
###############################################################

command_usage
case $1 in
 [sS][hH][eE][lL][lL])
  python_run_venv
  shell_run
  exit
 ;;
 [uU][pP][dD][aA][tT][eE])
  python_run_venv
  python_update_venv
  zephyr_update_env
  exit
 ;;
 [iI][nN][iI][tT])
  shell_install_self
  python_setup_venv
  python_run_venv
  python_update_venv
  zephyr_find_env
  zephyr_setup_env
  zephyr_update_env
  exit
 ;;
 [iI][nN][sS][tT][aA][lL][lL])
  shell_install_self
  exit
 ;;
 [hH][eE][lL][pP])
  exit
 ;;
 [fF][lL][aA][sS][hH])
  command_flash $@
  exit
 ;;
 [uU][aA][rR][tT])
  command_uart $@
  exit
 ;;
esac

###############################################################
# NO ARGUMENT PROVIDED, TRY TO BE INTERACTIVE OR RUN COMMAND
# INSIDE A ZEPHYR AND PYTHON VENV (SCRIPT MODE)
###############################################################

if [ ! -e "$PYVENVLOC/bin/activate" ]; then
 command_usage
 shell_install_self
 echo "PYTHON VIRTUAL ENVIRONMENT NOT FOUND. CREATE IT? [y/N]"
 read a
 if [[ $a =~ ^[yY] ]]; then
  python_setup_venv
  python_run_venv
  python_update_venv
 fi
else
 python_run_venv
fi

zephyr_find_env

if [ ! -e $ZEPHYRLOC ]; then
 echo "ZEPHYR ENVIRONMENT NOT FOUND. CREATE? [y/N]"
 read a
 if [[ $a =~ ^[yY] ]]; then
  zephyr_setup_env
  zephyr_run_env
  zephyr_update_env
 fi
else
 zephyr_run_env
fi

if [ $# -eq 0 ]; then
 shell_run
else
 $@
fi

