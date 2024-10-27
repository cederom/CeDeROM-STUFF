#!/usr/bin/env bash
# NuttX RTOS Release Build Test script.
# 20241026, tomek@cedro.info.
set -e
set +x

NXBRANCH="nuttx-12.7.0-RC1"
NXRTOSLOC="../nuttx.git"
NXAPPSLOC="../nuttx-apps.git"
MFLAGS="-j8 "
if [ -z $TIMESTAMP ]; then TIMESTAMP=`date "+%s"`; fi
if [ -z $TARGET ]; then echo "NO TARGET SPECIFIED!"; exit 1; fi
if [ ! -z $CROSSDEV ]; then MFLAGS+="CROSSDEV=$CROSSDEV "; fi
LOGFILE="log/$NXBRANCH-$TIMESTAMP-$TARGET.log"

if [ ! -e "log/" ]; then mkdir log; fi
exec > >(tee $LOGFILE)
exec 2>&1

printf "\n****************************************\n"
printf "* NUTTX RTOS RELEASE BUILD TEST SCRIPT *\n"
printf "****************************************\n\n"

printf "   NX BRANCH : $NXBRANCH\n"
printf " NX RTOS LOC : $NXRTOSLOC\n"
printf " NX APPS LOC : $NXAPPSLOC\n"
printf "      TARGET : $TARGET\n"
printf "  BUILD HOST : `uname -a`\n"
printf "      MFLAGS : $MFLAGS\n"
printf "     LOGFILE : $LOGFILE\n"
printf "   TIMESTAMP : $TIMESTAMP\n"

set +x
printf "\n=>\n=> INITIAL CLEAN AND SETUP\n=>\n\n"
set -x

set -e

cd $NXRTOSLOC
set +e
gmake clean distclean $MFLAGS
rm -f .config
set -e

git checkout master
git fetch origin
git pull origin
git checkout $NXBRANCH
git reset --hard

cd $NXAPPSLOC
git checkout master
git fetch origin
git pull origin
git checkout $NXBRANCH
git reset --hard

cd $NXRTOSLOC
