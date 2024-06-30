#!/usr/bin/env bash
# THIS SCRIPT CREATES A LOCAL PYTHON EMBEDDED WORKING ENVIRONMENT.
# CAN BE USED WITH ZEPHYR, MICROPYTHON ON ARM, ESP32, ETC.
# CeDeROM / TOMEK@CEDRO.INFO
set -e
VERSION="20240630.1"
PREFIX="$HOME/.local"
PYBIN="python3.9"
PYUTILS_ZEPHYR="west"
PYUTILS_ARM="pyocd"
PYUTILS_ESP="esptool"
PYUTILS_MPY="mpremote adafruit-ampy"
PYUTILS="pip wheel pyserial"
PYUTILS="pip wheel pyserial"
# Comment out below PYUTILS what is not needed.
PYTUILS="$PYUTILS $PYTUILS_ZEPHYR"
PYTUILS="$PYUTILS $PYUTILS_ARM"
PYTUILS="$PYUTILS $PYUTILS_ESP"
PYUTILS="$PYUTILS $PYUTILS_MPY"
export PYVENVLOC="$PREFIX/venv3.9embedded"
export ZEPHYRLOC="$PREFIX/zephyrproject"
export ZEPHYR_TOOLCHAIN_VARIANT="gnuarmemb"
export GNUARMEMB_TOOLCHAIN_PATH="/usr/local/gcc-arm-embedded"
export RISCV32_TOOLCHAIN_PATH="/usr/local/riscv32-unknown-elf"
export RISCV64_TOOLCHAIN_PATH="/usr/local/riscv64-none-elf"
export PATH="/usr/local/bin:$PATH" # DTC binary name conflict.
export ESP_ZEPHYR_PATH="${HOME}/.espressif/tools/zephyr"
export ESP_BASE="$HOME/.espressif"
export ESP_TOOLS_PATH="${HOME}/.espressif/esp-idf.git/tools"
export ESP_IDF_GIT="https://github.com/espressif/esp-idf.git"
export ESP_IDF_PATH="$ESP_BASE/esp-idf.git"
export IDF_PATH=$ESP_IDF_PATH
export ESP_IDF_TOOLS_PATH=$ESP_IDF_PATH/tools
#export ESP_IDF_BRANCH="v5.2.2"
export ESP_IDF_BRANCH="master"
export PATH="$PATH:$ESP_ZEPHYR_PATH:$ESP_IDF_TOOLS_PATH"
# NOTE: Run `west espressif install` to have esp zephyr sdk!
#  See: https://docs.zephyrproject.org/latest/boards/xtensa/esp32/doc/index.html
# NOTE: Clone esp-idf to ~/.espressif/esp-idf.git to have esp idf tools.

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
 echo "COPYING MYSELF TO: $PREFIX/bin/$0"
 mkdir -p $PREFIX/bin
 if [ ! -e $PREFIX/bin/$0 ]; then
  cp -f $0 $PREFIX/bin/
 else
  echo "Target $PREFIX/bin/$0 already exist."
  if ! cmp -s -- "$0" "$PREFIX/bin/$0"; then
   echo "But file differs. Copying anyway."
   cp -f $0 $PREFIX/bin/$0
  fi
 fi
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
 set +e # ALLOW ERRORS
 pip install -U $PYUTILS
 set -e # STOP ALLOWING ERRORS
}

esp_find_env()
{
 # THIS NEEDS TO BE RUN WUTHIN PYTHON VENV ALREADY!
 if [ ! -d $ESP_BASE ]; then
  echo "ESPRESSIF IDF ENVIRONMENT NOT FOUND! SETUP WITH: $0 init esp."
  exit -1
 fi
}

esp_setup_env()
{
 if [ ! -e $ESPLOC ]; then
  mkdir -p $ESPLOC
 fi
 if [ ! -d $ESP_IDF_PATH ]; then
  echo "Fetch ESP IDF git repo."
  git clone $ESP_IDF_GIT $ESP_IDF_PATH
 fi
 cd $ESP_IDF_PATH
 echo "Pull all git repo updates."
 git pull --all
 echo "Checkout to branch: $ESP_IDF_BRANCH."
 git checkout $ESP_IDF_BRANCH
 echo "Install python dependencies."
 pip install -r tools/requirements/requirements.core.txt
 echo "Launch ESP IDF ./install.sh script."
 # Note: This script is known to fail, run it to obtain packages.
 set +e
 ./install.sh
 set -e
 echo "ESP IDF SDK SETUP COMPLETE :-)"
 echo "USE IT WITH: `basename $0` esp."
}

esp_run_env()
{
 cd $ESP_IDF_PATH
 source add_path.sh
 echo "SEARCHING FOR ESP IDF COMPILERS"
 ESP_TOOL=`find $ESP_BASE -type f -name "*-gcc" -exec dirname {} \;`
 for toolpath in $ESP_TOOL; do export PATH="$toolpath:$PATH"; done
 echo "ADDED: $ESP_TOOL."
 echo "SEARCHING FOR ESP IDF DEBUGGERS"
 ESP_TOOL=`find $ESP_BASE -type f -name "*-gdb" -exec dirname {} \;`
 for toolpath in $ESP_TOOL; do export PATH="$toolpath:$PATH"; done
 echo "ADDED: $ESP_TOOL."
 echo "YOU ARE NOW IN ESP IDF SHELL. HAVE FUN :-)"
}

esp_update_env()
{
 python_run_venv
 esp_setup_env
}

