cmake_minimum_required(VERSION 3.8)
include(ExternalProject)

set(contrib_github_gtest_git_tag release-1.10.0)
externalproject_add(contrib_github_gtest
    GIT_REPOSITORY    https://github.com/google/googletest.git
    GIT_TAG           ${contrib_github_gtest_git_tag}
    GIT_CONFIG advice.detachedHead=false
    PREFIX contrib_github_gtest-${contrib_github_gtest_git_tag}
    BUILD_BYPRODUCTS <BINARY_DIR>/lib/libgtest.a <BINARY_DIR>/lib/libgtest_main.a
    INSTALL_COMMAND ""
)

externalproject_get_property(contrib_github_gtest BINARY_DIR)
externalproject_get_property(contrib_github_gtest SOURCE_DIR)

add_library(gtest STATIC IMPORTED)
set_property(
    TARGET gtest
    PROPERTY IMPORTED_LOCATION ${BINARY_DIR}/lib/libgtest.a
)
add_dependencies(gtest contrib_github_gtest)

add_library(gtest_main STATIC IMPORTED)
set_property(
    TARGET gtest_main
    PROPERTY IMPORTED_LOCATION ${BINARY_DIR}/lib/libgtest_main.a
)
add_dependencies(gtest_main contrib_github_gtest)

include_directories(${SOURCE_DIR}/googletest/include)

find_package(Threads)

add_executable(test_stub
    test_stub.cpp
)
target_link_libraries(test_stub gtest gtest_main ${CMAKE_THREAD_LIBS_INIT})

add_test(NAME test_stub
    COMMAND $<TARGET_FILE:test_stub> --gtest_output=xml:${CMAKE_CURRENT_BINARY_DIR}/
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
