#!/bin/bash
set -x
docker build --platform linux/amd64 --tag ghcr.io/amrex-codes/amrvis-container:latest .
