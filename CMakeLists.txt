cmake_minimum_required(VERSION 3.2)

set(
        HUNTER_CACHE_SERVERS
        "https://github.com/undefinedev/hunter-cache"
        CACHE STRING
        "Default cache server"
)

# https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
#string(COMPARE EQUAL "$ENV{TRAVIS}" "true" is_travis)

# https://www.appveyor.com/docs/environment-variables/
#string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" is_appveyor)

string(COMPARE EQUAL "$ENV{GITHUB_USER_PASSWORD}" "" password_is_empty)

if(NOT password_is_empty)
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
        URL "https://github.com/undefinedev/hunter/archive/v0.25.2.tar.gz"
        SHA1 "e57398df0d69a5357e663507958c6e0cb675c2da"
)

project(foo)

hunter_add_package(GTest)
hunter_add_package(sugar)
hunter_add_package(Banking)
hunter_add_package(asio)
hunter_add_package(pcg)
hunter_add_package(nlohmann_json)