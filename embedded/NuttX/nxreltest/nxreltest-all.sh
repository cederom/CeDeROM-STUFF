#!/usr/bin/env bash
# NuttX RTOS Release Build Test script.
# 20241026, tomek@cedro.info.

TIMESTAMP=`date "+%s"`
targets="esp32 esp32c3 stm32l432kc stm32f769i stm32f412zg stm32f411re stm32f072rb mkl25z"

for t in $targets; do ./nxreltest-$t.sh; done
