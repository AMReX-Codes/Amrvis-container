#!/bin/sh

## Wrapper script to launch amrvis2d inside a Docker container on Linux
MOUNT_DIR=${1:-`pwd`}
AMRVIS_EXE=/Amrvis2D/amrvis2d.gnu.ex
DOCKER_CMD=singularity
CONTAINER=ghcr.io/amrex-codes/amrvis-container:main

$DOCKER_CMD run --env DISPLAY=$DISPLAY docker://$CONTAINER $AMRVIS_EXE
