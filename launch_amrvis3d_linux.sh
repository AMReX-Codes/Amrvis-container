#!/bin/sh

## Wrapper script to launch amrvis3d inside a Docker container on Linux
MOUNT_DIR=${1:-`pwd`}
AMRVIS_EXE=/Amrvis3D/amrvis3d.gnu.ex
DOCKER_CMD=singularity
CONTAINER=ghcr.io/amrex-codes/amrvis-container:main

$DOCKER_CMD run --env DISPLAY=$DISPLAY docker://$CONTAINER $AMRVIS_EXE
