FROM alpine:3.20
RUN apk --update add bash openvpn openresolv shadowsocks-rust && rm -rf /var/cache/apk/* 
RUN wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
RUN chmod +x "/etc/openvpn/update-resolv-conf"

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]