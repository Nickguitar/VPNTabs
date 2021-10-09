#!/bin/bash
service squid start squid
openvpn --config /ovpn/$OVPN_FILE 
