# Nik0chaN - 02/03/2024 
#
# Kickstart configuration file (part of packer template generation)
# -----------------------------------------------------------------
#
# Instalation is performed using online rocky sources (9.3 version)
# This file must be located on a http server reachable by template boot time configured IP 
# In this file: 
# -IP: 
# -Gateway: 
# -DNS: 
# 
# ! IMPORTANT ! 
# -------------
# You have to set ssh public key (see key section below) and own private key configured on packer directory to deploy 
#

# Install repo
repo --name="Base" --baseurl="https://download.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os"
repo --name="AppStream" --baseurl="https://download.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/"

# Use text install
text

# Don't run the Setup Agent on first boot
firstboot --disabled
eula --agreed

# Keyboard layouts
keyboard --vckeymap=es --xlayouts='es'

# System language
lang en_US.UTF-8

# Network information
network --bootproto=static --device=ens192 --gateway= --ip= --nameserver= --netmask= --onboot=on --ipv6=auto --activate

# Root password
rootpw changeme

# System services
selinux --permissive
firewall --enabled
services --enabled="NetworkManager,sshd,chronyd"

# System timezone
timezone Europe/Madrid --utc

# System booloader configuration
bootloader --location=mbr --boot-drive=sda

# Partition clearing information
clearpart --all --initlabel --drives=sda

# Disk partitionning information
part /boot --fstype="xfs" --ondisk=sda --size=512
part pv.01 --fstype="lvmpv" --ondisk=sda --grow
volgroup vg_root --pesize=4096 pv.01
logvol /home --fstype="xfs" --size=5120 --name=lv_home --vgname=vg_root
logvol /var --fstype="xfs" --size=10240 --name=lv_var --vgname=vg_root
logvol / --fstype="xfs" --size=10240 --name=lv_root --vgname=vg_root
logvol swap --fstype="swap" --size=4092 --name=lv_swap --vgname=vg_root

skipx

reboot

%packages --ignoremissing --excludedocs
openssh-clients
curl
dnf-utils
drpm
net-tools
open-vm-tools
perl
perl-File-Temp
sudo
vim
wget
python3

# unnecessary firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl*-firmware
-libertas-usb8388-firmware
-ql*-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
-cockpit
-quota
-alsa-*
-fprintd-pam
-intltool
-microcode_ctl
%end

%addon com_redhat_kdump --disable
%end

%post

systemctl enable vmtoolsd
systemctl start vmtoolsd

# key section - Grant ssh access
mkdir -m0700 /root/.ssh/
cat <<EOF >/root/.ssh/authorized_keys
<your id_rsa.pub here >
EOF

### set permissions
chmod 0600 /root/.ssh/authorized_keys

### fix up selinux context
restorecon -R /root/.ssh/


%end