#!/bin/bash
# Check root user
if [ $EUID -ne 0 ]
then
   echo "This script must be run as root" 
   exit 1
fi

#Install Linux dependencies
apt-get install -y --no-install-recommends build-essential
apt-get install -y --no-install-recommends pkg-config 
apt-get install -y --no-install-recommends libboost-python-dev 
apt-get install -y --no-install-recommends libboost-thread-dev 
apt-get install -y --no-install-recommends bluetooth
apt-get install -y --no-install-recommends bluez bluez-tools python-bluez
apt-get install -y --no-install-recommends libbluetooth-dev
apt-get install -y --no-install-recommends libglib2.0-dev 
apt-get install -y --no-install-recommends python-dev
apt-get install -y --no-install-recommends tcpdump
apt-get install -y --no-install-recommends network-manager
apt-get install -y --no-install-recommends nmap
apt-get install -y --no-install-recommends python3-dev 
apt-get install -y --no-install-recommends python3-dbus 
apt-get install -y --no-install-recommends libgirepository1.0-dev
apt-get install -y --no-install-recommends libdbus-glib-1-dev
apt-get install -y --no-install-recommends libncurses5-dev libncursesw5-dev
apt-get install -y --no-install-recommends python3-pip
apt-get install -y --no-install-recommends gcc libcairo2-dev gir1.2-gtk-3.0
apt-get install -y --no-install-recommends libffi-dev libssl-dev
apt-get install -y --no-install-recommends libcups2-dev
apt-get install -y --no-install-recommends libzbar0

# Install nOBEX
wget https://github.com/nccgroup/nOBEX/archive/master.zip && unzip master.zip && rm master.zip 
cd ./nOBEX-master
python3 setup.py install

cd ..
rm -r nOBEX-master

read  -p "Do you want to create a virtual environment? (y/n): " follow

if [ "$follow" == "y" ]
then
    pip3 install virtualenv
    virtualenv homePwn
    source homePwn/bin/activate
fi
echo "Installing python libraries..."
# Install Python dependencies
pip3 install --no-cache-dir -r ./requirements.txt  -q &> /dev/null
pip3 install --no-cache-dir -r ./modules/_requirements.txt -q &> /dev/null

echo "Done!"

if [ "$follow" == "y" ]
then
    echo "To activate virtualenv use: source homePwn/bin/activate"
    echo "To exit: deactivate"
fi