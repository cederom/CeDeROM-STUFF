EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr User 6299 4724
encoding utf-8
Sheet 1 1
Title "CeDeROM POWER BUTTON TOGGLE ON HOLD OFF TEST"
Date "2020-08-30"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power-toggle-on-hold-off-rescue:BSD235C-local U1
U 1 1 5F487CC6
P 3500 1450
F 0 "U1" H 3650 1100 50  0000 C CNN
F 1 "BSD235C" H 3500 1800 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6_Handsoldering" H 3500 1450 50  0001 C CNN
F 3 "https://www.infineon.com/cms/en/product/power/mosfet/20v-60v-complementary-mosfet/bsd235c/" H 3500 1450 50  0001 C CNN
	1    3500 1450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 5F489246
P 1950 1450
F 0 "R4" H 2000 1550 50  0000 L CNN
F 1 "100k" V 1950 1350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1880 1450 50  0001 C CNN
F 3 "~" H 1950 1450 50  0001 C CNN
	1    1950 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5F48ABB9
P 1550 1650
F 0 "C1" V 1500 1500 50  0000 L CNN
F 1 "1uF" V 1600 1700 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1588 1500 50  0001 C CNN
F 3 "~" H 1550 1650 50  0001 C CNN
	1    1550 1650
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5F48CB03
P 1050 1900
F 0 "SW1" H 1150 2000 50  0000 C CNN
F 1 "POWER" H 1050 1850 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_B3U-3000P" H 1050 2100 50  0001 C CNN
F 3 "~" H 1050 2100 50  0001 C CNN
	1    1050 1900
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0101
U 1 1 5F48D484
P 1950 1200
F 0 "#PWR0101" H 1950 1050 50  0001 C CNN
F 1 "VCC" H 2000 1400 50  0000 C CNN
F 2 "" H 1950 1200 50  0001 C CNN
F 3 "" H 1950 1200 50  0001 C CNN
	1    1950 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F48D7F0
P 850 2200
F 0 "#PWR0102" H 850 1950 50  0001 C CNN
F 1 "GND" H 900 2000 50  0000 C CNN
F 2 "" H 850 2200 50  0001 C CNN
F 3 "" H 850 2200 50  0001 C CNN
	1    850  2200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5F493C72
P 1250 1450
F 0 "R2" H 1300 1550 50  0000 L CNN
F 1 "???" V 1250 1350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1180 1450 50  0001 C CNN
F 3 "~" H 1250 1450 50  0001 C CNN
	1    1250 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5F4963AF
P 5500 1450
F 0 "R7" H 5600 1500 50  0000 L CNN
F 1 "220R" H 5600 1450 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5430 1450 50  0001 C CNN
F 3 "~" H 5500 1450 50  0001 C CNN
	1    5500 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5F496701
P 5500 1800
F 0 "D2" V 5550 1650 50  0000 R CNN
F 1 "LED" V 5450 1650 50  0000 R CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5500 1800 50  0001 C CNN
F 3 "~" H 5500 1800 50  0001 C CNN
	1    5500 1800
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP1
U 1 1 5F49759B
P 850 1200
F 0 "TP1" H 950 1350 50  0000 L CNN
F 1 "VCC" H 950 1250 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 1050 1200 50  0001 C CNN
F 3 "~" H 1050 1200 50  0001 C CNN
	1    850  1200
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5F4987EF
P 600 1350
F 0 "J1" H 500 1000 50  0000 C CNN
F 1 "VIN" H 500 1100 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 600 1350 50  0001 C CNN
F 3 "~" H 600 1350 50  0001 C CNN
	1    600  1350
	-1   0    0    1   
$EndComp
Wire Wire Line
	1950 1250 1950 1200
Wire Wire Line
	1950 1250 1950 1300
Connection ~ 1950 1250
Wire Wire Line
	1950 1600 1950 1650
Wire Wire Line
	3200 1650 3100 1650
Wire Wire Line
	3100 1650 3100 1450
Wire Wire Line
	3100 1450 3200 1450
Connection ~ 1950 1650
Wire Wire Line
	5500 1650 5500 1600
Wire Wire Line
	5500 1300 5500 1250
Wire Wire Line
	5100 1300 5100 1250
Connection ~ 5100 1250
$Comp
L Connector:TestPoint TP3
U 1 1 5F4A0BF3
P 3100 1850
F 0 "TP3" V 3200 2000 50  0000 C CNN
F 1 "VGD" V 3250 2000 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 3300 1850 50  0001 C CNN
F 3 "~" H 3300 1850 50  0001 C CNN
	1    3100 1850
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 5F4A18ED
P 5150 1650
F 0 "TP4" V 5050 1850 50  0000 R CNN
F 1 "PWRCTL" V 5250 1900 50  0000 R CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 5350 1650 50  0001 C CNN
F 3 "~" H 5350 1650 50  0001 C CNN
	1    5150 1650
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP5
U 1 1 5F4A30B0
P 5100 1200
F 0 "TP5" H 5200 1350 50  0000 L CNN
F 1 "VOUT" H 5200 1250 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 5300 1200 50  0001 C CNN
F 3 "~" H 5300 1200 50  0001 C CNN
	1    5100 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 1200 5100 1250
