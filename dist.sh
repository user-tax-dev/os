#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

set -ex

org=usertax

for os in $(find ./build/* -maxdepth 0 -type d); do
  os=$(basename $os)
  echo $os
  sh -c "./build.sh $org $os && exec docker push -a $org/dev_$os"
done

