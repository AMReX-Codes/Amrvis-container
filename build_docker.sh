#!/bin/bash
set -x
docker build --platform linux/amd64 --tag ghcr.io/benwibking/amrvis-container:latest .
