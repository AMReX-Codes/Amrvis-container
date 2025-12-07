FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install build-essential gfortran m4 bison flex pkg-config \
		      libmotif-dev libxext-dev libxpm-dev libxinerama-dev libjpeg-dev \
		      xvfb libx11-dev libxtst-dev libxcomposite-dev libxdamage-dev libxres-dev \
		      libxkbfile-dev pandoc libsystemd-dev liblz4-dev xauth x11-xkb-utils \
		      libxxhash-dev xterm \
		      uglifyjs brotli libjs-jquery libjs-jquery-ui gnome-backgrounds \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

## build Volpack
RUN git clone https://ccse.lbl.gov/pub/Downloads/volpack.git && cd volpack && make -j`nproc`

## download AMReX
RUN git clone https://github.com/AMReX-Codes/amrex.git

## build AmrProfParser
RUN git clone https://github.com/BenWibking/Amrvis.git AmrProfParser && cd AmrProfParser && git checkout logspace-colorbar
COPY GNUmakefile AmrProfParser/GNUmakefile
RUN cd AmrProfParser && make DIM=2 USE_PROFPARSER=TRUE -j`nproc`

## build Amrvis (2D)
RUN git clone https://github.com/BenWibking/Amrvis.git Amrvis2D && cd Amrvis2D && git checkout logspace-colorbar
COPY GNUmakefile Amrvis2D/GNUmakefile
RUN cd Amrvis2D && make DIM=2 -j`nproc`

## build Amrvis (3D)
RUN git clone https://github.com/BenWibking/Amrvis.git Amrvis3D && cd Amrvis3D && git checkout logspace-colorbar
COPY GNUmakefile Amrvis3D/GNUmakefile
RUN cd Amrvis3D && make DIM=3 -j`nproc`

## build X11 file viewer
RUN wget https://fastestcode.org/dl/xfile-src-1.0-beta.tar.xz && tar xvf xfile-src-1.0-beta.tar.xz
RUN cd xfile-1.0-rc2 && make Linux && make install

## build X11 image viewer
RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install libjpeg-dev libtiff-dev x11-apps xpdf nedit \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*
RUN wget https://fastestcode.org/dl/ximaging-src-1.8.tar.xz && tar xvf ximaging-src-1.8.tar.xz
RUN cd ximaging-src-1.8 && make Linux && make install

## install xpra from official repository
RUN apt-get --yes -qq update \
 && apt-get --yes -qq install apt-transport-https ca-certificates wget \
 && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
 && wget -O "/etc/apt/sources.list.d/xpra.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/noble/xpra.sources \
 && apt-get --yes -qq update \
 && apt-get --yes -qq install xpra \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

## install xpra HTML5 client from source with pinned version
RUN git clone https://github.com/BenWibking/xpra-html5 && cd xpra-html5 && git checkout middle-mouse-emu && ./setup.py install

## copy settings
COPY .bashrc /home/vscode/.bashrc
COPY amrvis.defaults /home/vscode/.amrvis.defaults
COPY Palette /home/vscode/Palette

## configure X11 server
COPY ./xpra.conf /etc/xpra/xpra.conf
COPY ./util/start_http_server.sh /home/vscode/start_http_server.sh
RUN mkdir -p /run/user/1000 && chown vscode /run/user/1000
ENV XDG_RUNTIME_DIR=/run/user/1000
EXPOSE 8080

WORKDIR /home/vscode
USER vscode
CMD [ "./start_http_server.sh" ]
