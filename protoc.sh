#!/bin/sh
set -e
cmd="protoc -I/usr/local/include -I. \
  -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis ${@}"
echo $cmd
sh -c "$cmd"