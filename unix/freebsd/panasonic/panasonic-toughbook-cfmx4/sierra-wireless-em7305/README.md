# Sierra Wireless EM7305 LTE on FreeBSD

This LTE WWAN device is present on my Panasonic CF-MX4 laptop. It was not supported off-the-shelf by `u3g` module. Probably a `usb_modeswitch` needs to be applied in order to switch it to work with `pppd`. This project aims to provide off-the-shelf access to LTE WWAN network on FreeBSD using EM7305 device.


# Workbench

## Specification notes

### ViD/PID

Supported Application-Mode VID/PIDs:
```
VID 1199 1199 1199 1199 1199 1199 3F0 1199 1199 1199
PID 68A2 68C0 9011 9013 9015 9019 371D 9040 9041 9071
```

Supported Boot-Mode VID/PIDs:
```
VID 1199 1199 1199 1199 1199 1199 3F0 1199
PID 68A2 68C0 9010 9012 9014 9018 361D 9070
```

## Environment

```
# uname -a
FreeBSD 0xCFMX4 13.0-STABLE FreeBSD 13.0-STABLE #0 stable/13-n246220-a7761d19dac-dirty: Sat Jul 10 02:42:25 CEST 2021     root@0xCFMX4:/usr/obj/usr/src/amd64.amd64/sys/GENERIC  amd64

# usb_modeswitch --version

 * usb_modeswitch: handle USB devices with multiple modes
 * Version 2.6.0 (C) Josua Dietze 2017
 * Based on libusb1/libusbx

 ! PLEASE REPORT NEW CONFIGURATIONS !
```

## USB configuration

Radio ON:
```
# usbconfig
ugen1.1: <Intel EHCI root HUB> at usbus1, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=SAVE (0mA)
ugen0.1: <0x8086 XHCI root HUB> at usbus0, cfg=0 md=HOST spd=SUPER (5.0Gbps) pwr=SAVE (0mA)
ugen0.2: <Kionix Inc Kionix Sensor Hub F:0006 SI:0001 R2> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)
ugen1.2: <vendor 0x8087 product 0x8001> at usbus1, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=SAVE (0mA)
ugen0.4: <Generic USB HD Webcam> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)
ugen0.5: <Sierra Wireless, Incorporated EM7305> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)
ugen0.6: <Sharp Corp. 12.5EA0003> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)
ugen0.3: <vendor 0x8087 product 0x0a2a> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)
```

Radio OFF:
```
# usbconfig
ugen1.1: <Intel EHCI root HUB> at usbus1, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=SAVE (0mA)
ugen0.1: <0x8086 XHCI root HUB> at usbus0, cfg=0 md=HOST spd=SUPER (5.0Gbps) pwr=SAVE (0mA)
ugen0.2: <Kionix Inc Kionix Sensor Hub F:0006 SI:0001 R2> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)
ugen1.2: <vendor 0x8087 product 0x8001> at usbus1, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=SAVE (0mA)
ugen0.4: <Generic USB HD Webcam> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)
ugen0.5: <Sierra Wireless, Incorporated EM7305> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)
ugen0.6: <Sharp Corp. 12.5EA0003> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)

```

Sierra Wireless device info (`VID=0x1100 PID=0x9041`):

