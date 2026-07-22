#!/bin/bash

echo "Updating packages..."

sudo apt update -y

echo "Installing Nginx..."

sudo apt install nginx -y

sudo systemctl enable nginx
sudo systemctl start nginx

echo "Copying HTML Page..."

sudo cp /tmp/index.html /var/www/html/index.html

echo "Setting Permissions..."

sudo chmod 644 /var/www/html/index.html

echo "Restarting Nginx..."

sudo systemctl restart nginx

echo "Deployment Completed Successfully..."