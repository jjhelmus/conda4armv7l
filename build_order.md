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
* help2man
* openssl
* libunistring
* libidn2
* wget
* libuv
* cmake_nosystemcurl : does not pass tests
* libssh2
* libx11-common-cos7-armv7l
* libx11-cos7-armv7l
* libx11-devel-cos7-armv7l
* libxau-cos7-armv7l
* libxcb-cos7-armv7l
* xorg-x11-proto-devel-cos7-armv7l
* tk
* flex
* bison
* lz4-c
* patchelf
* yaml
* python
* certifi
* setuptools
* wheel
* pip
* cython
* conda-env
* six
* idna
* setuptools_scm
* more-itertools
* importlib_metadata
* py
* pluggy
* pyparsing
* packaging
* wcwidth
* atomicwrites : build with --no-test due to circular dep on pytest
* attrs : build with --no-test due to numerous test requirements
* pytest
* pytest-runner
* chardet
* pycparser
* cffi
* asn1crypto
* iso8601
* coverage
* pretend
* pytz
* pbr
* cookies
* mock
* pytoml
* hypothesis
* cryptography-vectors
* pyopenssl
* pysocks
* crytography : build with --no-test, look into why tests halt build
* urllib3 : version 1.24.2, needed for requests
* pycosat
* filelock
* glob2
* markupsafe
* jinja2
* psutil
* pkginfo
* pyyaml
* tqdm
* nose
* pkgconfig
* lz4
* clyent
* decorator
* ipython_genutils
* traitlets
* vcversioner
* jupyter_core
* python-dateutil
* zipp
* pyrsistent
* jsonschema
* nbformat
* soupsieve
* beautifulsoup4
* ruamel_yaml
* docutils
* requests
* responses
* requests_download
* flit
* ptyprocess
* pexpect
* anaconda-client
* krb5
* curl
* cmake
* lzo
* zstd
* libxml2
* libarchive
* git
* lief
* python-libarchive-c
* pytest-mock : build with --no-test as tests are failing, investigate why
* conda-package-handling : build with --no-test as tests are failing, investigate why
* conda
* constructor
* conda-build
* su-exec
* tini
