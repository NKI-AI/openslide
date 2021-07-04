cmake_minimum_required(VERSION 3.6)
project(openslide-common)

set(COMMON_DIR ${CMAKE_SOURCE_DIR}/common)
include_directories(${COMMON_DIR})

include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_BINARY_DIR})

set(OPENSLIDE_COMMON_SRC
        ${COMMON_DIR}/openslide-common-cmdline.c
        ${COMMON_DIR}/openslide-common-fail.c
        ${COMMON_DIR}/openslide-common-fd.c
        )

add_library(openslide_common SHARED "${OPENSLIDE_COMMON_SRC}")
target_link_libraries(openslide_common
        PRIVATE openslide
        PkgConfig::cairo
        PkgConfig::glib2)

install(TARGETS openslide_common LIBRARY DESTINATION lib)