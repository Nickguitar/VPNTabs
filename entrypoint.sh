#!/bin/bash
if [[ $TOR_CONTAINER ]]; then
	tor -f /etc/tor/torrc
else
	service squid start squid
	openvpn --config /ovpn/$OVPN_FILE
fi
