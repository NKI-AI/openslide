// Set to the fopen() flag string that sets FD_CLOEXEC, or an empty string if not supported. */
#cmakedefine FOPEN_CLOEXEC_FLAG "${FOPEN_CLOEXEC_FLAG}"

// includes (CHECKED)
#cmakedefine01 HAVE_DLFCN_H
#cmakedefine01 HAVE_INTTYPES_H
#cmakedefine01 HAVE_MEMORY_H
#cmakedefine01 HAVE_STDINT_H
#cmakedefine01 HAVE_STDLIB_H
#cmakedefine01 HAVE_STRINGS_H
#cmakedefine01 HAVE_STRING_H
#cmakedefine01 HAVE_SYS_STAT_H
#cmakedefine01 HAVE_SYS_TYPES_H
#cmakedefine01 HAVE_UNISTD_H
#cmakedefine01 STDC_HEADERS
#cmakedefine HAVE_VALGRIND

// check functions
#cmakedefine HAVE_FCNTL ${HAVE_FCNTL}
#cmakedefine HAVE_FSEEKO ${HAVE_FSEEKO}
#cmakedefine HAVE_PROC_PIDFDINFO ${HAVE_PROC_PIDFDINFO}
#cmakedefine HAVE__WFOPEN ${HAVE__WFOPEN}

// Check if system has uintptr_t
#cmakedefine01 HAVE_UINTPTR_T

// Check compiler flags (checked)
#cmakedefine HAVE_VISIBILITY ${HAVE_VISIBILITY}

/* Number of bits in a file offset, on hosts where this is settable. */
#cmakedefine _FILE_OFFSET_BITS @_FILE_OFFSET_BITS@

/* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). From original OpenSlide. Uncomment if needed */
/* #undef _LARGEFILE_SOURCE */

/* Define for large files, on AIX-style hosts. From original OpenSlide. Not intending to support AIX */
/* #undef _LARGE_FILES */

/* Define to the type of an unsigned integer type wide enough to hold a
   pointer, if such a type exists, and if the system does not define it. Not yet ported from OpenSlide */
/* #undef uintptr_t */

// Enable large inode numbers on Mac OS X 10.5.  */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif

// Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

// Name of package */
#define PACKAGE "openslide"

// Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "openslide-users@lists.andrew.cmu.edu"

/* Define to the full name of this package. */
#define PACKAGE_NAME "OpenSlide"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "OpenSlide ${OPENSLIDE_VERSION}"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "openslide"

/* Define to the home page for this package. */
#define PACKAGE_URL "https://openslide.org"

/* Define to the version of this package. */
#define PACKAGE_VERSION "${OPENSLIDE_VERSION}"

/* Define to the package version string including any suffix. */
#define SUFFIXED_VERSION "${OPENSLIDE_VERSION}"

/* Version number of package */
#define VERSION "${OPENSLIDE_VERSION}"