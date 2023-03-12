#!/usr/bin/env bash

crontab -l | (
  echo "TZ=Asia/Shanghai"
  cat | grep -v -F "TZ="
) | crontab -

systemctl restart cron

crontab -l
