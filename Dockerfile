FROM debian:bullseye AS builder

ARG GRPC_VERSION=1.48.0

# install needed php packages
RUN   apt-get update && apt-get install -y \
    	build-essential git cmake

RUN  cd /usr/src && \
     git clone --recurse-submodules -b v${GRPC_VERSION} --depth 1 --shallow-submodules https://github.com/grpc/grpc && \
     mkdir -p grpc/cmake/build && \
     cd grpc/cmake/build && \
     cmake ../.. && \
     make protoc grpc_php_plugin


FROM debian:bullseye-slim

COPY --from=builder /usr/src/grpc/cmake/build/third_party/protobuf/protoc /usr/local/bin
COPY --from=builder /usr/src/grpc/cmake/build/grpc_php_plugin /usr/local/bin/protoc-gen-php_grpc

WORKDIR /mnt
ENTRYPOINT ["/usr/local/bin/protoc"]