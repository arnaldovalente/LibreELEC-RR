# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="genesis-plus-gx-wide"
PKG_VERSION="fa71a1640f6a01025a045b616007c2fe4effd384"
PKG_SHA256="4ed8aba9c9a93ac4026ac94a9d5d8193b2f7c9ee526e91c28d235303e4b44cf7"
PKG_LICENSE="Modified BSD / LGPL-2.1-or-later"
PKG_SITE="https://github.com/libretro/Genesis-Plus-GX-Wide"
PKG_URL="https://github.com/libretro/Genesis-Plus-GX-Wide/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Widescreen modification of Genesis Plus GX"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="genesis_plus_gx_wide_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  case ${PROJECT} in
    Amlogic)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
      ;;
    RPi)
      case ${DEVICE} in
        RPi)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi"
          ;;
        RPi2)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
          ;;
        RPi3)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi3"
          ;;
        RPi4)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi4"
          ;;
      esac
      ;;
    Rockchip)
        PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
      ;;
    *)
      if [ "${ARCH}" = "arm" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        CFLAGS+=" -DALIGN_LONG"
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
