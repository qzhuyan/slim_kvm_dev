#/bin/bash
IMG=${1:-"rootfs.img"}
KERNEL=${2:-"/boot/vmlinuz-3.19.0-18-generic"}

kvm -kernel $KERNEL \
-drive file=${IMG},if=virtio \
-net nic,model=virtio,macaddr=52:54:00:12:34:56 \
-net user,hostfwd=tcp:127.0.0.1:4444-:22 \
-append 'root=/dev/vda rw console=hvc0' \
-chardev stdio,id=stdio,mux=on,signal=off \
-device virtio-serial-pci \
-device virtconsole,chardev=stdio \
-mon chardev=stdio \
-display none