```
# usbconfig | grep -i sierra
ugen0.5: <Sierra Wireless, Incorporated EM7305> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)



root@0xCFMX4:~ # usbconfig -d 0.5 dump_all_desc
ugen0.5: <Sierra Wireless, Incorporated EM7305> at usbus0, cfg=0 md=HOST spd=HIGH (480Mbps) pwr=ON (500mA)

  bLength = 0x0012
  bDescriptorType = 0x0001
  bcdUSB = 0x0200
  bDeviceClass = 0x0000  <Probed by interface class>
  bDeviceSubClass = 0x0000
  bDeviceProtocol = 0x0000
  bMaxPacketSize0 = 0x0040
  idVendor = 0x1199
  idProduct = 0x9041
  bcdDevice = 0x0006
  iManufacturer = 0x0001  <Sierra Wireless, Incorporated>
  iProduct = 0x0002  <EM7305>
  iSerialNumber = 0x0003  <>
  bNumConfigurations = 0x0001

 Configuration index 0

    bLength = 0x0009
    bDescriptorType = 0x0002
    wTotalLength = 0x005f
    bNumInterfaces = 0x0002
    bConfigurationValue = 0x0001
    iConfiguration = 0x0000  <no string>
    bmAttributes = 0x00e0
    bMaxPower = 0x00fa

    Additional Descriptor

    bLength = 0x08
    bDescriptorType = 0x0b
    bDescriptorSubType = 0x0c
     RAW dump:
     0x00 | 0x08, 0x0b, 0x0c, 0x02, 0x02, 0x0e, 0x00, 0x00


    Interface 0
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x000c
      bAlternateSetting = 0x0000
      bNumEndpoints = 0x0001
      bInterfaceClass = 0x0002  <Communication device>
      bInterfaceSubClass = 0x000e
      bInterfaceProtocol = 0x0000
      iInterface = 0x0000  <no string>

      Additional Descriptor

      bLength = 0x05
      bDescriptorType = 0x24
      bDescriptorSubType = 0x00
       RAW dump:
       0x00 | 0x05, 0x24, 0x00, 0x10, 0x01


      Additional Descriptor

      bLength = 0x05
      bDescriptorType = 0x24
      bDescriptorSubType = 0x06
       RAW dump:
       0x00 | 0x05, 0x24, 0x06, 0x0c, 0x0d


      Additional Descriptor

      bLength = 0x0c
      bDescriptorType = 0x24
      bDescriptorSubType = 0x1b
       RAW dump:
       0x00 | 0x0c, 0x24, 0x1b, 0x00, 0x01, 0x00, 0x10, 0x20,
       0x08 | 0x80, 0xdc, 0x05, 0x20


      Additional Descriptor

      bLength = 0x08
      bDescriptorType = 0x24
      bDescriptorSubType = 0x1c
       RAW dump:
       0x00 | 0x08, 0x24, 0x1c, 0x00, 0x01, 0x40, 0xdc, 0x05


     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0082  <IN>
        bmAttributes = 0x0003  <INTERRUPT>
        wMaxPacketSize = 0x0040
        bInterval = 0x0009
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x000d
      bAlternateSetting = 0x0000
      bNumEndpoints = 0x0000
      bInterfaceClass = 0x000a  <CDC-data>
      bInterfaceSubClass = 0x0000
      bInterfaceProtocol = 0x0002
      iInterface = 0x0000  <no string>


    Interface 1 Alt 1
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x000d
      bAlternateSetting = 0x0001
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x000a  <CDC-data>
      bInterfaceSubClass = 0x0000
      bInterfaceProtocol = 0x0002
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0081  <IN>
        bmAttributes = 0x0002  <BULK>
        wMaxPacketSize = 0x0200
        bInterval = 0x0000
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0001  <OUT>
        bmAttributes = 0x0002  <BULK>
        wMaxPacketSize = 0x0200
        bInterval = 0x0000
        bRefresh = 0x0000
        bSynchAddress = 0x0000

```

`ugen0.3` device info (this device shows up only when Radio switch is ON). According to `VID=0x8087` and `PID=0x0a2a` this is the Bluetooth Interface:
```
# usbconfig -d 0.3 dump_all_desc
ugen0.3: <vendor 0x8087 product 0x0a2a> at usbus0, cfg=0 md=HOST spd=FULL (12Mbps) pwr=ON (100mA)

  bLength = 0x0012
  bDescriptorType = 0x0001
  bcdUSB = 0x0201
  bDeviceClass = 0x00e0  <Wireless controller>
  bDeviceSubClass = 0x0001
  bDeviceProtocol = 0x0001
  bMaxPacketSize0 = 0x0040
  idVendor = 0x8087
  idProduct = 0x0a2a
  bcdDevice = 0x0001
  iManufacturer = 0x0000  <no string>
  iProduct = 0x0000  <no string>
  iSerialNumber = 0x0000  <no string>
  bNumConfigurations = 0x0001

 Configuration index 0

    bLength = 0x0009
    bDescriptorType = 0x0002
    wTotalLength = 0x00b1
    bNumInterfaces = 0x0002
    bConfigurationValue = 0x0001
    iConfiguration = 0x0000  <no string>
    bmAttributes = 0x00e0
    bMaxPower = 0x0032

    Interface 0
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0000
      bAlternateSetting = 0x0000
      bNumEndpoints = 0x0003
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0081  <IN>
        bmAttributes = 0x0003  <INTERRUPT>
        wMaxPacketSize = 0x0040
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0002  <OUT>
        bmAttributes = 0x0002  <BULK>
        wMaxPacketSize = 0x0040
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 2
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0082  <IN>
        bmAttributes = 0x0002  <BULK>
        wMaxPacketSize = 0x0040
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0000
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0000
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0000
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1 Alt 1
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0001
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0009
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0009
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1 Alt 2
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0002
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0011
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0011
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1 Alt 3
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0003
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0019
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0019
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1 Alt 4
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0004
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0021
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0021
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000


    Interface 1 Alt 5
      bLength = 0x0009
      bDescriptorType = 0x0004
      bInterfaceNumber = 0x0001
      bAlternateSetting = 0x0005
      bNumEndpoints = 0x0002
      bInterfaceClass = 0x00e0  <Wireless controller>
      bInterfaceSubClass = 0x0001
      bInterfaceProtocol = 0x0001
      iInterface = 0x0000  <no string>

     Endpoint 0
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0003  <OUT>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0031
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000

     Endpoint 1
        bLength = 0x0007
        bDescriptorType = 0x0005
        bEndpointAddress = 0x0083  <IN>
        bmAttributes = 0x0001  <ISOCHRONOUS>
        wMaxPacketSize = 0x0031
        bInterval = 0x0001
        bRefresh = 0x0000
        bSynchAddress = 0x0000
```


