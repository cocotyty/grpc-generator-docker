#!/bin/sh
set -e
ls -alh /usr/local/include/googleapis
cmd="protoc -I/usr/local/include -I. \
  -I/usr/local/include/googleapis ${@}"
echo $cmd
sh -c "$cmd"