cmake_minimum_required(VERSION 3.8)
include(ExternalProject)

externalproject_add(contrib_github_gtest
    GIT_REPOSITORY    https://github.com/google/googletest.git
    GIT_TAG           release-1.10.0
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}"
    PREFIX contrib_github_gtest-1.10.0
)

add_library(gtest STATIC IMPORTED)
set_property(
    TARGET gtest
    PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/lib/libgtest.a
)
add_dependencies(gtest contrib_github_gtest)

add_library(gtest_main STATIC IMPORTED)
set_property(
    TARGET gtest_main
    PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/lib/libgtest_main.a
)
add_dependencies(gtest_main contrib_github_gtest)

include_directories(${CMAKE_CURRENT_BINARY_DIR}/include)

add_executable(test_stub
    test_stub.cpp
)
target_link_libraries(test_stub gtest gtest_main)
