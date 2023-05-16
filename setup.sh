add-apt-repository -y ppa:ethereum/ethereum
apt-get update -y
apt-get install ethereum -y
apt-get upgrade geth -y
mkdir raba.network
touch ./raba.network/password.txt
geth --datadir ./raba.network/data account new
