cmake_minimum_required(VERSION 3.6)
project(openslide)

set(OPENSLIDE_MAJOR_VERSION "3")
set(OPENSLIDE_MINOR_VERSION_STRING "5")
set(OPENSLIDE_MICRO_VERSION "0")
set(OPENSLIDE_VERSION "${OPENSLIDE_MAJOR_VERSION}.${OPENSLIDE_MINOR_VERSION_STRING}.${OPENSLIDE_MICRO_VERSION}")
set(SOURCE_DIR "src")

include_directories(${SOURCE_DIR})

include(CheckIncludeFiles)
include(CheckSymbolExists)
include(CheckFunctionExists)
include(CheckTypeSize)
include(CheckCXXCompilerFlag)
include(CheckVariableExists)

option(WITH_VALGRID "Build with Valgrid" OFF)
option(BUILD_TESTS "Build test programs" OFF)
option(BUILD_TOOLS "Build tools" OFF)

find_package(PkgConfig 0.9 REQUIRED)
pkg_check_modules(zlib REQUIRED IMPORTED_TARGET zlib)
pkg_check_modules(libopenjp2 REQUIRED IMPORTED_TARGET libopenjp2>=2.1.0])
pkg_check_modules(glib2 REQUIRED IMPORTED_TARGET glib-2.0>=2.56 gio-2.0>=2.56)
pkg_check_modules(libtiff REQUIRED IMPORTED_TARGET libtiff-4)
pkg_check_modules(libjpeg REQUIRED IMPORTED_TARGET libjpeg)
pkg_check_modules(cairo REQUIRED IMPORTED_TARGET cairo>=1.2)
pkg_check_modules(libpng REQUIRED IMPORTED_TARGET libpng>1.2)
pkg_check_modules(gdkpixbuf REQUIRED IMPORTED_TARGET gdk-pixbuf-2.0>=2.14)
pkg_check_modules(libxml2 REQUIRED IMPORTED_TARGET libxml-2.0)
pkg_check_modules(sqlite3 REQUIRED IMPORTED_TARGET sqlite3>=3.6.20)
pkg_check_modules(valgrind IMPORTED_TARGET valgrind)

if(WITH_VALGRIND)
    set(HAVE_VALGRID 1)
else()
    set(HAVE_VALGRID 0)
endif()

# Set FOPEN_CLOEXEC_FLAG flag
if(WIN32)
    set(FOPEN_CLOEXEC_FLAG "N")
else()
    set(FOPEN_CLOEXEC_FLAG "e")
endif()

# Check compiler flags
check_cxx_compiler_flag(-fvisibility=hidden HAVE_VISIBILITY)

# Check if functions exist
check_function_exists(fcntl HAVE_FCNTL)
check_function_exists(fseeko HAVE_FSEEKO)
check_function_exists(proc_pidfdinfo HAVE_PROC_PIDFDINFO)
check_function_exists(_wfopen HAVE__WFOPEN)

# Check includes
check_include_files(dlfcn.h HAVE_FCNTL_H)
check_include_files(inttypes.h HAVE_INTTYPES_H)
check_include_files(memory.h HAVE_MEMORY_H)
check_include_files(stdint.h HAVE_STDINT_H)
check_include_files(stdlib.h HAVE_STDLIB_H)
check_include_files(strings.h HAVE_STRINGS_H)
check_include_files(string.h HAVE_STRING_H)
check_include_files(sys/stat.h HAVE_SYS_STAT_H)
check_include_files(sys/types.h HAVE_SYS_TYPES_H)
check_include_files(unistd.h HAVE_UNISTD_H)
check_include_files("valgrind.h;callgrind.h;memcheck.h" HAVE_VALGRIND)
check_include_files("stdlib.h;stdarg.h;string.h;float.h" STDC_HEADERS)


check_type_size(uintptr_t UINTPTR_T)
if(NOT HAVE_UINTPTR_T)
    if("${CMAKE_SIZEOF_VOID_P}" EQUAL 8)
        set(uintptr_t "uint64_t")
    else()
        set(uintptr_t "uint32_t")
    endif()
endif()


# Create configure file
configure_file(config.h.cmake config.h)

set(OPENSLIDE_SRC
    ${SOURCE_DIR}/openslide.c
    ${SOURCE_DIR}/openslide-cache.c
    ${SOURCE_DIR}/openslide-decode-gdkpixbuf.c
    ${SOURCE_DIR}/openslide-decode-jp2k.c
    ${SOURCE_DIR}/openslide-decode-jpeg.c
    ${SOURCE_DIR}/openslide-decode-png.c
    ${SOURCE_DIR}/openslide-decode-sqlite.c
    ${SOURCE_DIR}/openslide-decode-tiff.c
    ${SOURCE_DIR}/openslide-decode-tifflike.c
    ${SOURCE_DIR}/openslide-decode-xml.c
    ${SOURCE_DIR}/openslide-error.c
    ${SOURCE_DIR}/openslide-grid.c
    ${SOURCE_DIR}/openslide-hash.c
    ${SOURCE_DIR}/openslide-jdatasrc.c
    ${SOURCE_DIR}/openslide-util.c
    ${SOURCE_DIR}/openslide-vendor-aperio.c
    ${SOURCE_DIR}/openslide-vendor-generic-tiff.c
    ${SOURCE_DIR}/openslide-vendor-hamamatsu.c
    ${SOURCE_DIR}/openslide-vendor-leica.c
    ${SOURCE_DIR}/openslide-vendor-mirax.c
    ${SOURCE_DIR}/openslide-vendor-philips.c
    ${SOURCE_DIR}/openslide-vendor-sakura.c
    ${SOURCE_DIR}/openslide-vendor-trestle.c
    ${SOURCE_DIR}/openslide-vendor-ventana.c
    openslide-tables.c
        )

set(make-table_SOURCES ${SOURCE_DIR}/make-tables.c)
add_executable(make-tables ${make-table_SOURCES})
add_custom_target(make-tables_run
        COMMAND make-tables openslide-tables.c
        COMMENT "Creating openslide-tables.c..."
        BYPRODUCTS openslide-tables.c
        )

add_library(openslide SHARED "${OPENSLIDE_SRC}")
add_dependencies(openslide make-tables_run)


target_include_directories(openslide PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(openslide
        PkgConfig::zlib
        PkgConfig::libopenjp2
        PkgConfig::glib2
        PkgConfig::libtiff
        PkgConfig::libjpeg
        PkgConfig::cairo
        PkgConfig::libpng
        PkgConfig::gdkpixbuf
        PkgConfig::libxml2
        PkgConfig::sqlite3)
if(HAS_VALGRIND)
    target_link_libraries(openslide
            PkgConfig::valgrind)
endif()

add_subdirectory(common)
if(BUILD_TESTS)
    add_subdirectory(test)
endif(BUILD_TESTS)
if(BUILD_TOOLS)
    add_subdirectory(tools)
endif(BUILD_TOOLS)

install(TARGETS openslide LIBRARY DESTINATION lib)

