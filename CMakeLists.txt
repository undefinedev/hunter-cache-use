#cmake_minimum_required(VERSION 3.16)
##set(CMAKE_C_COMPILER "C:/msys64/mingw64/bin/cc.exe")
##set(CMAKE_CXX_COMPILER "C:/msys64/mingw64/bin/c++.exe")
##set(CMAKE_MAKE_PROGRAM "C:/Program Files/JetBrains/CLion 2021.2.1/bin/ninja/win/ninja.exe")
#
#set(
#        HUNTER_CACHE_SERVERS
#        "https://github.com/undefinedev/hunter-cache"
#        CACHE
#        STRING
#        "Default cache server"
#)
#
## https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
##string(COMPARE EQUAL "$ENV{TRAVIS}" "true" is_travis)
#
## https://www.appveyor.com/docs/environment-variables/
##string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" is_appveyor)
#
#string(COMPARE EQUAL "$ENV{GITHUB_USER_PASSWORD}" "" password_is_empty)
#
##if((is_travis OR is_appveyor) AND NOT password_is_empty)
#
#if(NOT password_is_empty)
#    option(HUNTER_RUN_UPLOAD "Upload cache binaries" ON)
#endif()
#
#option(HUNTER_RUN_UPLOAD "Upload cache binaries" ON)
#
#set(
#        HUNTER_PASSWORDS_PATH
#        "${CMAKE_CURRENT_LIST_DIR}/cmake/Hunter/passwords.cmake"
#        CACHE
#        FILEPATH
#        "Hunter passwords"
#)
#
#include(cmake/HunterGate.cmake)
#HunterGate(
#        URL "https://github.com/cpp-pm/hunter/archive/v0.24.1.tar.gz"
#        SHA1 "4942227a6e6f5e64414c55b97ef98609de199d18"
#)
#
#project(foo)
#
#hunter_add_package(sugar)


cmake_minimum_required(VERSION 3.0)

#string(COMPARE NOTEQUAL "$ENV{TRAVIS_TAG}" "" travis_deploy)
string(COMPARE EQUAL "$ENV{APPVEYOR_REPO_TAG}" "true" appveyor_deploy)

#if(travis_deploy)
#    set(version "$ENV{TRAVIS_TAG}")
if(appveyor_deploy)
    set(version "$ENV{APPVEYOR_REPO_TAG_NAME}")
else()
    set(version "v0.0.0")
endif()

string(REGEX REPLACE "^v" "" version "${version}")

project(Foo VERSION ${version})

add_library(foo foo.cpp)
add_executable(boo foo.cpp)

install(TARGETS foo DESTINATION lib)
install(TARGETS boo DESTINATION bin)

set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

if(travis_deploy OR appveyor_deploy)
    string(COMPARE EQUAL "$ENV{CONFIG}" "Debug" debug_build)
    if(debug_build)
        set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}-Debug")
    else()
        set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}")
    endif()
endif()

include(CPack)