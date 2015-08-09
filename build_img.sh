#/bin/bash
ARCH=amd64
RELEASE=trusty
DIR=rootfs
MIRROR=http://archive.ubuntu.com/ubuntu
IMG=rootfs.img

die() {
    echo $1;
    exit 1
}

mkdir $DIR

debootstrap --include=openssh-server,erlang-base --arch $ARCH $RELEASE  $DIR $MIRROR  \
    || die "build ubuntu rootfs failed"

# Make root passwordless for convenience.
sed -i '/^root/ { s/:x:/::/ }' $DIR/etc/passwd
cp passwd $DIR/etc/passwd
cp sshd_config $DIR/etc/ssh/sshd_config

# Add a getty on the virtio console
echo 'V0:23:respawn:/sbin/getty 115200 hvc0' |  tee -a $DIR/etc/inittab

# Automatically bring up eth0 using DHCP
printf '\nauto eth0\niface eth0 inet dhcp\n' |  tee -a $DIR/etc/network/interfaces


# Set up my ssh pubkey for root in the VM
mkdir $DIR/root/.ssh/
cat ~/.ssh/id_?sa.pub |  tee $DIR/root/.ssh/authorized_keys

dd if=/dev/zero of=$IMG bs=1M seek=4095 count=1

mkfs.ext4 -F $IMG

mkdir /mnt/$RELEASE
mount -o loop $IMG /mnt/$RELEASE
cp -a $DIR/. /mnt/$RELEASE/.
umount /mnt/$RELEASE/.