## Modeswitch

Provide `VID`, `PID`, `bus`:

```
# usb_modeswitch -v 0x1199 -p 0x9041 -b 0.5
Look for default devices ...
 Found devices in default mode (1)
Access device 005 on bus 000
Get the current device configuration ...
Current configuration number is 1
Use interface number 12
 with class 2
Warning: no switching method given. See documentation
-> Run lsusb to note any changes. Bye!
```

Try above with `-K` switch (SCSI `std-eject`):
```
# usb_modeswitch -v 0x1199 -p 0x9041 -b 0.5 -K
Look for default devices ...
 Found devices in default mode (1)
Access device 005 on bus 000
Get the current device configuration ...
Current configuration number is 1
Use interface number 12
 with class 2
Error: can't use storage command in MessageContent with interface 12; interface class is 2, expected 8. Abort
```

Try with `-d` (detach only):
```
# usb_modeswitch -v 0x1199 -p 0x9041 -b 0.5 -d
Look for default devices ...
 Found devices in default mode (1)
Access device 005 on bus 000
Get the current device configuration ...
Current configuration number is 1
Use interface number 12
 with class 2
Detach storage driver as switching method ...
Looking for active drivers ...
-> Run lsusb to note any changes. Bye!
```

Try `-S` (send special sontrol message used by Sierra devices) failed:
```
# usb_modeswitch -v 0x1199 -p 0x9041 -b 0.5 -S
Look for default devices ...
 Found devices in default mode (1)
Access device 005 on bus 000
Get the current device configuration ...
Current configuration number is 1
Use interface number 12
 with class 2
Send Sierra control message
Error: Sierra control message failed (error -4). Abort
```

Huawei (`-H`, `-J`, `-X`), GCT (`-G`), Kobil (`-T`), Sequans (`-N`), Mobileaction (`-A`), Qisda (`-B`), Quanta (`-E`), Pantech (`-E n`), Blackberry (`-Z`), Sony (`-O`) modes control messages failed.

Try Sierra control mesage verbose:
```
# usb_modeswitch -v 0x1199 -p 0x9041 -b 0.5 -S -R -W -s 10 -u 2
Take all parameters from the command line


 * usb_modeswitch: handle USB devices with multiple modes
 * Version 2.6.0 (C) Josua Dietze 2017
 * Based on libusb1/libusbx

 ! PLEASE REPORT NEW CONFIGURATIONS !

DefaultVendor=  0x1199
DefaultProduct= 0x9041
SierraMode=1
Configuration=0x02
Success check enabled, max. wait time 10 seconds

Note: No target parameter given; success check limited
Look for default devices ...
  found USB ID 0000:0000
  found USB ID 0000:0000
  found USB ID 04b5:0680
  found USB ID 8087:8001
  found USB ID 5986:054c
  found USB ID 1199:9041
   vendor ID matched
   product ID matched
  found USB ID 04dd:9761
  found USB ID 8087:0a2a
 Found devices in default mode (1)
Access device 005 on bus 000
Get the current device configuration ...
Current configuration number is 1
Use interface number 12
 with class 2

USB description data (for identification)
-------------------------
Manufacturer: Sierra Wireless, Incorporated
     Product: EM7305
  Serial No.:
-------------------------
Send Sierra control message
Error: Sierra control message failed (error -4). Abort
```

## Interesting options

* `-W` verbose.
* `-R` reset USB device.
* `-s n` check success wait n seconds.
* `-i` select initial USB interface.
* `-u` select USB configuration.
* `-a` select alternative USB interface settings.

## References

* Application Developer's Guide. Linux QMI SDK. Document: 4110914.
* http://netlab.dhis.org/wiki/hardware:huawei:e3272.
