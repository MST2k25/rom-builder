ARG LINUX_DISTRO
ARG LINUX_DISTRO_RELEASE

FROM ${LINUX_DISTRO}:${LINUX_DISTRO_RELEASE}
ARG HOME_DIR=/root

ENV DEBIAN_FRONTEND='noninteractive'

RUN apt-get clean && \
    apt-get update && \
    apt-get -y dist-upgrade

RUN apt-get update && \
    apt-get install -y \
        bc \
        bison \
        build-essential \
        ccache \
        curl \
        flex \
        g++-multilib \
        gcc-multilib \
        git \
        gnupg \
        gperf \
        imagemagick \
        lib32ncurses-dev \
        lib32readline-dev \
        lib32z1-dev \
        libncurses-dev \
        libncurses6 \
        libsdl1.2-dev \
        libssl-dev \
        libwxgtk3.2-dev \
        libxml2-16 \
        libxml2-dev \
        lz4 \
        lzop \
        nano \
        neovim \
        pngcrush \
        python-is-python3 \
        python3 \
        rsync \
        schedtool \
        squashfs-tools \
        xsltproc \
        zip \
        zlib1g-dev \
        android-sdk-platform-tools \
    && rm -rf /var/lib/apt/lists/*

ADD setup/arb.sh $HOME_DIR/.arb
ADD build/setup.sh $HOME_DIR/setup.sh
RUN $HOME_DIR/setup.sh
RUN rm $HOME_DIR/setup.sh

WORKDIR $HOME_DIR

ADD setup/init.sh $HOME_DIR/init.sh
RUN echo "./init.sh" >> $HOME_DIR/.bashrc

ARG ARB_VERSION
ENV ARB_VERSION=${ARB_VERSION}

ENTRYPOINT ["/bin/bash"]
