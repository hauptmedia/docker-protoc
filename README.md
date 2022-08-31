# Docker GRPC / Protobuf

Protobuf / GRPC Generator Docker Container with integrated PHP plugin


## Usage

To generate the GRPC PHP Client and PHP data structures in your current directory use

```
docker run --rm -v$(pwd):/mnt hauptmedia/protoc -I ./proto/ --php_out=./src --php_grpc_out=./src ./proto/gateway.proto
```
