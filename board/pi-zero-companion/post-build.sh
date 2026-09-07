#!/bin/sh
set -eu

# Add an HDMI console without affecting the UART console.
if [ -e "${TARGET_DIR}/etc/inittab" ]; then
	grep -qE '^tty1::' "${TARGET_DIR}/etc/inittab" || \
		sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L tty1 0 vt100 # HDMI console' "${TARGET_DIR}/etc/inittab"
fi

cat > "${TARGET_DIR}/etc/network/interfaces" <<'EOF'
auto lo
iface lo inet loopback

auto usb0
iface usb0 inet static
    address 192.168.7.2
    netmask 255.255.255.0
EOF

# Explicitly permit SSH root/password login when a non-empty Buildroot root
# password is configured.
cat >> "${TARGET_DIR}/etc/ssh/sshd_config" <<'EOF'
PermitRootLogin yes
PasswordAuthentication yes
EOF
