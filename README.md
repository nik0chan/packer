# templates

## Rocky Linux 9 packer vmware generation templates

Requirements: 
- Packer installed on system (Linux/Windows)
> sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
> sudo dnf install packer.x86_64

- Vsphere plugin installed 
> /usr/bin/packer plugins install github.com/hashicorp/vsphere

- HTTP Server to get rockylinux9.ks 

- Private/Public keys configured 
  + private: on ssh/id_rsa
  + public: on key section of rockylinux9.ks
  
Files included:
- rockylinux9.json         : packer template
- rockylinux9.ks           : kickstart config file 
- ssh/id_rsa               : private key 
- scripts/requirements.sh  : 
- scripts/setup.sh         : 
 
