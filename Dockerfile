FROM alpine
RUN apk --no-cache update && apk --no-cache upgrade
RUN apk --no-cache add \
    openvpn \ 
    squid \
    openresolv \
    bash \
    gettext \
    runit \
    tor
COPY app /app
RUN mkdir /etc/squid/conf.d
RUN touch /etc/squid/conf.d/squid
RUN echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
RUN mkdir /ovpn/
WORKDIR "/ovpn"
ENV LAN =
ENTRYPOINT ["runsvdir", "/app"]
