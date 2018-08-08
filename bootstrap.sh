# Update everything
apt-get update
apt-get upgrade -y

# Install the desktop GUI without unnecessary packages
#apt-get install -y ubuntu-desktop
apt-get install -y --no-install-recommends ubuntu-desktop
# Install guest additions
apt-get install -y virtualbox-guest-dkms ruby

# Install Anaconda3
sudo -u vagrant mkdir /home/vagrant/vagrant-setup/
wget "https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh" -q -O /home/vagrant/vagrant-setup/Anaconda3.sh
sudo -u vagrant bash /home/vagrant/vagrant-setup/Anaconda3.sh -b -p /home/vagrant/anaconda3

# Install my config files
sudo -u vagrant git clone https://github.com/willdollman/dot-config /home/vagrant/dot-config
cd /home/vagrant/dot-config
sudo -u vagrant ruby softlink

echo -e "\n*********\nReboot to enable GUI\n*********\n";
