FROM cfs_builder_armv7l

# base packages
RUN yum install -y \
    file \
    libX11 \
    libXau \
    libxcb \
    libXdmcp \
    libXext \
    libXrender \
    libXt \
    mesa-libGL \
    mesa-libGLU \
    openssh-clients \
    patch \
    rsync \
    util-linux \
    wget \
    which \
    bzip2 \
    xorg-x11-server-Xvfb \
    && yum clean all

# ctng packages
RUN yum install -y \
    autoconf \
    gperf  \
    bison  \
    flex  \
    texinfo  \
    help2man  \
    gcc-c++  \
    patch \
    ncurses-devel  \
    python-devel  \
    perl-Thread-Queue  \
    bzip2  \
    git \
   && yum clean all

#crosstool-ng packages
RUN yum install -y \
    automake \
    libtool \
    make \
    unzip \
    && yum clean all

