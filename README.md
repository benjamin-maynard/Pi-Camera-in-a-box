## Pi-Camera-in-a-box
Pi-Camera-in-a-box will take a vanilla Raspberry Pi with a Camera Module, and stream the footage directly to your web browser. The stream resolution, FPS and Bitrate are fully configurable. Pi-Camera-in-a-box is capable of streaming 1080P, 25FPS video from a Raspberry Pi Zero.

Pi-Camera-in-a-box uses raspivid to capture the video, FFmpeg to encode, and nginx compiled with the [nginx-rtmp](https://github.com/arut/nginx-rtmp-module) module to deliver a HLS steam. This is displayed on a custom Web UI that uses [video.js](https://github.com/videojs/videojs-contrib-hls) to display in the browser.

Pi-Camera-in-a-box is fully Dockerized, removing the complexity of configuring all of these components manually. 

**Note:** Pi-Camera-in-a-box compiles FFMpeg, and Nginx with the RTMP module from source. This can take a long time on a Pi (8+ hours). Consequently I have built these images and pushed them to Docker Hub, this will save you significant time. If you would rather build the containers yourself, replace the `docker-compose pull` below with `docker-compose build`.

### Pre-Requisites
1. Vanilla Raspberry Pi running Raspian Stretch Light. Needs to be connected to the network, with SSH access enabled. To configure a headless Pi with SSH access enabled and Wi-Fi configured, see [this post](https://www.raspberrypi.org/forums/viewtopic.php?t=191252)
2. Raspberry Pi Camera Module connected and enabled through raspi-config

### Recommendations
1. Make sure you have performed basic security hardening on your Pi (default password, SSH keys, etc)
2. This project does not currently implement HTTPS. If you are accessing externally, perform either over VPN or a Reverse Proxy with SSL enabled

### Installation Instructions - Quickest Way
    ## Upgrade System
    apt-get update && apt-get upgrade -y
    
    ## Install Git, Python, Python-PIP
    apt-get install git python-pip -y
    
    ## Install Docker
    curl -sSL https://get.docker.com | sh
    
    ## Install docker-compose
    pip install docker-compose
    
    ## Clone this Repository
    git clone https://github.com/benjamin-maynard/Pi-Camera-in-a-box.git
    
    ## Change into Repository
    cd Pi-Camera-in-a-box
    
    ## Edit config file with desired configuration settings (see below for explanation).
    nano config
    
    ## Pull Pre-Compiled Images - This will also take a long time.
    docker-compose pull
    
    ## Start Containers
    docker-compose up -d

Wait around 60 seconds, and then visit http://YOUR-CAMERA-IP/ui. You will be prompted for the credentials that you earlier defined. You should now be able to see the live feed from your camera.

## Configuration Settings
| Setting               | Purpose       |
| --------------------- |---------------|
| CAMERA_NAME           | This setting configures the camera name. It will be displayed in the Web UI to help you identify the camera. |
| AUTHORISED_USERS      | The Web UI is protected with HTTP Authentication. This value configures the usernames and passwords allowed to access the stream. <br><br> The format is `<USERNAME>:<PASSWORD>`, for example `benjaminmaynard:securepassword`. Multiple users can be configured by separating the username and password combinations with an exclamation mark. For example, `benjaminmaynard:securepassword!bensfriend:securepassword`    |
| FRAMES_PER_SECOND     | This configures how many Frames Per Second the stream should be. Pi-Camera-in-a-box has been tested up to 25FPS with a 1920x1080 resolution on a Pi Zero. You can probably go higher.      |
| STREAM_WIDTH          | The stream width in pixels, default 1920 (1080p). Depending on where your camera is placed experiment with higher and lower resolutions. I've found lower resolutions are better for a bigger field of view in the house.     |
| STREAM_HEIGHT         | The stream hight in pixels, default 1080 (1080p). Depending on where your camera is placed experiment with higher and lower resolutions. I've found lower resolutions are better for a bigger field of view in the house     |
| STREAM_BITRATE        | The stream bitrate in bytes|
| FLIP_HORIZONTALLY     | **(yes/no)** Should the video be flipped horizontally (mirror view). This is useful depending on the orientation of your camera              |
| FLIP_VERTICALLY       | **(yes/no)**
Should the video be flipped vertically? This is useful if your camera is mounted upside down               |



### Screenshot
![Pi-Camera-in-a-box](Screenshot.png?raw=true "Pi-Camera-in-a-box")

### Thanks...
- [Peer 5 Article](https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/): For the head start on the nginx HLS config
