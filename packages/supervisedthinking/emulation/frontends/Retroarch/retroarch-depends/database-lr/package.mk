# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="database-lr"
PKG_VERSION="1.9.9"
PKG_SHA256="25a93e997137e0be2716802b0890744842867238d6ce312d96b91e03b0c021c2"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-database"
PKG_URL="https://github.com/libretro/libretro-database/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="RetroArch database containing cheatcode files, content data files, etc."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/database"
}

post_makeinstall_target() {
  # Remove common unnecessary databases
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/MAME.rdb
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2000.rdb
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2003.rdb
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2015.rdb
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/Microsoft*Xbox*.rdb
  safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/Sony*PlayStation*3*.rdb

  # Remove additional unnecessary databases
  if [ ! "${PROJECT}" = "Generic" ]; then
    safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*GameCube*.rdb
    safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*Nintendo*3DS*.rdb
    safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*Wii*.rdb
  elif [ "${PROJECT}" = "Generic" ]; then
    safe_remove ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2010.rdb
  fi
}
