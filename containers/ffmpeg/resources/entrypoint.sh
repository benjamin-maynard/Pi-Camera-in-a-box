#!/bin/bash

# Sleep for 20 seconds just to make sure nginx is running
sleep 20

# Start Stream to nginx
raspivid -o - -t 0 -fps 25 -b 6000000 | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i - -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -framerate 25 -f flv rtmp://nginx-rtsp/show/stream
