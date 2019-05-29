# syntax=docker/dockerfile:1.0-experimental
FROM alpine:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="mateumann@gmail.com" \
    org.label-schema.name="tor" \
    org.label-schema.description="Image for running a single Tor instance" \
    org.label-schema.usage="/LICENSE" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-url="https://github.com/mateumann/docker-pproxy.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version="0.1.0" \
    org.label-schema.schema-version="1.0" \
    com.microscaling.license="MIT" 

RUN apk update && \
    apk add --no-cache tor && \
    sed "1s/^/SOCKSPort 0.0.0.0:9050\n/; s/^Log\ notice\ .*/Log notice stdout/" /etc/tor/torrc.sample > /etc/tor/torrc

USER tor

EXPOSE 9050

VOLUME ["/var/lib/tor"]

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
