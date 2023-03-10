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

backup(){
  to=$(dirname "$TO/$1")
  mkdir -p $to
  rsync -pavI $HOST:/$1 $to &
}

backup root/.ssh/*
backup etc/ssh/*_key
backup etc/ssh/*.pub

try_wait(){ wait || \
  {
    echo "error : $?" >&2
    exit 1
  }
}

try_wait

