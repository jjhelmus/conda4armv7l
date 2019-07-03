#!/usr/bin/env bash

set -e -x
shopt -s extglob

# Adopt a Unix-friendly path if we're on Windows (see bld.bat).
[ -n "$PATH_OVERRIDE" ] && export PATH="$PATH_OVERRIDE"

export CFLAGS="${CFLAGS//-fvisibility=+([! ])/}"
export CXXFLAGS="${CXXFLAGS//-fvisibility=+([! ])/}"

# Some Windows builds also need the "mixed" Library prefix $LIBRARY_PREFIX_M
# (see bld.bat), but for this package we can keep things simple:
[ -n "$LIBRARY_PREFIX_U" ] && PREFIX="$LIBRARY_PREFIX_U"

configure_args=(
    --disable-debug
    --disable-dependency-tracking
    --prefix="${PREFIX}"
    --includedir="${PREFIX}/include"
)

# Windows fun

if [[ $(uname -o) == "Msys" ]] ; then
    # Many many many autotools bits hardcode Windows checks that fail when the
    # OS is our default, "msys2", rather than something starting with cygwin
    # or mingw.
    export BUILD=x86_64-pc-mingw64
    export HOST=x86_64-pc-mingw64

    # Needed for autoreconf to work - keep version sync'ed with meta.yaml.
    am_version=1.15
    export ACLOCAL=aclocal-$am_version
    export AUTOMAKE=automake-$am_version

    # Special compiler wrappers. Modern autotools do OK when working with "cl"
    # directly, but we need to preprocess an assembly (.S) file, which libffis
    # msvcc.sh wrapper takes care of.
    export CC="$(pwd)/msvcc.sh -m64"
    export CXX="$(pwd)/msvcc.sh -m64"
    export LD="link"
    export CPP="cl -nologo -EP"
    export CXXCPP="cl -nologo -EP"

    # Buuut the funky wrapper breaks shared library compilation for us, I
    # think. At least, other autotools-based builds *can* get shared libraries
    # working, but I can't pull it off here.
    configure_args+=(--disable-shared)

    # Remove the "/GL flag, which causes two problems. First, it messes up
    # Libtool's identification of how the linker works; it parses dumpbin
    # output and: https://stackoverflow.com/a/11850034/3760486 . Second, it
    # seems to break static library creation via "ar cru".
    export CFLAGS=$(echo " $CFLAGS " |sed -e "s, [-/]GL ,,")
    export CXXFLAGS=$(echo " $CXXFLAGS " |sed -e "s, [-/]GL ,,")
fi

configure_args+=(--build=$BUILD --host=$HOST)

autoreconf -vfi

if [[ $(uname) == "Linux" ]]; then
  # this changes the install dir from ${PREFIX}/lib64 to ${PREFIX}/lib
  sed -i 's:@toolexeclibdir@:$(libdir):g' Makefile.in */Makefile.in
  sed -i 's:@toolexeclibdir@:${libdir}:g' libffi.pc.in
fi

./configure "${configure_args[@]}" || { cat config.log; exit 1;}

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

find $PREFIX/. -name '*.la' -delete

# This overlaps with libgcc-ng:
rm -rf ${PREFIX}/share/info/dir
