cmake_minimum_required(VERSION 3.6)
project(openslide-tools)

set(SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
include_directories(${SOURCE_DIR})

set(COMMON_DIR ${CMAKE_SOURCE_DIR}/common)
include_directories(${COMMON_DIR})

set(TOOLS_DIR ${CMAKE_SOURCE_DIR}/tools)
include_directories(${TOOLS_DIR})

include_directories(${CMAKE_BINARY_DIR})

set(HEADER_FILES
        ${SOURCE_DIR}/openslide.h
        ${COMMON_DIR}/openslide-common.h
        ${CMAKE_BINARY_DIR}/config.h
        )

set(TOOL_SOURCES
        openslide-show-properties.c
        openslide-quickhash1sum.c
        openslide-write-png.c)

foreach(tool_sourcefile ${TOOL_SOURCES} )
    string(REPLACE ".c" "" tool ${tool_sourcefile} )
    add_executable(${tool} ${TOOLS_DIR}/${tool_sourcefile} )
    target_link_libraries(${tool}
            PRIVATE openslide_common
            PRIVATE openslide
            PkgConfig::cairo
            PkgConfig::glib2)
endforeach()

install (TARGETS openslide-show-properties RUNTIME DESTINATION bin)
install (TARGETS openslide-quickhash1sum RUNTIME DESTINATION bin)
install (TARGETS openslide-write-png RUNTIME DESTINATION bin)

# TODO:
# Install tools
# Install manfiles