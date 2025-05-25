#!/bin/sh

## Wrapper script to launch amrvis3d and connect with a browser-based X11 server
MOUNT_DIR=${1:-`pwd`}

docker run -p 8080:8080 --platform linux/amd64 -v $MOUNT_DIR:/home/vscode/data ghcr.io/benwibking/amrvis-container:latest
