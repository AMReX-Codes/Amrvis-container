# Amrvis-container

![Screenshot 2025-05-23 at 1 34 06 PM](https://github.com/user-attachments/assets/26c4c8df-4768-4cd7-ade5-15229741c501)

A short guide to Amrvis is available [here](https://amrex-codes.github.io/amrex/docs_html/Visualization.html#amrvis).

The complete LaTeX-formatted documentation is available as a [PDF](Amrvis.pdf).

## Running on macOS

### Install XQuartz and allow remote clients
There is a detailed guide available [here](https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088#step-by-step-guide) on how to do this.

[TL;DR](https://en.wikipedia.org/wiki/TL;DR) version:
1. Install XQuartz
```console
$ brew install --cask xquartz
$ open -a XQuartz
```
2. Go to `XQuartz -> Settings... -> Security` and check the box for "Allow connections from network clients".
3. Reboot your computer (this step is required).

### Run the container
Run Amrvis from the command line like this:
```console
$ ./launch_amrvis3d_macos.sh
localhost being added to access control list
Initializing AMReX (25.05-27-g78268f16d626)...
AMReX (25.05-27-g78268f16d626) initialized
Cannot find amrvis defaults file:  ./amrvis.defaults
Cannot find amrvis defaults file:  /home/vscode/amrvis.defaults
Reading defaults from:  /home/vscode/.amrvis.defaults
```

You should see a window that looks like this:
<img width="1018" alt="Screenshot 2025-05-23 at 1 08 12 PM" src="https://github.com/user-attachments/assets/a0e6a573-b235-45da-a2ad-4fee69007b21" />

Your current working directory on the host is bind-mounted into `/home/vscode/data`.

## Running on Linux

This also runs on Linux using Singularity:
```
wibking@login11:~/Amrvis-container> ./launch_amrvis3d_linux.sh
INFO:    Using cached SIF image
Initializing AMReX (25.05-27-g78268f16d626)...
AMReX (25.05-27-g78268f16d626) initialized
Reading defaults from:  ./amrvis.defaults
```
It also works over X11 from a remote HPC cluster, e.g. Frontier.

## Running on Windows

This also runs on Windows inside a [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) instance.
* First, create a WSL2 instance and [install Singularity](https://docs.sylabs.io/guides/latest/admin-guide/installation.html#install-from-provided-rpm-deb-packages) inside it.
* Then, inside the WSL2 instance, run the Linux launcher script.

![Screenshot 2025-05-23 185511](https://github.com/user-attachments/assets/cf4cbf66-f153-4e45-8543-aa4afbd07514)
