#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl start docker
docker run -d -p 3000:3000 adongy/hostname-docker
