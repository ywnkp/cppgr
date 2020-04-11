include(ExternalProject)
include(include_once)
include_once()

include(ProcessorCount)
ProcessorCount(NPROC)

set(contrib_github_boost_git_tag boost-1.72.0)
externalproject_add(contrib_github_boost
    GIT_REPOSITORY    https://github.com/boostorg/boost.git
    GIT_TAG ${contrib_github_boost_git_tag}
    GIT_SUBMODULES tools/build
                   tools/boost_install # from tools/build
                   libs/config # from tools/build
                   libs/headers # from tools/build
                   libs/fiber
                   libs/context # from fiber
                   libs/smart_ptr # from fiber
                   libs/core # from fiber
                   libs/filesystem # from fiber
                   libs/intrusive # from fiber
                   libs/assert # from context
                   libs/system # from filesystem
                   libs/detail # from filesystem
                   libs/predef # from filesystem
                   libs/type_traits # from filesystem
                   libs/iterator # from filesystem
                   libs/io # from filesystem
                   libs/functional # from filesystem
                   libs/container_hash # from filesystem
                   libs/mpl # from iterator
                   libs/move # from intrusive
                   libs/static_assert # from move
                   libs/preprocessor # from mpl
                   libs/pool # from context
                   libs/integer # from pool
    # Settings for faster download and to suppress warnings
    GIT_SHALLOW 1
    GIT_CONFIG advice.detachedHead=false submodule.fetchJobs=${NPROC} 
    #[[
        When CONFIGURE_COMMAND and BUILD_COMMAND are used,
        b2 and bootstrap.sh run every time when rebuilding,
        slow down the build.
        Use CMakeLists.txt patching to prevent unnecessary builds
        from running if dependencies are resolved during rebuild.
    ]]
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_LIST_DIR}/patch/boost/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt
    UPDATE_DISCONNECTED 1
    PREFIX contrib_github_boost-${contrib_github_boost_git_tag}
    INSTALL_COMMAND cmake -E echo "Skipping install step."
    BUILD_BYPRODUCTS <BINARY_DIR>/lib/libboost_context-mt-x64.a
                     <BINARY_DIR>/lib/libboost_fiber-mt-x64.a
)

externalproject_get_property(contrib_github_boost SOURCE_DIR)
externalproject_get_property(contrib_github_boost BINARY_DIR)

include_directories(${SOURCE_DIR})

add_library(boost_context STATIC IMPORTED)
set_property(
    TARGET boost_context
    PROPERTY IMPORTED_LOCATION ${BINARY_DIR}/lib/libboost_context-mt-x64.a
)
add_dependencies(boost_context contrib_github_boost)


add_library(boost_fiber STATIC IMPORTED)
set_property(
    TARGET boost_fiber
    PROPERTY IMPORTED_LOCATION ${BINARY_DIR}/lib/libboost_fiber-mt-x64.a
)
add_dependencies(boost_fiber contrib_github_boost)
