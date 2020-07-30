#!/bin/zsh
set -e
echo 'alias protoc='"'"'docker run -it -v $PWD:/app tangyangzh/grpc-generator:latest'"'"'' >> ~/.zshrc
