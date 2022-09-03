Refer to:
- https://wiki.archlinux.org/title/Avahi
- https://wiki.archlinux.org/title/CUPS
- https://wiki.archlinux.org/title/CUPS/Printer-specific_problems

Install software:
```
pacman -S avahi cups nss-mdns
git clone https://aur.archlinux.org/brlaser-git.git
cd brlaser-git && makepkg && pacman -U brlaser*.pkg.tar.zst
```

Modify `/etc/nsswitch.conf`:
```
hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

Start daemons:
```
systemctl start avahi-daemon
systemctl start cups
```

Search for network printer:
```
ippfind
avahi-browse --all --resolve [--ignore-local] [--terminate]
avahi-discover
```

Print:
```
lpq
lp document.pdf
lpoptions -l
lp -P 1,3 -o brlaserEconomode=True document.pdf
```

