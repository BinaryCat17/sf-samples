cmake_minimum_required(VERSION 3.25)
project(sf-samples LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Dependencies
if(NOT TARGET isa)
    find_package(sf-spec REQUIRED)
endif()

if(NOT TARGET compiler)
    find_package(sf-compiler REQUIRED)
endif()

if(NOT TARGET backend_cpu)
    find_package(sf-backend-cpu REQUIRED)
endif()

if(NOT TARGET engine)
    find_package(sf-runtime REQUIRED)
endif()

# Modules
add_subdirectory(apps/sf-runner)
add_subdirectory(apps/sf-window)

# Assets

file(COPY assets/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/assets)



# Tests

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests")

    add_subdirectory(tests)

endif()
