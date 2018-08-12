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
# Slightly complicated as softlink uses the user's home directory *and* current dir
sudo -u vagrant git clone https://github.com/willdollman/dot-config /home/vagrant/dot-config
sudo -u vagrant -i bash -c 'cd /home/vagrant/dot-config; ruby softlink'

# Set up Jupyter
# Password = 'password'; only accessible locally so not a security issue
sudo -u vagrant /home/vagrant/anaconda3/bin/jupyter-notebook --generate-config
echo -e "c.NotebookApp.ip = '*'\nc.NotebookApp.notebook_dir = '/home/vagrant/notebooks'\nc.NotebookApp.password = 'sha1:a9b00d8553f0:d617f9b25ee21051c202042e31b8b2587e4c8616'" >> /home/vagrant/.jupyter/jupyter_notebook_config.py

# Start Jupyter Notebook on boot with a systemd script
#(crontab -u vagrant -l 2>/dev/null; echo '@reboot cd /home/vagrant; source ~/.bashrc;  /home/vagrant/anaconda3/bin/jupyter notebook') | crontab -u vagrant -
cp /vagrant/jupyter.service /etc/systemd/system/jupyter.service
systemctl enable jupyter.service
systemctl daemon-reload
systemctl restart jupyter.service

# Install python modules
sudo -u vagrant -i /home/vagrant/anaconda3/bin/pip install --upgrade pip
# Install basic version of OpenAI Gym
sudo -u vagrant -i /home/vagrant/anaconda3/bin/pip install gym
# Install full OpenAI Gym + prereqs
#apt-get install -y python-dev cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig g++
#sudo -u vagrant -i /home/vagrant/anaconda3/bin/pip install gym[all]

echo -e "\n*********\n'vagrant reload' to enable GUI\n*********\n";
