# Arch linux install

- https://wiki.archlinux.org/title/installation_guide
- https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux

## Prepare partitions and filesystems

```
doas cfdisk /dev/sdb
```
Size: 120, split to: 32 (root) + 78 (home) + remainder (swap)

```
mkfs.ext4 /dev/sdb1
mkfs.ext4 /dev/sdb2
mkswap /dev/sdb3
e2label /dev/sdb1 ssdroot
e2label /dev/sdb2 ssdhome
```

## Arch bootstrap

```
mount /dev/sdb1 /mnt -o relatime
mount /dev/sdb2 /mnt/home/ -o relatime
pacstrap -c /mnt base linux linux-firmware nano
# the above will take a while, use "-c" to use packages cache on host
genfstab -U /mnt >> /mnt/etc/fstab
# edit fstab to correct the swap UUID to /dev/sdb3, use "lsblk -o NAME,UUID" to print partitions
umount /mnt/dev
```

## Chroot to new installation
```
arch-chroot /mnt
```
### Post-install system tuning

```
# Extra packages
pacman -S vim mc zip unzip p7zip iwd grub
# System time
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
# Locale
vim /etc/locale.gen
locale-gen
echo 'LANG=pl_PL.UTF-8' > /etc/locale.conf
echo 'KEYMAP="pl"
FONT="lat2-16"' > /etc/vconsole.conf
# Host name
echo 'myhost' > /etc/hostname
```

## Wireless network
```
systemctl enable iwd.service
systemctl enable systemd-resolved.service
```

/etc/iwd/main.conf
```
[General]
EnableNetworkConfiguration=true
[Network]
NameResolvingService=systemd
```

## Boot - MBR

/etc/mkinitcpio.conf
```
MODULES=(i915)
```

/etc/default/grub
```
GRUB_CMDLINE_LINUX_DEFAULT="verbose"
```
```
grub-install --target=i386-pc /dev/sdb
```

## Boot - UEFI

| Device | Mountpoint | Size | Type |
|--------|------------|------|------|
| /dev/sda2 | /efi     | 100M | EFI system |
| /dev/sda5 | /boot   | 1G   | Linux extended boot |
| /dev/sda6 | /       | 120G | Linux filesystem |

Using [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot) and separate partitions for `/efi` and `/boot` to allow for bigger kernel size. This is the content of existing 100M `/efi` partition:
```
/efi/EFI/Boot/bootx64.efi -- the same as systemd-bootx64.efi
/efi/EFI/Microsoft/Boot/
/efi/EFI/systemd/systemd-bootx64.efi
/efi/loader/entries/a2.conf -- this one is not necessary, i.e. for test only
/efi/loader/loader.conf
   timeout 3
/efi/initramfs-linux.img -- for test only
/efi/shellx64.efi
/efi/vmlinuz-linux -- test only
```
Boot partition content:
```
/boot/loader/entries/arch.conf
   title Arch Linux
   linux /vmlinuz-linux
   initrd /intel-ucode.img
   initrd /initramfs-linux.img
   options root="UUID=4db760df-1940-40ff-a391-82c40722a7cf" rw
/boot/initramfs-linux.img
/boot/vmlinuz-linux
```

Use `bootctl update` to update bootloader.

## Tweaks

- https://wiki.archlinux.org/title/getty#Have_boot_messages_stay_on_tty1
- https://wiki.archlinux.org/title/Solid_state_drive#Periodic_TRIM
