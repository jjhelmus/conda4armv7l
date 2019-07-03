The recipes in this repository were built in the following order:

# Built in `compiler_builder` container 

* crosstools-ng
* ctng-compilers - gfortran test will fail, this is fine

# Built in `pkg_builder` container

* ctng-compilers-activation - gfortran test will fail, this is fine
* make
* m4
* perl
* libtool
* autoconf
* automake
* zlib
* pkg-config
* ncurses
* unzip
* bzip2
* xz
* expat
* ca-certificates : skip tests, requires curl which has not been built yet
* rhash
* libedit
* readline
* sqlite
* patch
* libffi
* gettext

# Planned build order

# problems
* help2man : perl issue
* openssl : perl issue

# 90
* wget
* libx11-common-cos7-armv7l
* libx11-cos7-armv7l
* libx11-devel-cos7-armv7l
* libxau-cos7-armv7l
* libxcb-cos7-armv7l

# 85
* xorg-x11-proto-devel-cos7-armv7l
* tk
* python
* certifi
* setuptools

# 80
* wheel
* pip
* cython
* conda-env
* six

# 75
* idna
* setuptools_scm
* atomicwrites
* attrs
* more-itertools

# 70
* pluggy
* py
* pytest
* pytest-runner
* chardet

# 65
* pycparser
* cffi
* asn1crypto
* cryptography-vectors
* iso8601

# 60
* coverage
* pretend
* pytz
* pbr
* cookies

# 55
* mock
* ptyprocess
* pexpect
* hypothesis : build with --no-test, lot of requirements for tests
* crytography

# 50
* pyopenssl
* pysocks
* urllib3
* requests
* responses

# 45
* cake_nosystemcurl
* libssh2
* curl
* beautifulsoup4
* cmake

# 40
* yaml
* ruamel_yaml
* git
* pycosat
* conda

# 35
* filelock
* glob2
* markupsafe
* jinja2
* psutil

# 30
* pkginfo
* pyyaml
* tqdm
* patchelf

# 25
* lz4-c
* lzo
* nose
* pkgconfig
* lz4

# 20
* icu
* libxml2
* zstd
* libarchive
* python-libarchive-c

# 15
* lief
* conda-build
* constructor
* clyent
* ipython_genutils

# 10
* decorator
* traitlets
* vcversioner
* jsonschema
* jupyter_core

# 5
* nbformat
* flex
* bison
* python-dateutil
* anaconda-client
