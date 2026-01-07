cmake_minimum_required(VERSION 3.25)
project(sf-samples LANGUAGES C) # Enable C for dependency compatibility

# Direct Linking: Search in build root if available
if(DEFINED ENV{SIONFLOW_BUILD_ROOT})
    list(APPEND CMAKE_PREFIX_PATH 
        "$ENV{SIONFLOW_BUILD_ROOT}/sf-spec/x64-linux"
        "$ENV{SIONFLOW_BUILD_ROOT}/sf-compiler/x64-linux"
        "$ENV{SIONFLOW_BUILD_ROOT}/sf-runtime/x64-linux"
        "$ENV{SIONFLOW_BUILD_ROOT}/sf-backend-cpu/x64-linux"
    )
    message(STATUS "Direct Linking: Added SionFlow modules build paths to CMAKE_PREFIX_PATH")
endif()

find_package(sf-compiler REQUIRED)
find_package(sf-runtime REQUIRED)
find_package(sf-backend-cpu REQUIRED)

add_subdirectory(apps/sf-runner)
add_subdirectory(apps/sf-window)

enable_testing()

# Helper macro to add a compilation test
macro(add_sf_sample name json_path)
    add_test(NAME compile_${name}
        COMMAND SionFlow::sfc ${CMAKE_CURRENT_SOURCE_DIR}/${json_path} -o ${CMAKE_CURRENT_BINARY_DIR}/${name}.sfc
    )
    
    add_test(NAME run_${name}
        COMMAND SionFlow::sf-runner ${CMAKE_CURRENT_BINARY_DIR}/${name}.sfc --headless --test
    )
    set_tests_properties(run_${name} PROPERTIES DEPENDS compile_${name})
endmacro()

# Example samples
add_sf_sample(simple simple.json) # Assuming simple.json exists
add_sf_sample(inventory inventory/inventory.json)
