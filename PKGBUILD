# Maintainer: Dennis Soong <dso2ng@gmail.com>
_realname=mongo-cxx-driver
pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-libmongocxx"
source gitver.sh && pkgver=$(get_latest_release mongodb/${_realname})
pkgdesc="libmongocxx is a client library written in C++ for MongoDB. (mingw-w64)"
pkgrel=1
arch=('any')
license=('Apache')
url="https://mongodb.github.io/mongo-cxx-driver/"
groups=('libraries')
makedepends=('curl' 'git' \
             "${MINGW_PACKAGE_PREFIX}-gcc" \
             "${MINGW_PACKAGE_PREFIX}-cmake" \
             "${MINGW_PACKAGE_PREFIX}-pkg-config")
depends=("${MINGW_PACKAGE_PREFIX}-libbson" \
         "${MINGW_PACKAGE_PREFIX}-libmongoc")
options=('!strip' '!buildflags' '!makeflags' 'staticlibs')
source=("${_realname}-${pkgver}.tar.gz"::"https://github.com/mongodb/${_realname}/archive/${pkgver}.tar.gz"
        gitver.sh)
sha256sums=('e26edd44cf20bd6be91907403b6d63a065ce95df4c61565770147a46716aad8c'
            'b6e2a94b64aad476f36dc1291fbe7d295630f796df07383bf1f1df8d7d7137d2')
prepare() {
  _srcpath=${srcdir}/${_realname}-${pkgver}
  cd ${_srcpath}
}

build() {
  _buildpath="${srcdir}/build-${MINGW_CHOST}"
  _buildpathstatic="${srcdir}/build-${MINGW_CHOST}-static"
  
  [[ -d "${_buildpath}" ]] && rm -rf "${_buildpath}"
  cp -ar "${_srcpath}/build" "${_buildpath}"
  cd "${_buildpath}"

# MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX=;-DCMAKE_PREFIX_PATH=;-DLIBMONGOC_DIR=;-DLIBBSON_DIR=" \
  MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX=;-DCMAKE_PREFIX_PATH=" \
  ${MINGW_PREFIX}/bin/cmake \
    -G"MSYS Makefiles" \
    "-DCMAKE_INSTALL_PREFIX=${MINGW_PREFIX}" \
    "-DCMAKE_PREFIX_PATH=${MINGW_PREFIX}" \
    "-DLIBMONGOC_DIR=${MINGW_PREFIX}" \
    "-DLIBBSON_DIR=${MINGW_PREFIX}" \
    "-DCMAKE_BUILD_TYPE=Release" \
    "-DENABLE_TESTS=OFF" \
    "-DBUILD_SHARED_LIBS=ON" \
    ${_srcpath}

  make

  [[ -d "${_buildpathstatic}" ]] && rm -rf "${_buildpathstatic}"
  cp -ar "${_srcpath}/build" "${_buildpathstatic}"
  cd "${_buildpathstatic}"

# MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX=;-DCMAKE_PREFIX_PATH=;-DLIBMONGOC_DIR=;-DLIBBSON_DIR=" \
  MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX=;-DCMAKE_PREFIX_PATH=" \
  ${MINGW_PREFIX}/bin/cmake \
    -G"MSYS Makefiles" \
    "-DCMAKE_INSTALL_PREFIX=${MINGW_PREFIX}" \
    "-DCMAKE_PREFIX_PATH=${MINGW_PREFIX}" \
    "-DLIBMONGOC_DIR=${MINGW_PREFIX}" \
    "-DLIBBSON_DIR=${MINGW_PREFIX}" \
    "-DCMAKE_BUILD_TYPE=Release" \
    "-DENABLE_TESTS=OFF" \
    "-DBUILD_SHARED_LIBS=OFF" \
    ${_srcpath}

  make
}

package() {
  cd ${_buildpath}
  make DESTDIR=${pkgdir} install

  cd ${_buildpathstatic}
  make DESTDIR=${pkgdir} install
}
# vim:set ts=2 sw=2 et:
