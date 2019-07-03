#!/bin/bash

# NO_INSTALL_HARDLINKS uses symlinks which makes the package 85MB slimmer (8MB instead of 93MB!)

# Add a place for git config files.
mkdir -p $PREFIX/etc
make configure
./configure \
    --prefix="${PREFIX}" \
    --with-gitattributes="${PREFIX}/etc/gitattributes" \
    --with-gitconfig="${PREFIX}/etc/gitconfig" \
    --with-iconv="${PREFIX}/lib" \
    --with-perl="${PREFIX}/bin/perl" \
    --with-tcltk="${PREFIX}/bin/tclsh"
make \
    --jobs="$CPU_COUNT" \
    NO_INSTALL_HARDLINKS=1 \
    all strip install

# build osxkeychain
if [[ $(uname) == "Darwin" ]]; then
  pushd contrib/credential/osxkeychain
  make -e
  cp -avf git-credential-osxkeychain $PREFIX/bin
  popd
fi

git config --system http.sslVerify true
git config --system http.sslCAPath "${PREFIX}/ssl/cacert.pem"
git config --system http.sslCAInfo "${PREFIX}/ssl/cacert.pem"

# Install completion files
mkdir -p $PREFIX/share/bash-completion/completions
cp contrib/completion/git-completion.bash $PREFIX/share/bash-completion/completions/git


