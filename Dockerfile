FROM debian
RUN apt -q update && apt install -qy openvpn squid
RUN ln -s /dev/null /var/log/squid/access.log
EXPOSE 3128
COPY ./squid.conf /etc/squid/squid.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN mkdir /ovpn/
WORKDIR "/ovpn"
ENTRYPOINT ["/entrypoint.sh"]
