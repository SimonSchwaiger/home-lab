# Server Configuration Files

## Installation

0. Install host OS and setup username + password (also used for ssh; tested using Ubuntu 22.04 LTS). Enable login without password and disable automatic suspend and screen blank in power settings.
1. Clone full repository to *~/git*
2. Run the [enableSSH.sh](./enableSSH.sh) script
3. Copy the server's IP address (from the `ifconfig` command) and save it to the raspberry's secrets file, alongside ssh username and password

## Raid 1 Setup

*This Setup is based on [this guide](https://wiki.ubuntuusers.de/Software-RAID/) and has been performed using two HDD's*

0. Add HDD's to PC
1. Install *mdadm* for raid creation and *parted* for drive formatting `sudo apt install mdadm parted`
2. Format HDDs for use with raid (here sde is used as an example)
    - `sudo parted /dev/sde mklabel gpt`
    - `sudo parted -a optimal -- /dev/sde mkpart primary 0% 100%`
    - `sudo parted /dev/sdb set 1 raid on`
3. Create raid `sudo mdadm --create /dev/md0 --auto md --level=1 --raid-devices=2 /dev/sde1 /dev/sdf1`
4. Create file system `sudo mkfs.ext4 /dev/md0`
5. Automatically mount raid1 filesystem by adding `/dev/md0     /media/data      ext4      defaults 0 2` to */etc/fstab* . Alternatively, you can refer to the array using its UUID as shown [here](https://askubuntu.com/questions/540202/mount-an-mdadm-raid-1-drive-at-boot).
6. Reload fstab to check your configuration using `sudo mount -a`

