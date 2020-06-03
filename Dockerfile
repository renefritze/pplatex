FROM debian:stable-slim as builder

RUN apt update && \
  apt install -y cmake build-essential libpcre3-dev && \
  mkdir /build

COPY . /src

RUN cd /build && cmake /src && \
  make && ./src/pplatex -h


FROM debian:stable-slim

COPY --from=builder /build/src/pplatex /usr/local/bin/

# minimal check if executable works
RUN pplatex -h
