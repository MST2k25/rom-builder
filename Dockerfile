ARG LINUX_DISTRO
ARG LINUX_DISTRO_RELEASE

FROM ${LINUX_DISTRO}:${LINUX_DISTRO_RELEASE}

ARG USER_UID=1000
ARG USER_GID=1000
ARG HOME_DIR=/home/ubuntu

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
        git-lfs \
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
        tmux \
        xsltproc \
        zip \
        zlib1g-dev \
        android-sdk-platform-tools \
    && rm -rf /var/lib/apt/lists/*

ADD --chown=${USER_UID}:${USER_GID} setup/arb.sh ${HOME_DIR}/.arb
ADD --chown=${USER_UID}:${USER_GID} build/setup.sh ${HOME_DIR}/setup.sh

RUN ${HOME_DIR}/setup.sh && \
    rm ${HOME_DIR}/setup.sh

ADD --chown=${USER_UID}:${USER_GID} setup/init.sh ${HOME_DIR}/init.sh

RUN mkdir -p "${HOME_DIR}/.local/share/bash" && \
    echo './init.sh' >> "${HOME_DIR}/.bashrc" && \
    echo "export HISTFILE=${HOME_DIR}/.local/share/bash/history" >> "${HOME_DIR}/.bashrc" && \
    chown -R ${USER_UID}:${USER_GID} "${HOME_DIR}"

ARG ARB_VERSION
ENV ARB_VERSION=${ARB_VERSION}

WORKDIR ${HOME_DIR}

USER ${USER_UID}:${USER_GID}

ENTRYPOINT ["/bin/bash"]
