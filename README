ILO-config 0.1

This is a simple module to configure HP ILO.
You will be able to configure:
- Hostname
- Static IP / DHCP

Future Plans:
- Config for AD-Authentication
- Adding support for a secondary DNS

========================================

 Parameters
 ----------
$ensure - If set to present, installs the package HPONCFG and configures ILO. If set to disable, removes all packages and files created by module.
Defaults to: present

$hostname - Hostname of the server
Default to: The server hostname is a static variable. Hostname is collected from facter.

$ilonamename - Hostname of the ilo-hostname-interface
Default to: ilo-hostname <- Where "hostname" is replaced by the hostname from facter

$scriptpath - Path to a folder where this module deploys some scripts for creating custom facts and some temporary files each time puppet runs.
Defaults to: /usr/local/sbin

$dhcp - State of DHCP-setting
Defaults to: Y <--Which is TRUE/Enabled

$staticip - Static IP-adress for the ilo-interface
Default to: 192.168.0.1

$netmask - Netmask IP-adress for the ilo-interface
Default to: 255.255.255.9

$gateway - Gateway IP-adress for the ilo-interface
Defaults to: 192.168.0.254

$pridns - Primary DNS for the ilo-interface
Defaults to: 8.8.8.8

