# Deluge Build
This recipe is for setting up Deluge.

Network Prerequisites are:
- [x] Layer 2 Network Switches
- [x] Network Gateway is `192.168.1.5`
- [x] Network DNS server is `192.168.1.5` (Note: your Gateway hardware should enable you to a configure DNS server(s), like a UniFi USG Gateway, so set the following: primary DNS `192.168.1.254` which will be your PiHole server IP address; and, secondary DNS `1.1.1.1` which is a backup Cloudfare DNS server in the event your PiHole server 192.168.1.254 fails or os down)
- [x] Network DHCP server is `192.168.1.5`

Other Prerequisites are:
- [x] Synology NAS, or linux variant of a NAS, is fully configured as per [SYNOBUILD](https://github.com/ahuacate/synobuild#synobuild).
- [x] Proxmox node fully configured as per [PROXMOX-NODE BUILDING](https://github.com/ahuacate/proxmox-node/blob/master/README.md#proxmox-node-building).
- [x] pfSense is fully configured as per [HAProxy in pfSense](https://github.com/ahuacate/proxmox-reverseproxy/blob/master/README.md#haproxy-in-pfsense)
- [x] Deluge LXC with Deluge SW installed as per [Deluge LXC - Ubuntu 18.04](https://github.com/ahuacate/proxmox-lxc/blob/master/README.md#50-deluge-lxc---ubuntu-1804).

Tasks to be performed are:
- [ ] 1.0 Setup Jellyfin and perform base configuration
- [ ] 2.0 Jellyfin Common Settings
- [ ] 3.0 Add media to the Jellyfin Library
- [ ] 4.0 Edit Jellyfin `Storm` User
- [ ] 5.0 Create Jellyfin Remote Access Users
- [ ] 6.0 Create Jellyfin Media Player Users
- [ ] 00.00 Patches & Fixes


## 1.0 Download trigger-decompress.sh script for Flexget
Deluge needs to be configured with the Execute plugin to run the `trigger-decompress.sh` script (available [HERE](https://github.com/ahuacate/deluge/blob/master/deluge/trigger-decompress.sh)) when any torrent is done downloading.
So with the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:

```
wget  https://github.com/ahuacate/deluge/blob/master/deluge/trigger-decompress.sh -P /home/media/.config/deluge &&
chown media:media /home/media/.config/deluge/trigger-decompress.sh &&
chmod u+x /home/media/.config/deluge/trigger-decompress.sh
```
## 1.0 Setup Deluge and perform base configuration
In your web browser type `http://192.168.30.113:8112/` and login with the default password. 
