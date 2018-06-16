## Pi-Camera-in-a-box
Pi-Camera-in-a-box will take a vanialla Raspberry Pi with a Camera Module, and provide you with a HD 1920x1080 25FPS stream directly to your web browser (even on a Raspberry Pi Zero).

It uses HLS to deliver the steam , and features a custom Web UI, protected with HTTP Authentication to prevent unauthorised access.

This project is based on Docker, see below for full instructions on how to install. A screenshot is also provided.

Note: This project relies on FFMpeg and Nginx being compiled from source. This can take a LONG time on the Raspberry Pi due to the limited resources. Consequently, I have compiled images which are stored on the Docker Hub. If you do not wish to use these pre-baked Docker Images, replace **docker-compose pull** below with **docker-compose build**.

### Pre-Requisites

1. Vanilla Raspberry Pi running Raspian Stretch Light. Needs to be connected to the network, with SSH access enabled (see https://www.raspberrypi.org/forums/viewtopic.php?t=191252).
2. Raspberry Pi Camera Module connected and enabled through raspi-config.

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
    
    ## Edit config file with desired configuration settings.
    nano config
    
    ## Pull Pre-Compiled Images - This will also take a long time.
    docker-compose pull
    
    ## Start Containers
    docker-compose up -d

Wait around 60 seconds, and then visit http://YOUR-CAMERA-IP/ui. You will be prompted for the username and password that you earlier defined. You should now be able to see the live feed from your camera.

### Work in Progress
This project is still a work in progress, the following changes are planned:
- [ ] Optimise FFMpeg Stream
- [ ] Reduce Image Sizes

### Screenshot
![Pi-Camera-in-a-box](Screenshot.png?raw=true "Pi-Camera-in-a-box")
