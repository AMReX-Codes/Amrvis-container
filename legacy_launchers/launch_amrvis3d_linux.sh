#!/bin/sh

## Wrapper script to launch amrvis2d inside a Docker container on Linux
MOUNT_DIR=${1:-`pwd`}
AMRVIS_EXE=/Amrvis3D/amrvis3d.gnu.ex
DOCKER_CMD=singularity

$DOCKER_CMD run --env DISPLAY=$DISPLAY docker://ghcr.io/benwibking/amrvis-container:main $AMRVIS_EXE
