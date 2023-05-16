git clone https://github.com/EmmanuelAmodu/node-setup.git
mv node-setup/genesis.json raba.network/
geth --datadir ./raba.network/data init ./raba.network/genesis.json
rm -rf node-setup
