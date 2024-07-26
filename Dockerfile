FROM alpine:3.20
RUN apk --update add bash openvpn openresolv && rm -rf /var/cache/apk/* 
RUN wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
RUN chmod +x "/etc/openvpn/update-resolv-conf"

RUN wget -O shadowsocks.tar.xz "https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.20.2/shadowsocks-v1.20.2.x86_64-unknown-linux-gnu.tar.xz" \
    && tar -xvf shadowsocks.tar.xz \
    && chmod +x ssserver \
    && mv ssserver /usr/local/bin/ssserver \
    && rm -rf shadowsocks.tar.xz ssmanager sslocal ssurl

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]