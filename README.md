# VPN Container Tabs
Force the traffic of a Firefox container tab to pass through a VPN or Tor

On newer version of Firefox, it is possible to use [container tabs](https://support.mozilla.org/en-US/kb/containers), which isolate the cookies from the normal tabs.

It is also possible to assign different proxies to be used in different containers using container tabs.

Then, we can create a docker container with a VPN client and a proxy server running. By doing this, we can assign our docker proxy to a container tab so that all the traffic of that tab goes through the VPN that is running only inside the docker container.

## Screenshots

![image](https://user-images.githubusercontent.com/3837916/137650333-093842d5-f6a0-4fe9-8f0b-769a8dbc9bdb.png)
![image](https://user-images.githubusercontent.com/3837916/137136513-26b4cd53-c8cc-4486-94e1-92d16332bdc0.png)


## Usage

### 1. Install docker
[See instructions here](https://docs.docker.com/engine/install/)

### 2. Clone the repository
```
git clone https://github.com/Nickguitar/VPNTabs
```
**Important note:** if your user doesn't have permission to run docker containers you will need to run the script with `sudo`

### 3. Place your VPN files in the diretory `ovpn_files`
```
cp /path/to/vpn/files/* ovpn_files/
```

### 4. Build the docker image
```
./VPNTabs --build
```
### 5. Run the container with the specified ovpn file or with `--tor`
It's only recommended to use `--map` in private networks, or if using good firewall rules if in a public network
```
./VPNTabs --run <OPENVPN FILE> [--map] [--port <PORT>] [--name <CONTAINER NAME>] [--ask-credendials]
e.g.:
./VPNTabs --run mullvad_us_all.ovpn --name Mullvad_US
./VPNTabs --run --tor
```

*[Alternative] Instead using* `VPNTabs` *You can run your custom script or use docker-compose. Here is an example:*
```
# To run q VPN container
docker run -d \
--cap-add=NET_ADMIN \
--device /dev/net/tun \
--sysctl net.ipv6.conf.all.disable_ipv6=0 \
-p "3128:3128" \
--name "<NAME YOUR CONTAINER>" \
-e OVPN_FILE="<YOUR VPN FILE NAME>" \
-e VPN_USER="<YOUR VPN USER>" \
-e VPN_PASSWORD="YOUR VPN PASSWORD" \
-v ""<PATH/TO/YOUR/VPN/FILES/FOLDER>:/ovpn" \
squid_openvpn

# To run a TOR container
docker run -d \
--name "TOR" \
-p "9050:9050" \
-e TOR_CONTAINER="1" \
squid_openvpn
```
*The envoriment variable* `OVPN_FILE` *is used to know which file OpenVPN should use*

*For docker-compose you can use `docker-compose-ylm` configs are well documented in the `docker-compose.ylm`*

### If everything is ok, you should see this output
```
$ ./VPNTabs --run ovpn_files/mullvad_br_sao.conf

     ___
     "._`-.         (\-.
        '-.`;.--.___/ _`>
           `"( )    , ) 
              \\----\-\
               VPN Tabs

        Use Firefox container
            tabs with VPN
  Nicholas Ferreira & Gabriel Belli

[+] Proxy server is running on http://172.17.0.2:3128 with mullvad_br_sao.conf

Container id:  07b08c7c4e92
```

### 6. Add Multi Account Containers to Firefox

- [Multi Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/)

### 7. Create a container and add a proxy setting

![GIF](https://user-images.githubusercontent.com/14808000/156259185-110ce85d-daa4-4087-b530-7c48c4487108.gif)

### You're done

Now every website you access using those container tabs will pass through your local proxy, which points to a docker container whose traffic pass through your VPN. =)

### Comments

- You can generate as many containers as you want, each one running a different VPN config file. In this way, it is possible to have multiple container tabs, each with a different VPN.
- To generate another container with another ovpn config file, just place the config file inside `ovpn_files` and follow step 5.
- VPNTabs has a kill switch which is built into its proxy. When connected to a VPN, VPNTabs uses Squid Proxy, which is configured to only use VPN's interface as gateway. When using TOR instead VPN, the TOR proxy won't route if TOR network is down anyway.
- Since the VPN client is running inside a docker container, all your other network traffic isn't being tunneled through the VPN. The only connections going through the VPN are those pointing to the local proxy you've created.

### Video

[![image](https://user-images.githubusercontent.com/3837916/139519441-5124bb99-3460-4ef6-8959-fc3a2f2c5e6e.png)](https://www.youtube.com/watch?v=1JmR-XJ0Ug0
