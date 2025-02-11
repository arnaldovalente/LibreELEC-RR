# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gdk-pixbuf"
PKG_VERSION="2.42.8"
PKG_SHA256="84acea3acb2411b29134b32015a5b1aaa62844b19c4b1ef8b8971c6b0759f4c6"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${PKG_VERSION:0:4}/gdk-pixbuf-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libjpeg-turbo libpng jasper shared-mime-info tiff"
PKG_DEPENDS_CONFIG="shared-mime-info"
PKG_LONGDESC="GdkPixbuf is a a GNOME library for image loading and manipulation."

PKG_MESON_OPTS_TARGET="-Dbuiltin_loaders=all \
                       -Dgtk_doc=false \
                       -Ddocs=false \
                       -Dintrospection=disabled \
                       -Dman=false \
                       -Drelocatable=false \
                       -Dinstalled_tests=false"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/gdk-pixbuf-2.0/2.10.0/
    cp ${PKG_DIR}/config/* ${INSTALL}/usr/lib/gdk-pixbuf-2.0/2.10.0/
}
