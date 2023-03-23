#!/usr/bin/env bash

DIR=$(realpath ${0%/*/*/*})
cd $DIR
set -ex

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
