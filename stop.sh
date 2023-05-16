systemctl stop geth.service
rm /etc/systemd/system/geth.service
systemctl daemon-reload
rm -rf node-setup
rm raba.network/bootnodes.txt
