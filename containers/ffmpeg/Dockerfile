# Set Base Image
FROM resin/rpi-raspbian

# Maintainer
MAINTAINER Benjamin Maynard <benjamin@maynard.io>

# Install Essential Packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev build-essential make gcc libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libcurl4-openssl-dev git libpcre3-dev libavfilter-dev libavformat-dev libavcodec-dev libomxil-bellagio-dev libraspberrypi-bin && cd /root && git clone https://github.com/FFmpeg/FFmpeg.git && cd /root/FFmpeg && ./configure --enable-cross-compile --cross-prefix=${CCPREFIX} --arch=armel --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree && make -j4 && make install && cd / && rm -rf /root/FFmpeg && apt-get remove --purge -y build-essential libssl-dev build-essential make gcc libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libcurl4-openssl-dev git && apt-get autoremove --purge -y && rm -rf /var/lib/apt/lists/*

# Set EntryPoint Script
COPY resources/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
