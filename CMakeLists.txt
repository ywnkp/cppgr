cmake_minimum_required(VERSION 3.8)

enable_testing()

set(CMAKE_CXX_STANDARD 11)

project(cppgr)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(boost)

add_subdirectory(tests)
