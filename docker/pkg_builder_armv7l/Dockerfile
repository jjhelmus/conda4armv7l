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

CMD [ "linux32", "/bin/bash" ]
