# syntax=docker/dockerfile:1.0-experimental
FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="mateumann@gmail.com" \
    org.label-schema.name="pproxy" \
    org.label-schema.description="Image for running a number of Tor processes" \
    org.label-schema.usage="/LICENSE" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-url="https://github.com/mateumann/docker-pproxy.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version="0.0.1" \
    org.label-schema.schema-version="1.0" \
    com.microscaling.license="MIT" 

COPY services /etc/service

RUN apk --update add --no-cache runit tor
RUN sed "1s/^/SOCKSPort 0.0.0.0:9050\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.0/; " /etc/tor/torrc.sample > /etc/tor/torrc.0
RUN sed "1s/^/SOCKSPort 0.0.0.0:19051\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.1/; " /etc/tor/torrc.sample > /etc/tor/torrc.1
RUN sed "1s/^/SOCKSPort 0.0.0.0:19052\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.2/; " /etc/tor/torrc.sample > /etc/tor/torrc.2
RUN sed "1s/^/SOCKSPort 0.0.0.0:19053\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.3/; " /etc/tor/torrc.sample > /etc/tor/torrc.3
RUN sed "1s/^/SOCKSPort 0.0.0.0:19054\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.4/; " /etc/tor/torrc.sample > /etc/tor/torrc.4
RUN sed "1s/^/SOCKSPort 0.0.0.0:19055\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.5/; " /etc/tor/torrc.sample > /etc/tor/torrc.5
RUN sed "1s/^/SOCKSPort 0.0.0.0:19056\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.6/; " /etc/tor/torrc.sample > /etc/tor/torrc.6
RUN sed "1s/^/SOCKSPort 0.0.0.0:19057\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.7/; " /etc/tor/torrc.sample > /etc/tor/torrc.7
RUN sed "1s/^/SOCKSPort 0.0.0.0:19058\n/; s/^Log\ notice\ .*/Log notice stdout/; s/^DataDirectory.*/DataDirectory \/var\/lib\/tor\/tor.8/; " /etc/tor/torrc.sample > /etc/tor/torrc.8
RUN mkdir /var/lib/tor/tor.0 /var/lib/tor/tor.1 /var/lib/tor/tor.2 /var/lib/tor/tor.3 /var/lib/tor/tor.4 /var/lib/tor/tor.5 /var/lib/tor/tor.6 /var/lib/tor/tor.7 /var/lib/tor/tor.8
RUN chown tor -R /etc/service/tor.* /var/lib/tor/

EXPOSE 9050

VOLUME ["/var/lib/tor"]

CMD ["runsvdir", "/etc/service"]
