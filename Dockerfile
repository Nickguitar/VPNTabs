FROM debian
ARG CONFIG_FILE
ENV CONF="openvpn --config /ovpn/${CONFIG_FILE}"
RUN apt -q update && apt install -qy openvpn squid
RUN ln -s /dev/null /var/log/squid/access.log
COPY ./squid.conf /etc/squid/squid.conf
COPY ./config_files/* /ovpn/
EXPOSE 3128
WORKDIR "/ovpn"
RUN echo "#!/bin/bash\n service squid start\n squid\n ${CONF} " > entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
