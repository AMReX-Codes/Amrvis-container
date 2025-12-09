# Amrvis-container
[![Docker](https://github.com/AMReX-Codes/Amrvis-container/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/AMReX-Codes/Amrvis-container/actions/workflows/docker-publish.yml)

![Screenshot 2025-05-23 at 1 34 06 PM](https://github.com/user-attachments/assets/26c4c8df-4768-4cd7-ade5-15229741c501)

A short guide to Amrvis is available [here](https://amrex-codes.github.io/amrex/docs_html/Visualization.html#amrvis).

The complete LaTeX-formatted documentation is available as a [PDF](Amrvis.pdf).

## Browser-based X11 (recommended)
Run Amrvis inside a browser-backed X11 session:
```console
$ ./launch_amrvis_browser.sh [/path/to/data]
```
Your working directory (or the optional path you pass in) is bind-mounted into `/home/vscode/data`. The script prints a one-time password; open http://localhost:8080/ and paste it in.

An `xterm` window appears; launch either `amrvis2d` or `amrvis3d` from there:

<img width="1318" alt="Screenshot 2025-05-25 at 2 00 36 PM" src="https://github.com/user-attachments/assets/00fe557b-8c4d-4412-a6cd-2c9f9d6f4f26" />

Additional X11 tools included in the container: `xfile` (file browser), `ximaging` (image viewer), `xpdf`, `xev`, `nedit`, and `xterm`.

## Legacy native X11 launchers
If you prefer direct X11 instead of the browser workflow, use the launchers in `legacy_launchers/` (they require a working X11 server on the host).

### macOS with XQuartz
1. Install XQuartz and allow remote clients:
```console
$ brew install --cask xquartz
$ open -a XQuartz
```
2. In XQuartz, enable `Settings... -> Security -> Allow connections from network clients`, then reboot.
3. Launch Amrvis using the legacy script (2D or 3D):
```console
$ legacy_launchers/launch_amrvis3d_macos.sh
```

You should see a window like this:
<img width="1018" alt="Screenshot 2025-05-23 at 1 08 12 PM" src="https://github.com/user-attachments/assets/a0e6a573-b235-45da-a2ad-4fee69007b21" />

Your current working directory on the host is bind-mounted into `/home/vscode/data`.

Amrvis needs a three-button mouse for some features (see [PDF](Amrvis.pdf)). XQuartz can emulate this via `Settings... -> Input -> Emulate three button mouse`; press option + left click for the middle button.

<img width="596" alt="Screenshot 2025-05-24 at 4 13 45 PM" src="https://github.com/user-attachments/assets/ab1df30f-617b-4286-bcca-4903afe3bd48" />

### Linux / HPC (Singularity)
The legacy Singularity launchers still work on Linux and remote clusters (e.g., Frontier):
```console
$ legacy_launchers/launch_amrvis3d_linux.sh
```
Use the `launch_amrvis2d_linux.sh` variant for 2D.

### Windows
Use the browser workflow with Docker Desktop, or run the Linux legacy launcher from inside a [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) instance with Singularity installed.

![Screenshot 2025-05-23 185511](https://github.com/user-attachments/assets/cf4cbf66-f153-4e45-8543-aa4afbd07514)
