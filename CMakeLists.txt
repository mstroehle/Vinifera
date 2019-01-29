cmake_minimum_required(VERSION 3.1.0)

if(POLICY CMP0074)
  cmake_policy(SET CMP0074 NEW)
endif()

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "No build type selected, default to Debug")
    set(CMAKE_BUILD_TYPE "Debug")
endif()

if(MSVC)
    set(MSVC_INCREMENTAL_DEFAULT ON)
endif()

project(Vinifera VERSION 2.03.0 LANGUAGES C CXX) # Latest TS patch version

# Set version info for the git version module.
set(GITINFO_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(GITINFO_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(GITINFO_VERSION_PATCH ${PROJECT_VERSION_PATCH})

if(MSVC)
    # Prevent incremental linking in Debug builds.
    string(REPLACE "INCREMENTAL" "INCREMENTAL:NO" replacement_flags ${CMAKE_EXE_LINKER_FLAGS_DEBUG})
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "/DYNAMICBASE:NO /NXCOMPAT:NO /INCREMENTAL:NO ${replacement_flags}")
    set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "/DYNAMICBASE:NO /NXCOMPAT:NO /INCREMENTAL:NO ${replacement_flags}")

    # Prevent incremental linking in Release builds wuth debug info.
    string(REPLACE "INCREMENTAL" "INCREMENTAL:NO" replacement_flags ${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO})
    set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "/INCREMENTAL:NO ${replacement_flags}")
    set(CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO "/INCREMENTAL:NO ${replacement_flags}")
    
    # Disable Run Time Checking.
    foreach(flag_var
        CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
        CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
        CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)
        #message("Processing flags ${flag_var}")
        string(REGEX REPLACE "/RTC[^ ]*" "" ${flag_var} "${${flag_var}}")
    endforeach(flag_var)
    
    # add flags required for trying matching pre-compiled game code.
    add_definitions(/arch:IA32)
    add_definitions(/fp:fast)
    add_definitions(/QIfist)
    add_definitions(/Qfast_transcendentals)
    #add_definitions(/Gr) # forces fastcall as default calling convention.
    add_definitions(/GS-)
    #add_definitions(/Qi) # (Generate Intrinsic Functions)
    #add_definitions(/Q1)
    #add_definitions(/Zp4)
endif()

# Disable warnings for MSVC
if(MSVC)
    # Set warning level 4
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
    
    # For catching unrefernced local variables, we do not need to worry about this when compiling debug builds.
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4189")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4101")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4700") # uninitialized local variable 'x' used.
    
    # disable C4244: conversion from 'double' to 'float', possible loss of data
    # disable C4800: 'BOOL' : forcing value to bool 'true' or 'false' (performance warning)
    # disable C4351: "new behavior: elements of array will be default initialized"
    # disable C4514: "unreferenced inline function has been removed" Yea, so what?
    # disable C4065: "switch statement contains 'default' but no 'case' labels"
    # disable C4514: "unreferenced inline function has been removed" Yea, so what?
    # disable C4065: "switch statement contains 'default' but no 'case' labels"
    # disable C4244: "conversion from 'double' to 'float', possible loss of data" Yea, so what?
    # disable C4530: Disable warning about exception handling not being enabled. It's used as part of STL - in a part of STL we don't use.
    # disable C4056: "overflow in floating-point constant arithmetic" This warning occurs even if the loss of precision is insignificant.
    # disable C4710: "function not inlined" This warning is typically useless. The inline keyword only serves as a suggestion to the compiler and it may or may not inline a function on a case by case basis. No need to be told of this.
    # disable C4355: "'this' used in base member initializer list" Using "this" in a base member initializer is valid -- no need for this warning.
    # disable C4097: "typedef-name used as a synonym for class-name". This is by design and should not be a warning.
    # disable C4091: 'typedef ': ignored on left of '' when no variable is declared
    # disable C4505: Unreferenced local function removed.
    # disable C4511: 'copy constructor could not be generated'
    # disable C4512: 'assignment operator could not be generated' 
    # disable C4100: 'unreferenced formal parameter'
    # disable C4786: "identifier was truncated to '255' characters in the browser information" Tempates create long identifiers...
    # disable C4711: 'function selected for automatic inline expansion'. Cool, but since we're treating warnings as errors, don't warn us about this!
    # disable C4800: 'BOOL' : forcing value to bool 'true' or 'false' (performance warning)
    # disable C4996: 'This function or variable may be unsafe. Consider using fopen_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. See online help for details.'
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4244")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4800")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4351")    
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4514")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4065")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4244")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4530")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4056")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4710")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4355")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4097")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4091")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4505")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4711")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4512")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4100")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4786")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4800")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4996")
endif()

# Moves BUILD_ALL and ZERO_CHECK into CMakePredefinedTargets filter.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(PREDEFINED_TARGETS_FOLDER "CustomTargets")

set(CMAKE_CXX_STANDARD 14)

# We don't support in tree builds, so help people make the right choice.
if (CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR)
    message(FATAL_ERROR "Building in-source is not supported! Create a build dir and remove ${CMAKE_SOURCE_DIR}/CMakeCache.txt")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake/modules)

if(WIN32 OR "${CMAKE_SYSTEM}" MATCHES "Windows")
    set(DEFAULT_STANDALONE OFF)
else()
    set(DEFAULT_STANDALONE ON)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(DEFAULT_LOGGING ON)
    set(DEFAULT_ASSERTIONS ON)
else()
    set(DEFAULT_LOGGING OFF)
    set(DEFAULT_ASSERTIONS OFF)
endif()

