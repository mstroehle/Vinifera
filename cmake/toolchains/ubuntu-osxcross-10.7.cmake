# Sample toolchain file for building for Mac OS X from an Ubuntu Linux system.
#
# Typical usage:
#    *) install cross compiler from https://github.com/tpoechtrager/osxcross
#    *) mkdir build
#    *) cd build
#    *) cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/ubuntu-osxcross-10.7.cmake ..

set(CMAKE_SYSTEM_NAME Darwin)
set(TOOLCHAIN_PREFIX x86_64-apple-darwin10)

# cross compilers to use for C and C++
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-clang)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-clang++)
#set(CMAKE_AR ${TOOLCHAIN_PREFIX}-ar)
#set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}-ranlib)
#set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}-ld)

# target environment on the build host system
#   set 1st to dir with the cross compiler's C/C++ headers/libs
set(CMAKE_FIND_ROOT_PATH ~/Code/osxcross/target ~/Code/osxcross/target/SDK/MacOSX10.6.sdk)

# determined by toolchain
set(CMAKE_OSX_ARCHITECTURES "x86_64")

# modify default behavior of FIND_XXX() commands to
# search for headers/libs in the target environment and
# search for programs in the build host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
