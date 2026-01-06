cmake_minimum_required(VERSION 3.25)

project(sf-window)

if(TARGET SionFlow::host_sdl)
find_package(sf-backend-cpu REQUIRED)

add_executable(sf-window 
    src/main.c
)

target_include_directories(sf-window PRIVATE 
)

target_link_libraries(sf-window 
    PRIVATE 
        SionFlow::host_sdl
        SionFlow::backend_cpu
        SionFlow::base
)
else()
    message(STATUS "Skipping sf-window (SionFlow::host_sdl not available)")
endif()