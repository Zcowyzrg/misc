#!/bin/sh

uid=1000
gid=1000

for f in $(ls /dev/disk/by-label)
do
  if [[ $f != "Recovery" ]]; then
    if mount | grep -q /run/mount/$f; then
      echo skipping $f - already mounted
    else
      echo mounting $f in /run/mount/$f
      mkdir -p /run/mount/$f
      mount.ntfs-3g -o uid=$uid,gid=$gid,fmask=0113,dmask=0022 /dev/disk/by-label/$f /run/mount/$f
    fi
  fi
done
