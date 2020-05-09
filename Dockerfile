FROM debian:stable-slim AS certs

RUN apt-get update && apt-get -uy upgrade
RUN apt-get -y install ca-certificates && update-ca-certificates

FROM golang:1.13 AS builder

WORKDIR /app
COPY . .
WORKDIR /app/coredns
RUN rm -f coredns
RUN make

FROM scratch

COPY --from=certs /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /app/coredns/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]