option(OPTION_BUILD_DOC "Build doxygen documentation for this project." ON)
option(OPTION_USE_GAMEMATH "Use own maths library rather than libc version for this platform." ON)
option(OPTION_STANDALONE "Build a standalone version." ${DEFAULT_STANDALONE})
option(OPTION_LOGGING "Enable debug logging." ${DEFAULT_LOGGING})
option(OPTION_ASSERTIONS "Enable debug assertions." ${DEFAULT_ASSERTIONS})
option(OPTION_USE_SDL2 "Enable SDL2 for graphics and input handling." OFF)
option(OPTION_USE_OPENAL "Enable OpenAL for audio output." OFF)

include(CheckCXXCompilerFlag)

# Go lean and mean on windows.
if(WIN32 OR "${CMAKE_SYSTEM}" MATCHES "Windows")
    add_definitions(-DWIN32_LEAN_AND_MEAN)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
    if(CMAKE_SIZEOF_VOID_P EQUAL 4 AND NOT OPTION_STANDALONE)
        add_definitions(-D_USE_32BIT_TIME_T) # This is for ABI compatibility with a few functions, remove when original binary no longer required.
    endif()
endif()

check_cxx_compiler_flag(-Wno-invalid-offsetof HAVE_NO_INVALID_OFFSETOF)

if(HAVE_NO_INVALID_OFFSETOF)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-invalid-offsetof")
endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # Prevent lib prefix when built with MinGW to target windows and move to own dir.
    if(MINGW)
        set(CMAKE_SHARED_LIBRARY_PREFIX "")
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++ -mabi=ms")
    endif()
endif ()

# Enable a standalone build
if(OPTION_STANDALONE)
    add_definitions(-DVINIFERA_STANDALONE)
endif()

# Enable debug logging.
if(OPTION_LOGGING)
    add_definitions(-DVINIFERA_LOGGING)
endif()

# Prevent lib prefix when built with MinGW to target windows and move to own dir.
if(MINGW)
    add_definitions(-D__STDC_FORMAT_MACROS)
    add_definitions(-D__STDC_LIMIT_MACROS)
    set(CMAKE_SHARED_LIBRARY_PREFIX "")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++ -std=gnu++0x -mabi=ms -Wno-invalid-offsetof")
endif()

if(OPTION_USE_GAMEMATH)
    add_subdirectory(libs/gamemath EXCLUDE_FROM_ALL)
    add_definitions(-DBUILD_WITH_GAMEMATH)
    set(PLATFORM_LIBS ${PLATFORM_LIBS} gamemath_static_lib)
endif()

# Include some standard CMake modules we use.
include(CheckSymbolExists)
include(CheckIncludeFile)

# Check for libraries we plan to build against.
if(OPTION_USE_SDL2)
    find_package(SDL2 REQUIRED)
endif()

if(OPTION_USE_OPENAL)
    find_package(OpenAL REQUIRED)
endif()

if(NOT OPTION_USE_SDL2 OR NOT OPTION_USE_OPENAL)
    find_package(DirectX REQUIRED dsound)
endif()

# Build doxygen documentation.
if(OPTION_BUILD_DOC)
    #find_package(Doxygen)
    #if(DOXYGEN_FOUND)
    #    # set input and output files
    #    set(DOXYGEN_IN ${PROJECT_SOURCE_DIR}/doxyfile.in)
    #    set(DOXYGEN_OUT ${PROJECT_BINARY_DIR}/doxyfile)
    #
    #    # request to configure the file
    #    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    #
    #    # note the option ALL which allows to build the docs together with the application
    #    add_custom_target(DoxygenDoc ALL
    #        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    #        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    #        COMMENT "Generating project documentation with Doxygen."
    #        VERBATIM )
    #else()
    #    message("Doxygen need to be installed to generate the doxygen documentation.")
    #endif()
endif()

# Set where the build results will end up
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

# Add platform libraries needed for the build
if(WIN32 OR "${CMAKE_SYSTEM}" MATCHES "Windows")
    if(DirectX_FOUND)
        list(APPEND PLATFORM_INCLUDES ${DirectX_INCLUDE_DIRS})
        list(APPEND PLATFORM_LIBS ${DirectX_LIBRARIES})
    endif()
    
    if(OPTION_STANDALONE)
        list(APPEND PLATFORM_LIBS ws2_32)
    else()
        list(APPEND PLATFORM_LIBS wsock32) # Original links wsock32, not ws2_32
    endif()

    list(APPEND PLATFORM_LIBS winmm dbghelp comctl32 dxguid)
    
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
    list(APPEND PLATFORM_LIBS rt)   
else()
    #No other platforms yet.
endif()

# Add baseconfig module
add_subdirectory(${CMAKE_SOURCE_DIR}/libs/baseconfig)

if(NOT OPTION_STANDALONE)
    # Make the project name lowercase for assigning filenames.
    set(SETSAIL_PROJECT_NAME ${CMAKE_PROJECT_NAME})
    string(TOLOWER ${SETSAIL_PROJECT_NAME} SETSAIL_PROJECT_NAME)
    
    set(SETSAIL_ENTRY 0x006B7E21) # TS real entry point (start)
    set(SETSAIL_DLL ${SETSAIL_PROJECT_NAME}.dll)
    set(SETSAIL_EXE game.exe)
    set(SETSAIL_LAUNCHER launch${SETSAIL_PROJECT_NAME})
    set(SETSAIL_HASH e1b997b4a83b84b5481f773b0b001e3186d02990) # SHA hash for TS2.03EN 'GAME.EXE'
    
    message("Configuring launcher as ${SETSAIL_LAUNCHER} using entry at ${SETSAIL_ENTRY} to inject ${SETSAIL_DLL} into ${SETSAIL_EXE}")

    # Build the launcher
    add_subdirectory(launcher)
endif()

# Build Vinifera
add_subdirectory(src)
