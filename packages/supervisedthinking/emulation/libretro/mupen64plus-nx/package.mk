# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mupen64plus-nx"
PKG_VERSION="9f0849454dee17e66099ef8cdf8d53a86a3ade02"
PKG_SHA256="7fe742f5dd47bc5b0c354630b33f81981e76dc0f6d4f2a746b298fc3ac440502"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="https://github.com/libretro/mupen64plus-libretro-nx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc zlib libpng"
PKG_LONGDESC="Mupen64Plus is mupen64plus + GLideN64 + libretro"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

PKG_LIBNAME="mupen64plus_next_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

pre_configure_target() {
  # Set project specific platform flags
  case ${PROJECT} in
    Amlogic)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
    ;;
    RPi)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
    ;;
    Rockchip)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
    ;;
    *)
      # Arch ARM
      if [ "${ARCH}" = "arm" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        # NEON Support
        if target_has_feature neon; then
          PKG_MAKE_OPTS_TARGET+="-neon"
        fi
      fi

      # OpenGL ES Support
      if [ "${ARCH}" = "x86_64" ] && [ "${OPENGLES_SUPPORT}" = "yes" ]; then
        PKG_MAKE_OPTS_TARGET+=" FORCE_GLES3=1"
      fi
    ;;
  esac
  # Fix Mesa 3D based OpenGL ES builds
  if [ ! "${DISPLAYSERVER}" = "x11" ] && [ "${OPENGLES}" = "mesa" ]; then
    PKG_MAKE_OPTS_TARGET+=" EGL_NO_X11=1"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
