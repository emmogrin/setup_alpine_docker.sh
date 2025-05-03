#!/bin/bash

# Install necessary dependencies
apk update
apk add qemu-system-x86_64 qemu-img curl wget docker docker-compose

# Create the virtual disk image for Alpine
qemu-img create -f qcow2 alpine.img 8G

# Download the Alpine ISO
wget -q -O alpine.iso https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-standard-3.19.7-x86_64.iso

# Start the QEMU VM and install Alpine
qemu-system-x86_64 -m 2048 -cdrom alpine.iso -hda alpine.img -boot d -net nic -net user -nographic

# Install Docker
apk update
apk add docker
rc-update add docker boot
service docker start

# Docker test to verify the installation
docker run hello-world

echo "Docker has been successfully installed in your Alpine VM!"
