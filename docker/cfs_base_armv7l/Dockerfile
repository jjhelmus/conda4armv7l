FROM arm32v7/centos:7

LABEL maintainer="Jonathan J. Helmus <jjhelmus@gmail.com>"

# configure yum and rpm for running on armv8l
RUN echo "armhfp" > /etc/yum/vars/basearch && \
    echo "armv7hl" > /etc/yum/vars/arch && \
    echo "armv7hl-redhat-linux-gpu" > /etc/rpm/platform

# Set an encoding to make things work smoothly.
ENV LANG en_US.UTF-8

# location where conda from scatch is installed
ENV CFS_PREFIX /opt/cfs

# Resolves a nasty NOKEY warning that appears when using yum.
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-AltArch-Arm32 && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# Fix up issues with locales because the default images have these minimized
# to the point of not being properly functional
# See: https://github.com/CentOS/sig-cloud-instance-images/issues/71
RUN yum update -y && \
    yum reinstall -y glibc-common && \
    yum clean all
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# Install basic requirements.
RUN yum update -y && \
    yum install -y \
        bzip2 \
        tar \
        which \
    && yum clean all

# Build tools, gcc will be removed at the end
RUN yum install -y \
    curl \
    gcc \
    make \
    perl \
  && yum clean all

# Install Python from source
# system library headers needed by Python, removed after Python install
RUN yum install -y \
    bzip2-devel \
    libffi-devel \
    openssl-devel \
    readline-devel \
    sqlite-devel \
    zlib-devel \
  && yum clean all

ENV PYTHON_VERSION 3.7.3
RUN curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar xf Python-${PYTHON_VERSION}.tgz && \
    pushd Python-${PYTHON_VERSION} && \
    linux32 ./configure --disable-shared --prefix ${CFS_PREFIX} && \
    linux32 make -j && \
    linux32 make install && \
    ln -s ${CFS_PREFIX}/bin/python3 ${CFS_PREFIX}/bin/python && \
    ln -s ${CFS_PREFIX}/bin/pip3 ${CFS_PREFIX}/bin/pip && \
    popd && \
    rm -rf Python-${PYTHON_VERSION} Python-${PYTHON_VERSION}.tgz

# Build and install conda-package-handling and requirements including libarchive
ENV LIBARCHIVE_VERSION 3.3.3
ENV LIBARCHIVE=/opt/cfs/lib/libarchive.so
RUN curl -O https://www.libarchive.org/downloads/libarchive-${LIBARCHIVE_VERSION}.tar.gz && \
    tar xf libarchive-${LIBARCHIVE_VERSION}.tar.gz && \
    pushd libarchive-${LIBARCHIVE_VERSION} && \
    linux32 ./configure --prefix ${CFS_PREFIX} && \
    linux32 make -j && \
    linux32 make install && \
    popd && \
    rm -rf libarchive-${LIBARCHIVE_VERSION} libarchive-${LIBARCHIVE_VERSION}.tar.gz

RUN ${CFS_PREFIX}/bin/python3 -m pip install six tqdm libarchive-c

ENV CPH_VERSION 1.3.10
RUN curl -L -O https://github.com/conda/conda-package-handling/releases/download/${CPH_VERSION}/conda-package-handling-${CPH_VERSION}.tar.gz && \
    tar xf conda-package-handling-${CPH_VERSION}.tar.gz && \
    pushd conda-package-handling-${CPH_VERSION} && \
    ${CFS_PREFIX}/bin/python3 setup.py install --single-version-externally-managed --record record.txt && \
    popd && \
    rm -rf conda-package-handling-${CPH_VERSION} conda-package-handling-${CPH_VERSION}.tar.gz

# Install additonal python packages required by conda
RUN ${CFS_PREFIX}/bin/python3 -m pip install requests pycosat pyopenssl ruamel.yaml

# Install conda from source
ENV CONDA_VERSION 4.7.5
RUN curl -L -O https://github.com/conda/conda/archive/${CONDA_VERSION}.tar.gz && \
    tar xf ${CONDA_VERSION}.tar.gz && \
    pushd conda-${CONDA_VERSION} && \
    echo ${CONDA_VERSION} > conda/.version && \
    ${CFS_PREFIX}/bin/python3 setup.py install --single-version-externally-managed --record record.txt && \
    ${CFS_PREFIX}/bin/python3 -m conda init --install && \
    ln -s ${CFS_PREFIX}/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    mkdir -p ${CFS_PREFIX}/conda-meta && \
    popd && \
    rm -rf conda-${CONDA_VERSION} ${CONDA_VERSION}.tar.gz


# Remove un-needed build tools
RUN yum remove -y \
    gcc \
  && yum clean all

RUN yum remove -y \
    bzip2-devel \
    openssl-devel \
    readline-devel \
    sqlite-devel \
    zlib-devel \
  && yum clean all

# Kludge so that conda understands armv8l as linux-armv7l
ENV CONDA_SUBDIR linux-armv7l

CMD [ "/bin/bash" ]
