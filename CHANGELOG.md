## Version 2.0
 - Now using an SOCKS proxy (ssh -l) instead of Squid proxy. The reason behind this is to keep it simple and to fix WebRTC IP leaks.
 - Now repo includes an OVERLY COMMENTED docker-compose.yml example to use instead of the original shell script.
 - Code clean up and other minor changes.

## Version 1.0 (BETA)

Various changes were made in this version along its existence. By the lack of versioning, they were untracked.

### Original version:
 - Debian container with Squid proxy and openvpn
 - Shell script interface

### First Changes:
 - Added tor proxy option

### Alpine revolution:
 - Moved to Alpine Linux
 - Runsv for running the multiple services
 - Gettext to substitute string in squid.conf with envoriment variables
 - Added a killswtich with iptables
