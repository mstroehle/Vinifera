# Sample toolchain file for building for Windows with a mingw-builds mingw system.
#
# Typical usage:
#    *) install compiler
#    *) cd build
#    *) cmake -DCMAKE_TOOLCHAIN_FILE=..\cmake\toolchains\windows-mingw32.cmake ..

set(CMAKE_SYSTEM_NAME Windows)
set(TOOLCHAIN_PREFIX i686-w64-mingw32)
set(CMAKE_SYSROOT C:/msys64/mingw32-win)

# cross compilers to use for C and C++
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc.exe)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++.exe)
set(CMAKE_AR ${TOOLCHAIN_PREFIX}-gcc-ar.exe)
set(CMAKE_RC_COMPILER windres.exe)

# target environment on the build host system
#   set 1st to dir with the cross compiler's C/C++ headers/libs
set(CMAKE_FIND_ROOT_PATH C:/msys64/mingw32-win C:/msys64/mingw32-win/${TOOLCHAIN_PREFIX})

# modify default behavior of FIND_XXX() commands to
# search for headers/libs in the target environment and
# search for programs in the build host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
