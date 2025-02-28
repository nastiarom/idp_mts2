#!/bin/bash

JUMP_NODE=$1
USER=$2
NAMENODE=$3

ssh "$USER@$JUMP_NODE" << EOF
cd /etc/nginx/sites-available/

sudo bash -c 'cat > nn << CONFIG
server {
    listen 9870;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;

    location / {
        auth_basic "Administrator's Area";
        auth_basic_user_file /etc/.htpasswd;
        proxy_pass http://$NAMENODE:9870;
    }
}
CONFIG'

sudo systemctl reload nginx
exit
EOF