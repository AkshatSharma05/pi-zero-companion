# Pi Zero Companion

Buildroot external tree for a Raspberry Pi Zero 2 W USB-Ethernet companion.

The Pi's micro-USB data port is a legacy `g_ether` gadget (not ConfigFS). It
uses DWC2 in peripheral-only mode and provides a static management link:

- Pi: `192.168.7.2/24` on `usb0`
- PC: `192.168.7.1/24` on the Pi's USB Ethernet interface

## Prerequisites

- A Buildroot source tree (the project was developed with `~/buildroot`).
- A 64-bit ARM Buildroot toolchain compatible with the defconfig.
- An SD card for the Pi.
- A USB data cable connected to the Pi Zero 2 W's data port.

## Reproduce a build

```bash
mkdir -p ~/projects

cd ~/buildroot

make O=~/projects/pi-zero-output \
  BR2_EXTERNAL=~/projects/pi-zero-companion \
  pi_zero_companion_defconfig

make O=~/projects/pi-zero-output \
  BR2_EXTERNAL=~/projects/pi-zero-companion
```

The resulting image is:

```text
~/projects/pi-zero-output/images/sdcard.img
```

### Set the root password

The image allows root SSH password login, but you must configure a non-empty
root password before building:

```bash
cd ~/buildroot
make O=~/projects/pi-zero-output menuconfig
```

Set **System configuration → Root password**, then save it back to this
external tree:

```bash
make O=~/projects/pi-zero-output \
  BR2_EXTERNAL=~/projects/pi-zero-companion \
  BR2_DEFCONFIG=~/projects/pi-zero-companion/configs/pi_zero_companion_defconfig \
  savedefconfig
```

Rebuild the image after changing the password.

## Flash the SD card

```bash
sudo dd if=~/projects/pi-zero-output/images/sdcard.img \
  of=/dev/sdX bs=4M conv=fsync status=progress
sync
```

## USB Ethernet and SSH

The gadget MAC addresses are fixed so the PC interface name remains stable:

```text
enxc6eacc95cf5f
```

Configure the PC-side address once with NetworkManager:

```bash
nmcli connection add type ethernet ifname enxc6eacc95cf5f \
  con-name pi-zero-usb ipv4.method manual \
  ipv4.addresses 192.168.7.1/24 ipv6.method disabled
nmcli connection up pi-zero-usb
```

If the interface has a different name, locate it with `ip -br link` and use
that name in the commands above.

Validate the connection:

```bash
ping -c 3 192.168.7.2
ssh root@192.168.7.2
```

## Design notes

- `dtoverlay=dwc2,dr_mode=peripheral` avoids the DWC2 OTG role-switch path.
- The kernel fragment selects `CONFIG_USB_DWC2_PERIPHERAL=y` and disables
  `CONFIG_USB_DWC2_DUAL_ROLE`.
- `g_ether` remains the legacy gadget implementation.
- The board post-build script creates the persistent `usb0` static network
  configuration and enables root password SSH login.
