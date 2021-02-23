# Spartan Edge Accelerator Board Master Constraints XDC file for Xilinx Vivado.
# For use with Spartan-7 XC7S15-1FTGB196C FPGA. Uncomment/adapt what you need.
# Created by CeDeROM (tomek@cedro.info) based on Schematics + Netlist + Demo.
# Version: 20210223-1.


### CLOCK
set_property -dict {PACKAGE_PIN H4  IOSTANDARD LVCMOS33} [get_ports SYSCLK]
# Set your clock parameters below. Some examples provided.
# Note: -period is in ns, -divide_by / -multiply_by 
create_clock -name CLK -period 10.000 -waveform {0.000 5.000} [get_ports SYSCLK]
#create_generated_clock -name SYSCLK -source [get_ports SYSCLK] -multiply_by 1 -duty_cycle 50.0 [get_ports SYSCLK]
#create_clock -period 10.760 -name dphy_hs_clock_p -waveform {0.000 5.380} [get_ports clk_rxp_0]
#set_false_path -from [get_clocks [get_clocks -of_objects [get_pins system_i/csi2_d_phy_rx_0/U0/clock_system_inst/BUFR_inst/O]]] -to [get_clocks [get_clocks -of_objects [get_pins system_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0] -filter {IS_GENERATED && MASTER_CLOCK == clk_in1_0}]]
#set_false_path -from [get_clocks [get_clocks -of_objects [get_pins system_i/csi2_d_phy_rx_0/U0/clock_system_inst/BUFR_inst/O]]] -to [get_clocks [get_clocks -of_objects [get_pins system_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0] -filter {IS_GENERATED && MASTER_CLOCK == sys_clk_pin}]]
#set_false_path -from [get_clocks [get_clocks -of_objects [get_pins system_i/csi2_d_phy_rx_0/U0/clock_system_inst/BUFR_inst/O]]] -to [get_clocks [get_clocks -of_objects [get_pins system_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {I_qspi_clk_IBUF}]


### POWER
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#set_property INTERNAL_VREF 0.6 [get_iobanks 14,36]
#set_property DCI_CASCADE {31 32} [get_iobanks 36]
# AR_3V3_EN selects Standalone (enabled) or Arduino (disabled) shield power supply mode.
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports AR_3V3_EN]
# FPGA_AR_OE1 controls U17 5/3.3V voltage converter outputs for I2C and UART.
set_property -dict {PACKAGE_PIN N4  IOSTANDARD LVCMOS33}  [get_ports FPGA_AR_OE1]
# FPGA_AR_OE2 controls U18 5/3.3Vvoltage converter outputs for SPI.
set_property -dict {PACKAGE_PIN M3  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_OE2] 


### JTAG
#set_property -dict {PACKAGE_PIN A7  IOSTANDARD LVCMOS33} [get_ports FPGA_TCK]
#set_property -dict {PACKAGE_PIN P7  IOSTANDARD LVCMOS33} [get_ports FPGA_TDI]
#set_property -dict {PACKAGE_PIN P6  IOSTANDARD LVCMOS33} [get_ports FPGA_TDO]
#set_property -dict {PACKAGE_PIN M6  IOSTANDARD LVCMOS33} [get_ports FPGA_TMS]
# M[0:2] SELECTS BOOT: 111 SLAVE SERIAL OR 101 JTAG.
#set_property -dict {PACKAGE_PIN M7  IOSTANDARD LVCMOS33} [get_ports FPGA_M0]
#set_property -dict {PACKAGE_PIN M8  IOSTANDARD LVCMOS33} [get_ports FPGA_M1]
#set_property -dict {PACKAGE_PIN M9  IOSTANDARD LVCMOS33} [get_ports FPGA_M2]


### LED
set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports FPGA_RGB]  ;# 2xRGB
set_property -dict {PACKAGE_PIN J1  IOSTANDARD LVCMOS33} [get_ports FPGA_LED1] ;# GREEN
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports FPGA_LED2] ;# RED
set_property -dict {PACKAGE_PIN P9  IOSTANDARD LVCMOS33} [get_ports FPGA_DONE] ;# RED / FPGA_DONE_ESP


