#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

if [ -v 1 ]; then
  HOST=$1
else
  echo "USAGE : $0 hostname"
  exit 1
fi

set -ex

TO=~/backup/host/$HOST

rsync --chown=root:root -pavI $TO/ $HOST:/
