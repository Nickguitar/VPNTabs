FROM alpine
RUN apk --no-cache update && apk --no-cache upgrade
RUN apk --no-cache add \
    openvpn \
    openssh \
    openresolv \
    bash \
    runit \
    tor
COPY app /app
RUN mv /app/openvpn/update-resolv-conf /etc/openvpn/update-resolv-conf
RUN mv /app/proxy/sshd_config etc/ssh/sshd_config
RUN echo 'root:dummy_passwd'|chpasswd
RUN ssh-keygen -A
RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/sshkey -q -N ""
RUN mv /root/.ssh/sshkey.pub /root/.ssh/authorized_keys
RUN echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
RUN mkdir /ovpn/
CMD ["runsvdir", "/app"]