### ADC
set_property -dict {PACKAGE_PIN C5  IOSTANDARD LVCMOS33} [get_ports ADC_CLK]
set_property -dict {PACKAGE_PIN J4  IOSTANDARD LVCMOS33} [get_ports ADC_EN]
set_property -dict {PACKAGE_PIN J3  IOSTANDARD LVCMOS33} [get_ports ADC_D0]
set_property -dict {PACKAGE_PIN J2  IOSTANDARD LVCMOS33} [get_ports ADC_D1]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports ADC_D2]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports ADC_D3]
set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports ADC_D4]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports ADC_D5]
set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33} [get_ports ADC_D7]
set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33} [get_ports ADC_D6]


### DAC
set_property -dict {PACKAGE_PIN L1  IOSTANDARD LVCMOS33} [get_ports DAC_DIN]
set_property -dict {PACKAGE_PIN N1  IOSTANDARD LVCMOS33} [get_ports DAC_SYNC]
set_property -dict {PACKAGE_PIN M1  IOSTANDARD LVCMOS33} [get_ports DAC_SCLK]


### IMU
set_property -dict {PACKAGE_PIN L12 IOSTANDARD LVCMOS33} [get_ports IMU_INT2]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports IMU_AD]


### MIPI
#TODO: VERIFY IOSTANDARD LVDS_25/LVCMOS33?!
set_property -dict {PACKAGE_PIN M12 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_RST]
set_property -dict {PACKAGE_PIN K11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_SCL]
set_property -dict {PACKAGE_PIN K12 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_SDA]
set_property -dict {PACKAGE_PIN F11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_CN]
set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_CP]
set_property -dict {PACKAGE_PIN J11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_DP0]
set_property -dict {PACKAGE_PIN J12 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_DN0]
set_property -dict {PACKAGE_PIN P10 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_DP1]
set_property -dict {PACKAGE_PIN P11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_DN1]
set_property -dict {PACKAGE_PIN M11 IOSTANDARD LVCMOS33} [get_ports FPGA_CAM_GPIO1]
#create_clock -period 4.761 -name dphy_hs_clock_p -waveform {0.000 2.380} [get_ports FPGA_CAM_CP];


### HDMI
set_property -dict {PACKAGE_PIN E4  IOSTANDARD LVCMOS33} [get_ports HDMI_CEC]
set_property -dict {PACKAGE_PIN D4  IOSTANDARD LVCMOS33} [get_ports HDMI_HPD_DET]
set_property -dict {PACKAGE_PIN F2  IOSTANDARD LVCMOS33} [get_ports FPGA_HDMI_SDA]
set_property -dict {PACKAGE_PIN F3  IOSTANDARD LVCMOS33} [get_ports FPGA_HDMI_SCL]
set_property -dict {PACKAGE_PIN G1  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD0P]
set_property -dict {PACKAGE_PIN F1  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD0N]
set_property -dict {PACKAGE_PIN E2  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD1P]
set_property -dict {PACKAGE_PIN D2  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD1N]
set_property -dict {PACKAGE_PIN D1  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD2P]
set_property -dict {PACKAGE_PIN C1  IOSTANDARD TMDS_33} [get_ports FPGA_HDMI_TD2N]
set_property -dict {PACKAGE_PIN G4  IOSTANDARD TDMS_33} [get_ports FPGA_HTMI_TCKP]
set_property -dict {PACKAGE_PIN F4  IOSTANDARD TDMS_33} [get_ports FPGA_HDMI_TCKN]


### QSPI
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_CLK] ;# ESP_QSPI_CLK]
set_property -dict {PACKAGE_PIN P2  IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_D]   ;# ESP_QSPI_D
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_Q]   ;# ESP_QSPI_Q 
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_WP]  ;# ESP_QSPI_WP
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_HD]  ;# ESP_QSPI_HD
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports FPGA_QSPI_CS]  ;# ESP_QSPI_CS


### SPI
# Use FPGA_AR_OE2 to enable U18 power converter for SPI.
set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports FPGA_AR_SCK]
set_property -dict {PACKAGE_PIN M5  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_MOSI]
set_property -dict {PACKAGE_PIN L5  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_MISO]
set_property -dict {PACKAGE_PIN K4  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_RESET]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports FPGA_AR_DET]


### I2C
# FPGA_ESP_IN_1_2 selects ESP32 I2C over analog switch SW2: 0 FPGA, 1 Arduino Shield.
set_property -dict {PACKAGE_PIN H3  IOSTANDARD LVCMOS33} [get_ports FGPA_ESP_IN_1_2]
# Use FPGA_AR_OE1 to enable U17 power converter for AR_SDA+AR_SCL outputs. 
set_property -dict {PACKAGE_PIN P12 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_SCL]
set_property -dict {PACKAGE_PIN P13 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_SDA]


