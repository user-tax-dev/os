#!/usr/bin/env bash

set -ex

init=/usr/bin/init-zram-swapping

sd '^echo \$mem' 'echo zstd > /sys/block/zram0/comp_algorithm ; echo $$mem' $init
sd '^mem=\$\(.*\)' 'mem=$(echo $((totalmem * 2 * 1024))|cut -d. -f1)' $init

cat $init
echo ''
systemctl enable --now zram-config

sysctl_conf=/etc/sysctl.conf

sysctl_set() {
  if ! grep -q "vm.$1" "$sysctl_conf"; then
    echo -e "\nvm.$1=$2\n" >>$sysctl_conf
  fi
  sysctl vm.$1=$2
}

sysctl_set page-cluster 0
sysctl_set extfrag_threshold 0
sysctl_set swappiness 100
sed -i '/^[[:space:]]*$/d' $sysctl_conf

sysctl -p
