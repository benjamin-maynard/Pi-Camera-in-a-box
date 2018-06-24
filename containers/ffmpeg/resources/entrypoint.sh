#!/bin/bash

# Sleep for 20 seconds just to make sure nginx is running
sleep 20

# Determine if we need to Horizontally or Vertically flip the stream

if [ $FLIP_HORIZONTALLY = "yes" ]; then
   HF="-hf"
fi

if [ $FLIP_VERTICALLY = "yes" ]; then
   VF="-vf"
fi


# Start Stream to nginx
raspivid -o - -t 0 -fps $FRAMES_PER_SECOND -b $STREAM_BITRATE -w $STREAM_WIDTH -h $STREAM_HEIGHT $HF $VF | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i - -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -framerate $FRAMES_PER_SECOND -f flv rtmp://nginx-rtsp/show/stream
