FROM cfs_base_armv7l

LABEL maintainer="Jonathan J. Helmus <jjhelmus@gmail.com>"

# Build tools, will be removed at the end
RUN yum install -y \
    gcc \
    gcc-c++ \
    libstdc++-devel \
  && yum clean all

# Build and install patchelf
ENV PATCHELF_VERSION  0.9
RUN curl -O https://nixos.org/releases/patchelf/patchelf-${PATCHELF_VERSION}/patchelf-${PATCHELF_VERSION}.tar.gz && \
    tar xf patchelf-${PATCHELF_VERSION}.tar.gz && \
    pushd patchelf-${PATCHELF_VERSION} && \
    linux32 ./configure --prefix ${CFS_PREFIX} && \
    linux32 make -j && \
    linux32 make install && \
    popd && \
    rm -rf patchelf-${PATCHELF_VERSION} patchelf-${PATCHELF_VERSION}.tar.gz

# Install python packages required by conda-build
RUN ${CFS_PREFIX}/bin/python3 -m pip install \
    beautifulsoup4 \
    chardet \
    filelock \
    glob2 \
    jinja2 \
    pkginfo \
    psutil \
    pytz \
    pyyaml \
    six \
    tqdm

# Install conda-build
ENV CONDA_BUILD_VERSION 3.16.3
RUN curl -L -O https://github.com/conda/conda-build/archive/${CONDA_BUILD_VERSION}.tar.gz && \
    tar xf ${CONDA_BUILD_VERSION}.tar.gz && \
    pushd conda-build-${CONDA_BUILD_VERSION} && \
    ${CFS_PREFIX}/bin/python3 setup.py install --single-version-externally-managed --record record.txt && \
    popd && \
    rm -rf conda-build-${CONDA_BUILD_VERSION} ${CONDA_BUILD_VERSION}.tar.gz

# Remove build tools
RUN yum remove -y \
    gcc \
    gcc-c++ \
    libstdc++-devel \
  && yum clean all

CMD [ "linux32", "/bin/bash" ]