$Comp
L Device:C C3
U 1 1 5F4BA0CD
P 2900 1450
F 0 "C3" V 2850 1300 50  0000 L CNN
F 1 "100nF" V 3050 1350 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2938 1300 50  0001 C CNN
F 3 "~" H 2900 1450 50  0001 C CNN
	1    2900 1450
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 5F4C0E2A
P 4150 1450
F 0 "C5" H 4150 1350 50  0000 L CNN
F 1 "1uF" H 4150 1550 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4188 1300 50  0001 C CNN
F 3 "~" H 4150 1450 50  0001 C CNN
	1    4150 1450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 5F4C2DF6
P 5100 1450
F 0 "R6" H 5150 1350 50  0000 L CNN
F 1 "100K" V 5100 1350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5030 1450 50  0001 C CNN
F 3 "~" H 5100 1450 50  0001 C CNN
	1    5100 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	5100 1600 5100 1650
$Comp
L Device:R R5
U 1 1 5F496082
P 4900 1650
F 0 "R5" V 4800 1550 50  0000 L CNN
F 1 "300K" V 4900 1550 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4830 1650 50  0001 C CNN
F 3 "~" H 4900 1650 50  0001 C CNN
	1    4900 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	3800 1250 4150 1250
Wire Wire Line
	4150 1300 4150 1250
Wire Wire Line
	3900 1650 3900 1450
Wire Wire Line
	3900 1450 3800 1450
Wire Wire Line
	4150 1600 4150 1650
Connection ~ 4150 1650
Wire Wire Line
	4150 1650 3900 1650
Wire Wire Line
	5050 1650 5100 1650
Wire Wire Line
	1250 1650 1250 1600
Wire Wire Line
	1250 1300 1250 1250
$Comp
L Device:D D1
U 1 1 5F4CFDFB
P 1250 1900
F 0 "D1" V 1350 1950 50  0000 L CNN
F 1 "1N4148" V 1400 1950 50  0000 L CNN
F 2 "Diode_SMD:D_0805_2012Metric" H 1250 1900 50  0001 C CNN
F 3 "~" H 1250 1900 50  0001 C CNN
	1    1250 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	1250 1650 1250 1750
Connection ~ 1250 1650
Wire Wire Line
	1350 1650 1250 1650
Wire Wire Line
	1050 1650 1050 1700
Wire Wire Line
	1050 2100 1050 2150
Wire Wire Line
	5500 2150 5500 1950
Wire Wire Line
	1250 2050 1250 2100
Wire Wire Line
	5100 2100 5100 1650
Connection ~ 5100 1650
Wire Wire Line
	5150 1650 5100 1650
Wire Wire Line
	5100 1250 5500 1250
Wire Wire Line
	800  1250 850  1250
Wire Wire Line
	850  2150 850  1350
Wire Wire Line
	850  1350 800  1350
Wire Wire Line
	850  1200 850  1250
Connection ~ 850  1250
Wire Wire Line
	850  1250 1050 1250
Wire Wire Line
	850  2200 850  2150
Connection ~ 850  2150
Wire Wire Line
	3050 1450 3100 1450
Connection ~ 3100 1450
$Comp
L Device:C C4
U 1 1 5F4EFCC1
P 2900 1850
F 0 "C4" V 2850 1700 50  0000 L CNN
F 1 "???" V 3050 1750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2938 1700 50  0001 C CNN
F 3 "~" H 2900 1850 50  0001 C CNN
	1    2900 1850
	0    1    1    0   
$EndComp
Wire Wire Line
	3050 1850 3100 1850
Wire Wire Line
	3100 1850 3100 1650
Connection ~ 3100 1650
Wire Wire Line
	2750 1850 2700 1850
Wire Wire Line
	2700 1850 2700 1650
Wire Wire Line
	2700 1450 2750 1450
Wire Wire Line
	1950 1250 2200 1250
Connection ~ 1050 2150
Wire Wire Line
	2650 1650 2700 1650
Connection ~ 2700 1650
Wire Wire Line
	2700 1650 2700 1450
Wire Wire Line
	2250 1550 2200 1550
Wire Wire Line
	2200 1550 2200 1250
Connection ~ 2200 1250
Wire Wire Line
	2200 1250 3200 1250
Wire Wire Line
	2250 1750 2200 1750
Wire Wire Line
	2200 1750 2200 2150
$Comp
L Device:C C6
U 1 1 5F5023FE
P 4400 1450
F 0 "C6" H 4400 1350 50  0000 L CNN
F 1 "10uF" H 4400 1550 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4438 1300 50  0001 C CNN
F 3 "~" H 4400 1450 50  0001 C CNN
	1    4400 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	4150 1250 4400 1250
