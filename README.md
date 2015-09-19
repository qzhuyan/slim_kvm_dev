# What?
Scripts to build A lightweight linux kernel development vm by using virtio drivers

Mainly for non-hardware related kernel feature development.

# Feature
1. Virtio based, all devices are virtualized.
2. Very thin, no kernel modules depedency.
3. VM could be started very fast like start a docker.
4. Fast kernel build becasue most of features are disabled.
5. Pure&clean ubuntu LTS rootfs

#Usage:
1. build rootfs
```bash
sudo ./build_img.sh
```
2. build kernel with config file
```bash
cp Config $kenrel_src/
cd $kernel_src
make config && make ...
```

3. start kvm with complied kernel image
```bash
   sudo ./start.sh ./rootfs.img $PathToKernel
```
4. to ssh with pwd: beammeUP
```bash
   ssh 127.0.0.1 -p 4444 -l root
```
5. stop kvm
```bash
   C-A x
```

