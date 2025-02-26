ExternalProject_Add(fontconfig
    DEPENDS
        expat
        freetype2
        zlib
        libiconv
    GIT_REPOSITORY https://gitlab.freedesktop.org/fontconfig/fontconfig.git
    SOURCE_DIR ${SOURCE_LOCATION}
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--filter=tree:0"
    PATCH_COMMAND ${EXEC} patch -p1 ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-0001-Custom-changes-for-mpv-builds.patch && patch -p1 ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-0002-Do-not-use-dirent.h.patch
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup <BINARY_DIR> <SOURCE_DIR>
        --prefix=${MINGW_INSTALL_PREFIX}
        --libdir=${MINGW_INSTALL_PREFIX}/lib
        --cross-file=${MESON_CROSS}
        --buildtype=release
        --default-library=static
        -Ddoc=disabled
        -Dtests=disabled
        -Dtools=disabled
        -Dcache-build=disabled
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(fontconfig)
force_meson_configure(fontconfig)
cleanup(fontconfig install)
