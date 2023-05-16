git clone https://github.com/EmmanuelAmodu/node-setup.git
mv node-setup/genesis.json raba.network/
mv node-setup/bootnodes.txt raba.network/
geth --datadir ./raba.network/data init ./raba.network/genesis.json
cd /etc/systemd/system
export NODE_IP=$(hostname -I | awk '{print $1}')
export ACCOUNT_ADDRESS=$(geth --datadir /root/raba.network/data account list 2>/dev/null |  awk -F '[{}]' '{print $2}')
export BOOTNODES=$(cat /root/raba.network/bootnodes.txt)
echo -e "[Unit]\nDescription=Go Ethereum client\n\n[Service]\nUser=root\nType=simple\nRestart=always\nExecStart=/usr/bin/geth --networkid 7484 --datadir /root/raba.network/data --port 30303 --ipcdisable --syncmode full --allow-insecure-unlock --http=true --http.corsdomain '*' --http.port 8545 --http.rpcprefix '/' --http.addr '$NODE_IP' --unlock 0x$ACCOUNT_ADDRESS --password /root/raba.network/password.txt --mine --http.api personal,admin,clique,eth,net,web3,miner,txpool,debug --ws=true --ws.addr 0.0.0.0 --ws.port 8546 --ws.origins '*' --ws.api personal,admin,eth,net,web3,miner,txpool,debug --maxpeers 25 --miner.etherbase 0x$ACCOUNT_ADDRESS --miner.gasprice 0x3B9ACA00 --miner.gaslimit 9999999 --bootnodes $BOOTNODES\n\n[Install]\nWantedBy=default.target\n" > geth.service
chmod +x geth.service
systemctl daemon-reload
systemctl enable geth.service
systemctl start geth.service
systemctl status geth.service
cd ~
rm -rf node-setup
