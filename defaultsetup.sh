#!/bin/bash
# Nicholas Ferreira - github.com/Nickguitar
# 08/10/21

if [ -z $1 ]; then
	echo "[-] Usage: $0 <openvpn_file.conf> [port (default:3128)]"
	exit
fi

port=3128
if [ ! -z $2 ]; then
	if [[ ! "$2" =~ ^[0-9]+$  ]]; then
		echo "[-] The port must be numerical."
		exit
    fi
    if [[ "$2" > 65535 ]]; then
        echo "[-] The port is not valid (above 65535)."
        exit
    elif [[ "$2" < 1 ]]; then
        echo "[-] The port is not valid (below 1)."
        exit
    fi
	port=$2
fi;

docker run -d --rm \
--cap-add=NET_ADMIN \
--device /dev/net/tun \
--sysctl net.ipv6.conf.all.disable_ipv6=0 \
-p $port:3128 \
-e OVPN_FILE="$1" \
-v "ABSOLUTEPATH"/ovpn_files:/ovpn \
squid_openvpn:1.0
