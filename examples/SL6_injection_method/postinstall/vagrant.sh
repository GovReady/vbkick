# Vagrant specific
date > /etc/vagrant_box_build_time

# create vagrant user and group
/usr/sbin/groupadd vagrant
/usr/sbin/useradd vagrant -g vagrant -G wheel -d /home/vagrant -c "Vagrant box user"
# set password
echo "vagrant" | passwd --stdin vagrant
#echo vagrant:vagrant | /usr/sbin/chpasswd
# give sudo access (grants all permissions to user vagrant)
echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
# add vagrant's public key - user can ssh without password
mkdir -pm 700 ~vagrant/.ssh
wget -O ~vagrant/.ssh/authorized_keys --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chmod 0600 ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/.ssh