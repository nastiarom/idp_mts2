#!/bin/bash

JUMP_NODE=$1
USER=$2
NAMENODE=$3

ssh "$USER@$JUMP_NODE" << EOF
cd /etc/nginx/sites-available/

sudo bash -c 'cat > ya << CONFIG
server {
    listen 8088;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        auth_basic "Administrator's Area";
        auth_basic_user_file /etc/.htpasswd;
        proxy_pass http://$NAMENODE:8088;
    }
}
CONFIG'

sudo bash -c 'cat > dh << CONFIG
server {
    listen 19888;
    root /var/www/html;
    index index.html index.nginx-debian.html;

    server_name _;

    location / {
        auth_basic "Administrator's Area";
        auth_basic_user_file /etc/.htpasswd;
        proxy_pass http://$NAMENODE:19888;
    }
}
CONFIG'

sudo ln -s /etc/nginx/sites-available/ya /etc/nginx/sites-enabled/ya
sudo ln -s /etc/nginx/sites-available/dh /etc/nginx/sites-enabled/dh
sudo systemctl reload nginx
exit
EOF