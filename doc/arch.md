
# Installation media

Create USB drive in GPT mode, with two partitions:
- EFI
- VFAT (label: Samsung16)

On the Samsung16 partition, the `/arch` directory contains `x86_64/airootfs.sfs` - the image with the installer (squashfs)

UEFI will by default run `BOOT\BOOTx64.efi`. This can be a bootloader or also a shell. If the bootloader is systemd-boot, you can place shell in `\shellx64.efi` and there will be an automatically created entry for it in the bootloader menu.

The shell will run `startup.nsh` if it exists. The script can contain a command to boot linux.

The command to boot linux image (which is a proper EFI image) is:
```
arch\boot\x86_64\vmlinuz-linux initrd=\arch\boot\x86_64\initramfs-linux.img archisobasedir=arch archisodevice=/dev/disk/by-label/Samsung16
```
The paths here assume you are on the Samsung16 partition, change it with `FS1:` (see `map` for available filesystems)

For the systemd-boot, the configuration on the EFI partition is:
```
\loader\entries\archiso-x86_64-linux.conf:

title   Arch Linux install medium (x86_64, UEFI)
linux   /EFI/archlinux/x86_64/vmlinuz-linux
initrd  /EFI/archlinux/intel-ucode.img
initrd  /EFI/archlinux/x86_64/initramfs-linux.img
options archisobasedir=arch archisodevice=/dev/disk/by-label/Samsung16
```

