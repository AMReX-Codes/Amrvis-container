FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install build-essential m4 \
		      libmotif-dev libxext-dev libxpm-dev \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

## build Volpack
RUN git clone https://ccse.lbl.gov/pub/Downloads/volpack.git && cd volpack && make -j`nproc`

## download AMReX
RUN git clone https://github.com/AMReX-Codes/amrex.git

## build Amrvis (2D)
RUN git clone https://github.com/AMReX-Codes/Amrvis.git Amrvis2D
COPY GNUmakefile.2d Amrvis2D/GNUmakefile
RUN cd Amrvis2D && make -j`nproc`

## build Amrvis (3D)
RUN git clone https://github.com/AMReX-Codes/Amrvis.git Amrvis3D
COPY GNUmakefile.3d Amrvis3D/GNUmakefile
RUN cd Amrvis3D && make -j`nproc`

## copy settings
COPY .bashrc /home/vscode/.bashrc
COPY amrvis.defaults /home/vscode/.amrvis.defaults
COPY Palette /home/vscode/Palette

WORKDIR /home/vscode
USER vscode
CMD [ "/Amrvis3D/amrvis3d.gnu.ex" ]
