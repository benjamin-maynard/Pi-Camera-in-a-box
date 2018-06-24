# Set Base Image
FROM resin/rpi-raspbian

# Maintainer
MAINTAINER Benjamin Maynard <benjamin@maynard.io>

# Install Essential Packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev build-essential make gcc libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libcurl4-openssl-dev git && cd /root && git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git && curl -o nginx.tar.gz http://nginx.org/download/nginx-1.14.0.tar.gz && mkdir nginx && tar xf nginx.tar.gz -C nginx --strip-components 1 && cd /root/nginx && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && make -j 1 && make install && rm -rf /root/nginx && rm -rf /root/nginx-rtmp-module && rm /root/nginx.tar.gz && apt-get remove --purge -y git build-essential make gcc libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libcurl4-openssl-dev && apt-get autoremove --purge -y && rm -rf /var/lib/apt/lists/*

# Copy NGINX Configuration
COPY resources/nginx.conf /usr/local/nginx/conf/nginx.conf

# Setup Web UI
RUN mkdir -p /var/www/html
COPY resources/web-ui /var/www/html

# Set EntryPoint Script
COPY resources/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
