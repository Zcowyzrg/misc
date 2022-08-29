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

## Boot

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

## Tweaks

- https://wiki.archlinux.org/title/getty#Have_boot_messages_stay_on_tty1
- https://wiki.archlinux.org/title/Solid_state_drive#Periodic_TRIM
