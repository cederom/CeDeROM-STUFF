## CeDeROM STLINK-V3MODS ADAPTER

Just a simple adapter for STLINK-V3MODS [1] that provides 2.54mm raster pins
connector very popular for prototyping and/or testing automation.
Production files (gerber+excellon) and sch+pcb (pdf) are in out/ directory.

This is smallest and cheapest debug probe with JTAG/SWD capabilities, 3..3,6V
capable IO with 5V tolerant inputs, Virtual COM Port, but also multipath
bridge that provides SPI/UART/I2C/CAN/GPIO (UART with control lines).

Firmware is closed source, unfortunately, and in may need to update firmware
in order to get some additional features (i.e. second UART operational) [1].

# References

* [1] https://www.st.com/en/development-tools/stlink-v3mods.html
