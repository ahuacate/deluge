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
- [x] Deluge LXC with Deluge SW installed as per [Deluge LXC - Ubuntu 18.04](https://github.com/ahuacate/proxmox-lxc-media/blob/master/README.md#400-deluge-lxc---ubuntu-1804).
- [x] FileBot is installed as per [FileBot Installation on Deluge LXC - Ubuntu 18.04](https://github.com/ahuacate/proxmox-lxc-media/blob/master/README.md#700-filebot-installation-on-deluge-lxc---ubuntu-1804)

Tasks to be performed are:
- [ ] 1.00 Configure Deluge Preferences
- [ ] 2.00 Download deluge-postprocess.sh script for FileBot
- [ ] 3.00 How to Log into Deluge
- [ ] 00.00 Patches & Fixes

## 1.00 Configure Deluge Preferences
Before you start using Deluge you must configure your Deluge client preferences. 

### 1.01 Manual Configuration
This is the minimum required to get Deluge working without any tuning.

In your web browser type `http://192.168.30.113:8112/` to connect to the Deluge webUI and login with the default password `deluge`.
Click `Preferences` and set the following:

| Deluge Setting | Value | Note
| :---  | :---: | :---
| **Downloads**
| Download to | `/mnt/downloads/deluge/incomplete`
| **Daemon**
| Daemon port | `588461`
| Allow Remote Connections | `☑`
| **Plugins**
| Execute | `☑` | Action: Add a Event > Torrent Complete > Command: `/home/media/.config/deluge/deluge-postprocess.sh`
| Label | `☑` | Action: Create a label named `lazy` (all lowercase). Set the lazy label option > Folders > Apply folder settings > Move completed to: `/mnt/downloads/deluge/complete/lazy`

### 1.02 Download pre-configured Deluge Preferences setting files
The easiest method is download precongigured Deluge setting files. You must download three files `core.conf`, `execute.conf` and `label.conf`, which includes all of the above (Step 1.01) and more.

So with the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:

```
sudo systemctl stop deluge &&
wget https://github.com/ahuacate/deluge/blob/master/core.conf -P /home/media/.config/deluge &&
wget https://github.com/ahuacate/deluge/blob/master/execute.conf -P /home/media/.config/deluge &&
wget https://github.com/ahuacate/deluge/blob/master/label.conf -P /home/media/.config/deluge &&
chown 1005:1005 /home/media/.config/deluge/*.conf &&
sudo chmod 600 /home/media/.config/deluge/*.conf &&
sudo systemctl restart deluge
```

## 2.00 Download deluge-postprocess.sh script for FileBot
Deluge needs to be configured with the Execute Plugin to run the `deluge-postprocess.sh` script available [HERE](https://github.com/ahuacate/deluge/blob/master/deluge/deluge-postprocess.sh). This script works with Deluge and commands FileBot to rename newly finished FlexGet added torrents and copy the renamed files to your NAS.

So with the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:

```
wget  https://github.com/ahuacate/deluge/blob/master/deluge-postprocess.sh -P /home/media/.config/deluge &&
sudo chmod +rx /home/media/.config/deluge/deluge-postprocess.sh &&
chown 1005:1005 /home/media/.config/deluge/deluge-postprocess.sh
```

## 3.00 How to Log into Deluge
In your web browser type `http://192.168.30.113:8112/` and login with the default password. 
