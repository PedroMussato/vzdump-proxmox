# vzdump-proxmox

 You can run this script passing the VM id encapsulated using double quotes separated by spaces, or not using no param, in this last case you will backup all the VMs in the hypervisor.

Create a directory in / named Backup-PVE
mkdir /Backup-PVE
In case this directory alrady exists please change this parameter in the vzdump.sh line 4 in the variable PVEBKPHOME.

 example:
 ./vzdump.sh "101 102"

 this command will dump the VMs id 101 and 102.

 example 2:
 ./vzdump.sh

 this command will dump all VMs in the hypervisor.
 