Connection ~ 4150 1250
Wire Wire Line
	4400 1300 4400 1250
Wire Wire Line
	4150 1650 4400 1650
Wire Wire Line
	4400 1600 4400 1650
$Comp
L Device:C C7
U 1 1 5F50955A
P 4650 1450
F 0 "C7" H 4650 1350 50  0000 L CNN
F 1 "???" H 4650 1550 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4688 1300 50  0001 C CNN
F 3 "~" H 4650 1450 50  0001 C CNN
	1    4650 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	4400 1650 4650 1650
Connection ~ 4400 1650
Wire Wire Line
	4400 1250 4650 1250
Connection ~ 4400 1250
Wire Wire Line
	4650 1300 4650 1250
Connection ~ 4650 1250
Wire Wire Line
	4650 1250 5100 1250
Wire Wire Line
	4650 1600 4650 1650
Connection ~ 4650 1650
Wire Wire Line
	4650 1650 4750 1650
Wire Wire Line
	2200 2150 3850 2150
Wire Wire Line
	3100 1850 3100 2050
Wire Wire Line
	3100 2050 1950 2050
Wire Wire Line
	1950 1650 1950 1850
Connection ~ 3100 1850
$Comp
L Device:C C2
U 1 1 5F52CA12
P 1550 1850
F 0 "C2" V 1500 1700 50  0000 L CNN
F 1 "???" V 1600 1900 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1588 1700 50  0001 C CNN
F 3 "~" H 1550 1850 50  0001 C CNN
	1    1550 1850
	0    1    1    0   
$EndComp
Wire Wire Line
	850  2150 1050 2150
Wire Wire Line
	1400 1850 1350 1850
Wire Wire Line
	1350 1850 1350 1650
Wire Wire Line
	1350 1650 1400 1650
Connection ~ 1350 1650
Connection ~ 1950 1850
Wire Wire Line
	1950 1850 1950 2050
Connection ~ 1250 1250
Wire Wire Line
	1250 1650 1050 1650
$Comp
L Connector:TestPoint TP2
U 1 1 5F544370
P 1450 1450
F 0 "TP2" H 1550 1550 50  0000 C CNN
F 1 "VCAP" H 1550 1450 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 1650 1450 50  0001 C CNN
F 3 "~" H 1650 1450 50  0001 C CNN
	1    1450 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 1450 1350 1450
Wire Wire Line
	1350 1450 1350 1650
Text Notes 2250 1700 2    50   ~ 0
OFF\nON
Text Notes 1600 2850 0    50   ~ 0
NOTES:\n1. Push button short to Power-ON. Hold button to Power-OFF.\n2. SW1 selects default power-attach state as ON or OFF.\n3. Additional ??? places for R and C for experimental values.\n\nSOURCE: http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/
$Comp
L Device:R R1
U 1 1 5F548CAC
P 1050 1450
F 0 "R1" H 1100 1550 50  0000 L CNN
F 1 "10k" V 1050 1350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 980 1450 50  0001 C CNN
F 3 "~" H 1050 1450 50  0001 C CNN
	1    1050 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1050 1300 1050 1250
Connection ~ 1050 1250
Wire Wire Line
	1050 1250 1250 1250
Wire Wire Line
	1050 1650 1050 1600
Connection ~ 1050 1650
$Comp
L Device:R R3
U 1 1 5F557758
P 1750 1450
F 0 "R3" H 1800 1550 50  0000 L CNN
F 1 "???" V 1750 1350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1680 1450 50  0001 C CNN
F 3 "~" H 1750 1450 50  0001 C CNN
	1    1750 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 1250 1750 1250
Wire Wire Line
	1750 1300 1750 1250
Connection ~ 1750 1250
Wire Wire Line
	1750 1250 1950 1250
Wire Wire Line
	1700 1650 1750 1650
Wire Wire Line
	1750 1600 1750 1650
Connection ~ 1750 1650
Wire Wire Line
	1750 1650 1950 1650
Wire Wire Line
	1700 1850 1950 1850
Wire Wire Line
	1050 2150 2200 2150
Connection ~ 2200 2150
Wire Wire Line
	1250 2100 5100 2100
$Comp
L Switch:SW_Push_SPDT SW2
U 1 1 5F4E7A99
P 2450 1650
F 0 "SW2" H 2450 1500 50  0000 C CNN
F 1 "POWERONDEF" H 2450 1850 50  0000 C CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_RoundedPad1.0x1.5mm_NumberLabels" H 2450 1650 50  0001 C CNN
F 3 "~" H 2450 1650 50  0001 C CNN
	1    2450 1650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3800 1650 3850 1650
Wire Wire Line
	3850 1650 3850 2150
Connection ~ 3850 2150
Wire Wire Line
	3850 2150 5500 2150
$EndSCHEMATC
