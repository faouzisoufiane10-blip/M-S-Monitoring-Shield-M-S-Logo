# name=openwrt/apply_safeguards.sh
#!/bin/sh
# Example safe commands for OpenWrt via UCI (run via SSH as root)
# WARNING: adapt to your device and test in lab before production.

uci set wireless.@wifi-iface[0].encryption='sae-mixed'  # prefer WPA3 if supported (sae-mixed for compat)
uci set wireless.@wifi-iface[0].pairwise='ccmp'
uci set wireless.@wifi-iface[0].wpa_disable_eapol_key_retries='0'
# Enable Protected Management Frames (PMF) if supported
# hostapd option: ieee80211w=2 (2 = required, 1 = optional)
uci set wireless.@wifi-iface[0].ieee80211w='2'

# Disable WPS
uci set wireless.@wifi-iface[0].wps='0'

# Commit changes
uci commit wireless
wifi reload

# Example: add a MAC to firewall deny (assumes use of macfilter or firewall rules)
# (This is only example; modify firewall rules per your setup)
# ipset add blocked_macs aa:bb:cc:dd:ee:ff

echo "Safeguards applied. Verify device supports settings and reboot if necessary."
