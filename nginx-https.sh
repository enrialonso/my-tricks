#!/bin/bash
apt update -y
apt install nginx -y
snap install core; snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
certbot --nginx --non-interactive --agree-tos -m enrialonso@gmail.com