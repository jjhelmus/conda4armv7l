#!/bin/bash

RPM=$(find ${PWD}/binary -name "*.rpm")
mkdir -p ${PREFIX}/armv7-conda_cos7-linux-gnueabihf/sysroot/usr
pushd ${PREFIX}/armv7-conda_cos7-linux-gnueabihf/sysroot/usr > /dev/null 2>&1
if [[ -n "${RPM}" ]]; then
  "${RECIPE_DIR}"/rpm2cpio "${RPM}" | cpio -idmv
  popd > /dev/null 2>&1
else
  cp -Rf "${SRC_DIR}"/binary/* .
fi
