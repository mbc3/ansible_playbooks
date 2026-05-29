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

timesource --ntp-server=opnsense.localdomain
timezone America/Los_Angeles --utc

#Root password
rootpw --lock
# Create ansible user
user --name=ansible --password=$y$j9T$CQJ4/qQB3pxF5EJtTNAvf/$xXkoECoivdug8QCHggrWWLfDd5Lvxj2R3NgIyNX/w07 --iscrypted --gecos="Ansible Service Account" --uid=1069 --gid=1069

# Reboot the node
reboot

%post
# package install
dnf install -y ansible-core  ansible-collection-ansible-posix ansible-collection-community-general

# add ansible to sudoers
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99-ansible

# run ansible provision playbook
sudo -u ansible ansible-pull --url https://repo.forgejo.localdomain/mbc/Provision provision.yml

%end
