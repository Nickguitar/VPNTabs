FROM debian
RUN apt -qq -y update && apt install -qq -y openvpn squid tor
RUN ln -s /dev/null /var/log/squid/access.log
COPY ./squid.conf /etc/squid/squid.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
RUN mkdir /ovpn/
WORKDIR "/ovpn"
ENTRYPOINT ["/entrypoint.sh"]
