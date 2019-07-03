#!/bin/sh

set -x

./configure --prefix=${PREFIX} --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" --disable-openssl
make -j${CPU_COUNT}
make install
make -C librhash install-headers install-so-link
