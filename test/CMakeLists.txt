cmake_minimum_required(VERSION 3.6)
project(openslide-tests)

set(SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
include_directories(${SOURCE_DIR})

set(COMMON_DIR ${CMAKE_SOURCE_DIR}/common)
include_directories(${COMMON_DIR})

set(TEST_DIR ${CMAKE_SOURCE_DIR}/test)
include_directories(${TEST_DIR})

include_directories(${CMAKE_BINARY_DIR})

set(HEADER_FILES
        ${SOURCE_DIR}/openslide.h
        ${COMMON_DIR}/openslide-common.h
        ${CMAKE_BINARY_DIR}/config.h
        )

set(TEST_SOURCES
        test.c
        try_open.c
        parallel.c
        query.c
        extended.c
        mosaic.c
        profile.c)

# Driver???

foreach(test_sourcefile ${TEST_SOURCES} )
    string(REPLACE ".c" "" test ${test_sourcefile} )
    add_executable(${test} ${TEST_DIR}/${test_sourcefile} )
    target_link_libraries(${test}
            PRIVATE openslide_common
            PRIVATE openslide
            PkgConfig::cairo
            PkgConfig::glib2)
endforeach()

