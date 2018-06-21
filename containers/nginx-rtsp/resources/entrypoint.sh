#!/bin/bash

# Set the Camera Name in the HTML Web UI
sed -i -e 's/CAMERANAME/'"$CAMERA_NAME"'/g' /var/www/html/index.html

# Split out the values from AUTHORISED_USERS environment variable into username and password strings
IFS='!' read -ra ADDR <<< "$AUTHORISED_USERS"
for i in "${ADDR[@]}"; do

# Split out Username and Password to Variables
CAMUSERNAME=$(echo "$i" | cut -d: -f1)
CAMPASSWORD=$(echo "$i" | cut -d: -f2)

Add Variable to .htpasswd
printf "$CAMUSERNAME:$(openssl passwd -crypt $CAMPASSWORD)\n" >> /usr/local/nginx/cameraauth.htpasswd

done

# Start nginx
/usr/local/nginx/sbin/nginx -g 'daemon off;'
