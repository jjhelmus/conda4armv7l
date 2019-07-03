## Introduction

This repository contains conda recipes, Docker images and tools for building a
set of [conda](https://conda.io/en/latest/) packages for the 32-bit ARM
architecture.  Specifically 32-bit devices using version 7 or newer of the ARM
architecture with hardware floating point. 
The major Linux distributions refer to this as
[armhf](https://wiki.debian.org/ArmHardFloatPort) or
[armhfp](https://fedoraproject.org/wiki/Architectures/ARM).
In conda this is best described by the `linux-armv7l` platform.

Packages from this work are available in the [c4armv7l](https://anaconda.org/c4armv7l)
channel. The final goal is to produce a miniconda like installer which can
be used as a starting point for the conda-forge community to build a more
complete set of packages for this platform.

All packages were build inside a CentOS 7 Docker container and should support
Linux distributions which have a glibc version of 2.17 or newer. These 
packages should work on all major distribution which support the armhf or 
armhfp architectures including Debian Jessie, Ubuntu 16.04, and Fedora 28.  

## Key package versions


| package | version |
| --- | --- |
| glibc | 2.17 |
| gcc | 8.3.0 |
| binutils | 2.29.1 |
| OpenSSL | 1.1.1c |
| Python | 3.7.3 |
| pip | 10.0.1 |
| conda | 4.7.5 |
| conda-build | 3.17.8 |
| constructor | 2.2.0 |
| anaconda-client | 1.6.14 |

The order in which recipes were built can be found in the 
[build_order.md](https://github.com/jjhelmus/conda4armv7l/blob/master/build_order.md) document.

## Related work

Earlier this year I, Jonathan Helmus, create a similar set of packages for the
64-bit ARM platform (aarch64 or arm64) in the 
[conda4aarch64 repository](https://github.com/jjhelmus/conda4armv7l)

The conda-forge community has begun to build packages for the `linux-aarch64`
platform as part of the ARM/PowerPC migration.  This build out can be tracked 
on the [conda-forge status page](https://conda-forge.org/status/).  
Any help porting the recipes in this repository to conda-forge would be most appreciated.
A discussions around conda-forge's support of aarch64 as well as other ARM
platforms can be found in 
[this GitHub issue.](https://github.com/conda-forge/conda-forge.github.io/issues/269)

In have also worked on [Berryconda](https://github.com/jjhelmus/berryconda), a
conda based Python distribution for the Raspberry Pi single board computers. 
Two flavors of the distribution support the `armv7l` and `armv6l` Raspberry Pis.
