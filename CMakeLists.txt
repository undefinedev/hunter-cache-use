cmake_minimum_required(VERSION 3.16)

set(
        HUNTER_CACHE_SERVERS
        "https://github.com/undefinedev/hunter-cache"
        CACHE
        STRING
        "Default cache server"
)

# https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
#string(COMPARE EQUAL "$ENV{TRAVIS}" "true" is_travis)

# https://www.appveyor.com/docs/environment-variables/
string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" is_appveyor)

string(COMPARE EQUAL "$ENV{GITHUB_USER_PASSWORD}" "" password_is_empty)

#if((is_travis OR is_appveyor) AND NOT password_is_empty)

if((is_appveyor) AND NOT password_is_empty)
    option(HUNTER_RUN_UPLOAD "Upload cache binaries" ON)
endif()

set(
        HUNTER_PASSWORDS_PATH
        "${CMAKE_CURRENT_LIST_DIR}/cmake/Hunter/passwords.cmake"
        CACHE
        FILEPATH
        "Hunter passwords"
)

include(cmake/HunterGate.cmake)
HunterGate(
        URL "https://github.com/cpp-pm/hunter/archive/v0.24.1.tar.gz"
        SHA1 "4942227a6e6f5e64414c55b97ef98609de199d18"
)

project(foo)

hunter_add_package(sugar)