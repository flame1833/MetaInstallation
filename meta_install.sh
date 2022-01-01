#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

go_lg = go1.17.5.linux-amd64.tar.gz

sudo apt-get update && sudo apt-get install wget git curl net-tools build-essential make -y
wget https://go.dev/dl/$go_lg
rm -rf /usr/local/go && tar -C /usr/local -xzf $go_lg
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PANDO_HOME=/usr/local/go/src/github.com/pandotoken/pando' >> ~/.bashrc
echo 'export PANDO_HOME=/usr/local/go/src/github.com/pandotoken/pando' >> ~/.profile
source ~/.bashrc && source ~/.profile

mkdir -p /usr/local/go/src/github.com/pandotoken/ && cd /usr/local/go/src/github.com/pandotoken/
git clone https://github.com/logan-pandolab/Pando-Mainnet-Blockchain.git pando

cd $PANDO_HOME
export GO111MODULE=on
make install

cd $PANDO_HOME
cp -r ./integration/pandonet ../pandonet
mkdir ~/.pandocli
chmod 700 ~/.pandocli
export PATH=$PATH:/usr/local/go/bin && make install

/usr/local/go/bin/pando start --config=../pandonet/node
