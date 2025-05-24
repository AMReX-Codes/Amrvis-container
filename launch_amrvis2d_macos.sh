#!/bin/sh

## Wrapper script to launch amrvis2d inside a Docker container on macOS

PORT=1
MOUNT_DIR=${1:-`pwd`}
AMRVIS_EXE=/Amrvis2D/amrvis2d.gnu.ex

open -a XQuartz
xhost +localhost
docker run --platform linux/amd64 -v $MOUNT_DIR:/home/vscode/data -e DISPLAY=docker.for.mac.host.internal:$PORT ghcr.io/benwibking/amrvis-container:main $AMRVIS_EXE

# If you get an error message like this:
#     Error: Can't open display: docker.for.mac.host.internal:0
#
# This means either:
#     1. XQuartz isn't running,
#     2. it isn't configured to allow remote clients, OR
#     3. it's listening on the wrong display port.
#
# Run this command:
#    ps aux | grep Xquartz
# and examine the output for this line:
#    benwibking       27690   0.0  0.0 410602544   2880   ??  S     3:11PM   0:00.00 /opt/X11/bin/Xquartz :1 -listen tcp -iglx -auth /Users/benwibking/.serverauth.27477
#
# We see that Xquartz is (for some reason) listening on display port 1, rather than the expected port 0.
# You can workaround this by changing the PORT variable on line 5 so that it reads `PORT=1`.
