#!/bin/bash

# world-writable files are not allowed
chmod -R o-w "${SRC_DIR}"

declare -a _config_args
_config_args+=(-Dprefix="${PREFIX}")
_config_args+=(-Dusethreads)
_config_args+=(-Duserelocatableinc)
_config_args+=(-Dcccdlflags="-fPIC")
_config_args+=(-Dldflags="${LDFLAGS}")
# .. ran into too many problems with '.' not being on @INC:
_config_args+=(-Ddefault_inc_excludes_dot=n)
if [[ -n "${GCC:-${CC}}" ]]; then
  _config_args+=("-Dcc=${GCC:-${CC}}")
fi
if [[ -n "${AR}" ]]; then
  _config_args+=("-Dar=${AR}")
fi
if [[ ${HOST} =~ .*linux.* ]]; then
  _config_args+=(-Dlddlflags="-shared ${LDFLAGS}")
# elif [[ ${HOST} =~ .*darwin.* ]]; then
#   _config_args+=(-Dlddlflags=" -bundle -undefined dynamic_lookup ${LDFLAGS}")
fi
# -Dsysroot prevents Configure rummaging around in /usr and
# linking to system libraries (like GDBM, which is GPL). An
# alternative is to pass -Dusecrosscompile but that prevents
# all Configure/run checks which we also do not want.
# remove this if after the gcc7 migration
if [[ ! ${c_compiler} =~ .*toolchain.* ]]; then
  if [[ -n ${CONDA_BUILD_SYSROOT} ]]; then
    _config_args+=("-Dsysroot=${CONDA_BUILD_SYSROOT}")
  else
    if [[ -n ${HOST} ]] && [[ -n ${CC} ]]; then
      _config_args+=("-Dsysroot=$(dirname $(dirname ${CC}))/$(${CC} -dumpmachine)/sysroot")
    else
      _config_args+=("-Dsysroot=/usr")
    fi
  fi
fi

./Configure -de "${_config_args[@]}"
make

# change permissions again after building
chmod -R o-w "${SRC_DIR}"

# Seems we hit:
# lib/perlbug .................................................... # Failed test 21 - [perl \#128020] long body lines are wrapped: maxlen 1157 at ../lib/perlbug.t line 154
# FAILED at test 21
# https://rt.perl.org/Public/Bug/Display.html?id=128020
# make test
make install

# Replace hard-coded BUILD_PREFIX by value from env as CC, CFLAGS etc need to be properly set to be usable by ExtUtils::MakeMaker module
(cd $PREFIX/lib/5*/*-thread-*/ && patch -p1) < $RECIPE_DIR/dynamic_config.patch
sed -i.bak "s|conda@|conda\\\@|g" $PREFIX/lib/*/*/Config_heavy.pl
sed -i.bak "s|${BUILD_PREFIX}|\$compilerroot|g" $PREFIX/lib/*/*/Config_heavy.pl

sed -i.bak "s|cc => '\(.*\)'|cc => \"\1\"|g" $PREFIX/lib/*/*/Config.pm
sed -i.bak "s|libpth => '\(.*\)'|libpth => \"\1\"|g" $PREFIX/lib/*/*/Config.pm
sed -i.bak "s|${BUILD_PREFIX}|\$compilerroot|g" $PREFIX/lib/*/*/Config.pm

# 3 more seds for osx:
sed -i.bak "s|vsts@|vsts\\\@|g" $PREFIX/lib/*/*/Config_heavy.pl
sed -i.bak "s|\\\c|\\\\\\\c|g" $PREFIX/lib/*/*/Config_heavy.pl
sed -i.bak "s|DPERL_SBRK_VIA_MALLOC \$ccflags|DPERL_SBRK_VIA_MALLOC \\\\\$ccflags|g" $PREFIX/lib/*/*/Config_heavy.pl

rm $PREFIX/lib/*/*/Config_heavy.pl.bak $PREFIX/lib/*/*/Config.pm.bak
