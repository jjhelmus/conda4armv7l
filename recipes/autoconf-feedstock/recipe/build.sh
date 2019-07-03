#!/bin/sh

if [[ ${target_platform} == linux-ppc64le ]]; then
    pushd
    rm config.guess
    curl -o config.guess http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD
    popd
fi

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}            \
            PERL='/usr/bin/env perl'

make -j${CPU_COUNT} ${VERBOSE_AT}
make check || { cat tests/testsuite.log; exit 1; }
make install
