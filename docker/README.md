This directory contains Dockerfiles to build images for the following
containers for building packages for linux-armv7l.

* `cfs_base_armv7l` : base image
* `cfs_builder_armv7l`: base builder image
* `compiler_builder_armv7l` : image for building compiler packages
* `pkg_builder_armv7l` : image for building all other packages

To build these images use:

    docker build -t cfs_base_armv7l cfs_base_armv7l/
    docker build -t cfs_builder_armv7l cfs_builder_armv7l/
    docker build -t compiler_builder_armv7l compiler_builder_armv7l/
    docker build -t pkg_builder_armv7l pkg_builder_armv7l/
