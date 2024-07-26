#!/bin/bash
nohup openvpn --config /data/conf/openvpn/openvpn.ovpn --auth-user-pass /data/conf/openvpn/pass.txt >> /data/log/ovpn.log &
sleep 8
ssserver -c /data/conf/shadowsocks/config.json