cmake_minimum_required(VERSION 3.8)

project(boost)

include(ProcessorCount)
ProcessorCount(NPROC)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/b2
    COMMAND ${CMAKE_SOURCE_DIR}/bootstrap.sh --without-icu --without-libraries=python
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

add_custom_command(
    OUTPUT ${CMAKE_SOURCE_DIR}/boost/version.hpp
           ${CMAKE_BINARY_DIR}/lib/libboost_context-mt-x64.a
           ${CMAKE_BINARY_DIR}/lib/libboost_fiber-mt-x64.a
    COMMAND ${CMAKE_BINARY_DIR}/b2
            --includedir=${CMAKE_SOURCE_DIR}
            --reconfigure
            --layout=tagged
            --prefix=${CMAKE_BINARY_DIR}
            --build-dir=${CMAKE_BINARY_DIR}
            --stagedir=${CMAKE_BINARY_DIR}
            -j${NPROC}
            threading=multi
            variant=release
            link=static
            cxxstd=11
            address-model=64
            visibility=global
            --with-context
            --with-fiber
            stage
    DEPENDS ${CMAKE_BINARY_DIR}/b2
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

add_custom_target(build ALL
    DEPENDS ${CMAKE_SOURCE_DIR}/boost/version.hpp
            ${CMAKE_BINARY_DIR}/lib/libboost_context-mt-x64.a
            ${CMAKE_BINARY_DIR}/lib/libboost_fiber-mt-x64.a
)