### ESP32 MCU
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_IO5]   ;# FLASH_SCS
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_IO6]   ;# FLASH_SCK
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_IO7]   ;# FLASH_SDO
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports FPGA_ESP_IO8]   ;# FLASH_SDI
set_property -dict {PACKAGE_PIN A8  IOSTANDARD LVCMOS33} [get_ports FPGA_CCLK]      ;# FPGA_CCLK_ESP
set_property -dict {PACKAGE_PIN P8  IOSTANDARD LVCMOS33} [get_ports FPGA_INTB]      ;# FPGA_INTB_ESP
set_property -dict {PACKAGE_PIN L7  IOSTANDARD LVCMOS33} [get_ports FPGA_PROGRAM]   ;# FPGA_PROGRAM_ESP
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports FPGA_CONFIG_DIN];# FPGA_CONFIG_DIN_ESP


### GPIO
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports FPGA_RST]
# FPGA_IO CONNECTOR (8-BIT BUS)
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[0]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[1]}]
set_property -dict {PACKAGE_PIN C4  IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[2]}]
set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[3]}]
set_property -dict {PACKAGE_PIN N10 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[4]}]
set_property -dict {PACKAGE_PIN M10 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[5]}]
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[6]}]
set_property -dict {PACKAGE_PIN D3  IOSTANDARD LVCMOS33} [get_ports {FPGA_IO[7]}]
# FPGA_IO CONNECTOR (SINGLE BITS)
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports FPGA_IO0]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports FPGA_IO1]
set_property -dict {PACKAGE_PIN C4  IOSTANDARD LVCMOS33} [get_ports FPGA_IO2]
set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS33} [get_ports FPGA_IO3]
set_property -dict {PACKAGE_PIN N10 IOSTANDARD LVCMOS33} [get_ports FPGA_IO4]
set_property -dict {PACKAGE_PIN M10 IOSTANDARD LVCMOS33} [get_ports FPGA_IO5]
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports FPGA_IO6]
set_property -dict {PACKAGE_PIN D3  IOSTANDARD LVCMOS33} [get_ports FPGA_IO7]
set_property -dict {PACKAGE_PIN P5  IOSTANDARD LVCMOS33} [get_ports FPGA_IO8]
set_property -dict {PACKAGE_PIN E11 IOSTANDARD LVCMOS33} [get_ports FPGA_IO9]
set_property -dict {PACKAGE_PIN C3  IOSTANDARD LVCMOS33} [get_ports FPGA_IO10] ;# BUTTON1
set_property -dict {PACKAGE_PIN M4  IOSTANDARD LVCMOS33} [get_ports FPGA_IO11] ;# BUTTON2
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports FPGA_IO12]
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports FPGA_IO13]
# ARDUINO SHIELD
set_property -dict {PACKAGE_PIN H2  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D13]
set_property -dict {PACKAGE_PIN H1  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D12]
set_property -dict {PACKAGE_PIN B1  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D11]
set_property -dict {PACKAGE_PIN B2  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D10]
set_property -dict {PACKAGE_PIN A2  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D9]
set_property -dict {PACKAGE_PIN B3  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D8]
set_property -dict {PACKAGE_PIN A3  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D7]
set_property -dict {PACKAGE_PIN A4  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D6]
set_property -dict {PACKAGE_PIN B5  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D5]
set_property -dict {PACKAGE_PIN A5  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D4]
set_property -dict {PACKAGE_PIN B6  IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D3]
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D2]
# Use FPGA_AR_OE1 to enable U17 5/3.3V power converter for RX/TX outputs. 
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D1_TX]
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33} [get_ports FPGA_AR_D0_RX]
# Hardware Version Pins
set_property -dict {PACKAGE_PIN P4  IOSTANDARD LVCMOS33} [get_ports VERSION_1]
set_property -dict {PACKAGE_PIN P3  IOSTANDARD LVCMOS33} [get_ports VERSION_2]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports VERSION_3]
# DIP Switch Configuration
set_property -dict {PACKAGE_PIN M2  IOSTANDARD LVCMOS33} [get_ports FPGA_K1]
set_property -dict {PACKAGE_PIN L2  IOSTANDARD LVCMOS33} [get_ports FPGA_K2]
set_property -dict {PACKAGE_PIN L3  IOSTANDARD LVCMOS33} [get_ports FPGA_K3]
set_property -dict {PACKAGE_PIN K3  IOSTANDARD LVCMOS33} [get_ports FPGA_K4]

