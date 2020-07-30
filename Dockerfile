FROM golang:1.14.2-alpine3.11 as BUILD

# install all dependencies software
RUN apk update && apk add git && \
    rm -rf /var/cache/apk/*

# install protoc-gen-go and protoc-gen-grpc-gateway
RUN go get -v -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go install -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
    && go get -v github.com/golang/protobuf/protoc-gen-go

FROM alpine:3.11
RUN apk update && apk add git curl grpc protobuf-dev && \
    rm -rf /var/cache/apk/*
COPY --from=BUILD /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis /usr/local/include/googleapis
COPY --from=BUILD /go/bin /usr/local/bin
# change protoc-gen-go include postion
RUN mkdir -p /usr/local/include && mv  /usr/include/google /usr/local/include/google
COPY ./protoc.sh /bin/protoc.sh
RUN chmod +x /bin/protoc.sh
RUN mkdir /app
WORKDIR /app
ENTRYPOINT [ "/bin/protoc.sh" ]