zephyr_find_env()
{
 # THIS NEEDS TO BE RUN WITHIN PYTHON VENV ALREADY!
 if [ -d .west ]; then
  zephyr_local=(`west list -f "{name} {path}"|grep zephyr`)
  if [ $? -eq 0 ]; then
   ZEPHYR_BASE=${zephyr_local[1]}
   ZEPHYRLOC="$ZEPHYR_BASE/.."
   echo "USING LOCAL .WEST PROVIDED ZEPHYR_BASE: $ZEPHYR_BASE"
  fi
 elif [ $ZEPHYR_BASE ]; then
  ZEPHYRLOC="$ZEPHYR_BASE/.."
  echo "USING ENV PROVIDED ZEPHYR_BASE: $ZEPHYR_BASE"
 elif [ -d $ZEPHYRLOC/zephyr ]; then
  ZEPHYR_BASE="$ZEPHYRLOC/zephyr"
  echo "USING DEFAULT ZEPHYR_BASE: $ZEPHYR_BASE"
 else
  echo "ZEPHYR ENVIRONMENT NOT FUOND! SETUP WITH: $0 init zephyr"
  exit -1
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
 if [ -e $ZEPHYR_BASE/zephyr-env.sh ]; then
  source "$ZEPHYR_BASE/zephyr-env.sh"
 else
  echo "ERROR: ZEPHYR ENVIRONMENT INVALID! SETUP WITH: $0 init zephyr."
  exit 1
 fi
}

zephyr_update_env()
{
 python_run_venv
 west update        # this is necessary if Zephyr not yet pulled
 zephyr_find_env
 west update
 zephyr_run_env
 west update
}

command_usage()
{
 echo "================================================================="
 echo "  EMBEDDED PYTHON VIRTUALENV SDK HELPER BY CeDeROM ($VERSION)"
 echo "================================================================="
 echo
 echo " This script quckly lands you in Python for Embedded SDK VENV."
 echo " Note that Zephyr SDK will can created with west udpate, so"
 echo " this is not created by default anymore (use init -zephyr)."
 echo " Note that Espressif IDF SDK can be installed with init esp."
 echo " By default script just spawns selected SDK shell."
 echo " Adjust script parameters in its source code."
 echo " Script location: $0"
 echo
 echo "Available commands:"
 echo "    help : Display this help."
 echo "    init : Initialize Python Venv."
 echo "           esp    : (optional) init Espressif IDF SDK."
 echo "           zephyr : (optional) init standalone Zephyr SDK."
 echo "  update : Update Python and Zephyr SDK."
 echo "           esp    : (optional) update Espressif IDF SDK."
 echo "           zephyr : (optional) update Zephyr SDK."
 echo " install : Install this sctipt to $PREFIX/bin."
 echo "    venv : Spawn Python Venv shell only."
 echo "    esp  : Spawn Python Venv + ESP IDF SDK shell."
 echo "  zephyr : Spawn Python Venv + Zephyr SDK shell."
 echo "   flash : Your own way to flash a Target." 
 echo "           -dfu  : (optional) generate and flash the DFU ZIP."
 echo "           -pyocd: (optional) use pyOCD to flash firmware."
 echo "           fwloc : (optional) use this firmware location."
 echo "    uart : Your own way to spawn UART CLI with Target."
 echo "           port  : (optional) use this UART port." 
 echo
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
  elif [ "$2" == "-pyocd" ]; then
   FLASHTYPE="PYOCD"
  elif [ $# -eq 2 ]; then FWLOC=$2; fi
  if [ $# -eq 3 ]; then FWLOC=$3; fi
 fi
 echo "Flashing $FWLOC over $FLASHTYPE."
 # VERIFY FIRMWARE EXISTENCE.
 if [ ! -e $FWLOC ]; then
  echo "Firmware not found at: $FWLOC. Ejecting!"
  exit 1
 fi
 if [ "$FLASHTYPE" == "PYOCD" ]; then
  pyocd flash $FWLOC
 elif [ "$FLASHTYPE" == "UMS" ]; then
  if [ ! -e $MNTPT ]; then mkdir -p $MNTPT; fi
  echo "Flashing From : $FWLOC"
  echo "Flashing TO   : $UMSDEV"
  echo "Flashing Over : $MNTPT"
  mount_msdosfs $UMSDEV $MNTPT
  cp $FWLOC $MNTPT && sync
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
 [vV][eE][nN][vV])
  python_run_venv
  shell_run
  exit
 ;;
 [eE][sS][pP])
  python_run_venv
  esp_find_env
  esp_run_env
  shell_run
  exit
 ;;
 [zZ][eE][pP][hH][yY][rR])
  python_run_venv
  zephyr_find_env
  zephyr_run_env
  shell_run
  exit
 ;;
 [uU][pP][dD][aA][tT][eE])
  python_run_venv
  python_update_venv
  if [ $# -eq 2 ]; then
   if [ $2 == "zephyr" ]; then
    zephyr_update_env
   elif [ $2 == "esp" ]; then
    esp_update_env
   fi
  fi
  exit
 ;;
 [iI][nN][iI][tT])
  shell_install_self
  python_setup_venv
  python_run_venv
  python_update_venv
  if [ $# -eq 2 ]; then
   if [ $2 == "zephyr" ]; then
    echo "SETUP ZEPHYR NOW"
    zephyr_find_env
    zephyr_setup_env
    zephyr_update_env
   elif [ $2 == "esp" ]; then
    echo "SETUP ESP IDF NOW"
    esp_setup_env
    esp_update_env
   fi
  fi
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
# command_usage
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

if [ $# -eq 0 ]; then
 shell_run
else
 $@
fi

