#
#version=RHEL10
# Use text install
text

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
# Link device is the first device with an uplink
network --bootproto=dhcp --device=link

%packages
@^minimal-environment

%end

# Run the Setup Agent on first boot
firstboot --enable

# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
autopart

timesource --ntp-pool=2.almalinux.pool.ntp.org
# System timezone
timezone America/Los_Angeles --utc

#Root password
rootpw --lock
user --name=ansible --password=$y$j9T$CQJ4/qQB3pxF5EJtTNAvf/$xXkoECoivdug8QCHggrWWLfDd5Lvxj2R3NgIyNX/w07 --iscrypted --gecos="Ansible Service Account" --uid="1069" --gid="1069"

# Reboot the node
reboot

%post
mkdir -p /home/ansible/.ssh
chmod 0700 /home/ansible/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5jb8Vcw0M2BxH4+LxWWc6oBJxa2VsGxlmOjUUGFVpk mbc@arch" > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99-ansible
chown -R ansible:ansible /home/ansible/.ssh
%end
