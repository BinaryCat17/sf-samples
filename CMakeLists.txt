cmake_minimum_required(VERSION 3.25)
project(sf-samples LANGUAGES C) # Enable C for dependency compatibility

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
