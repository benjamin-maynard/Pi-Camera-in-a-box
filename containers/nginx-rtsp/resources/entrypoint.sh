#!/bin/bash

# Set the Camera Name in the HTML Web UI
sed -i -e 's/CAMERANAME/'"$CAMERA_NAME"'/g' /var/www/html/index.html

# Generate a .htpasswd to secure the camera
printf "$CAMERA_USERNAME:$(openssl passwd -crypt $CAMERA_PASSWORD)\n" >> /usr/local/nginx/cameraauth.htpasswd

# Start nginx
/usr/local/nginx/sbin/nginx -g 'daemon off;'
