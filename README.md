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
- [ ] 2.00 Download the latest Execute Plugin for FileBot deluge-postprocess.sh script
- [ ] 3.00 Download the latest Label Plugin configuration file
- [ ] 4.00 Download the latest Autoremoveplus Plugin configuration file
- [ ] 00.00 Patches & Fixes

## 1.00 Configure Deluge Preferences
Your Deluge should be ready to go when you installed Deluge as shown instructions [HERE](https://github.com/ahuacate/proxmox-lxc-media/blob/master/README.md#400-deluge-lxc---ubuntu-1804). 

But if you want to modify or update your config with the latest from our GitHub repository read-on.

### 1.01 Manual Configuration
This is the minimum required to get Deluge working with Sonarr, Radarr and family of Apps.
In your web browser type `http://192.168.30.113:8112/` to connect to the Deluge WebUI and login with the default password `deluge`.

Click `Preferences` and set the following:

| Deluge Preferences | Value | Note
| :---  | :---: | :---
| **Downloads**
| Download to | `/mnt/downloads/deluge/incomplete`
| **Daemon**
| Daemon port | `588461`
| Allow Remote Connections | `☑`
| **Plugins**
| Autoremoveplus | `☑` |
| Execute | `☑` | Note: See below.
| Label | `☑` | Note: See below.

To enable Deluge Plugins you must restart Deluge after flagging the plugin. After restart Autoremoveplus, Execute & Label Plugins should be automatically configured and working with our pre-installed plugin settings files.

To restart Deluge go to the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:
```
sudo systemctl restart deluge
```
Now in Deluge Preferences you should see both the Execute & Label Plugins in the left column. Each plugin setting should be as follows:

|  Deluge Preferences | Value | Value
| :---  | :---: | :---
| Label | Shown on the far left WebUI column. | Label Preferences: `The Label plugin is enabled.`
| Execute | Event: `Torrent Complete` | Command: `/home/media/.config/deluge/deluge-postprocess.sh`


## 2.00 Download the latest Execute Plugin for FileBot deluge-postprocess.sh script
Filebot renames and moves all your Flexget downloads ready for viewing on your NAS. This action is done by running a shell script called `deluge-postprocess.sh`. Deluge uses the Execute Plugin to execute `deluge-postprocess.sh` whenever Deluge completes a torrent download.

The script (`deluge-postprocess.sh`) is for Deluge only. It was installed when you completed the Deluge installation guide shown  [HERE](https://github.com/ahuacate/proxmox-lxc-media/blob/master/README.md#400-deluge-lxc---ubuntu-1804).

In the event you want to upgrade or overwrite your `deluge-postprocess.sh` you can with these instructions. 

With the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:

```
pkill -9 deluged &&
sleep 5 &&
wget  https://raw.githubusercontent.com/ahuacate/deluge/master/deluge-postprocess.sh -P /home/media/.config/deluge &&
chmod +rx /home/media/.config/deluge/deluge-postprocess.sh &&
chown 1005:1005 /home/media/.config/deluge/deluge-postprocess.sh &&
sudo systemctl restart deluge
```

## 3.00 Download the latest Label Plugin configuration file
With the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:
```
pkill -9 deluged &&
sleep 5 &&
wget  https://raw.githubusercontent.com/ahuacate/deluge/master/label.conf -P /home/media/.config/deluge &&
chown 1005:1005 {/home/media/.config/deluge/label.conf} &&
sudo systemctl restart deluge
```

## 4.00 Download the latest Autoremoveplus Plugin configuration file
With the Proxmox web interface go to `typhoon-01` > `113 (deluge)` > `>_ Shell` and type the following:
```
pkill -9 deluged &&
sleep 5 &&
wget  https://raw.githubusercontent.com/ahuacate/deluge/master/autoremoveplus.conf -P /home/media/.config/deluge &&
chown 1005:1005 {/home/media/.config/deluge/autoremoveplus.conf} &&
sudo systemctl restart deluge
```
## 00.00 Patches & Fixes
All CLI commands performed in the `typhoon-01` > `113 (deluge)` > `>_ Shell` :

**Restart Deluge**
```
sudo systemctl restart deluge
```
