FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install build-essential m4 \
		      libmotif-dev libxext-dev libxpm-dev \
		      python3-setuptools \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

## add xpra repositories
RUN git clone https://github.com/Xpra-org/xpra && cd xpra \
    && ./setup.py install-repo

# install xpra
RUN apt-get --yes -qq update && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install xpra xpra-html5 \
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

## configure X11 server
COPY ./xpra.conf /etc/xpra/xpra.conf
COPY ./start_http_server.sh /home/vscode/start_http_server.sh
EXPOSE 8080

WORKDIR /home/vscode
USER vscode
CMD [ "./start_http_server.sh" ]
