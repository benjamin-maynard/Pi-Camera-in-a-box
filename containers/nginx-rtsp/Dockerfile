# Set Base Image
FROM resin/rpi-raspbian

# Maintainer
MAINTAINER Benjamin Maynard <benjamin@maynard.io>

# Install Essential Packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev build-essential make gcc libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libcurl4-openssl-dev git

# Clone Nginx, RTMP Module, and Build
WORKDIR /root
RUN git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
RUN curl -o nginx.tar.gz http://nginx.org/download/nginx-1.14.0.tar.gz
RUN mkdir nginx
RUN tar xf nginx.tar.gz -C nginx --strip-components 1
WORKDIR /root/nginx
RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && make -j 1 && make install

# Remove Source Code
RUN rm -rf /root/nginx
RUN rm -rf /root/nginx-rtmp-module

# Copy NGINX Configuration
COPY resources/nginx.conf /usr/local/nginx/conf/nginx.conf

# Setup Web UI
RUN mkdir -p /var/www/html
COPY resources/web-ui /var/www/html

# Set EntryPoint Script
COPY resources/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
