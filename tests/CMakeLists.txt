# SionFlow Test Suite Discovery
set(SF_TEST_RUNNER "${SF_SPEC_DIR}/tools/test.py")

function(register_sf_tests dir_path category)
    file(GLOB_RECURSE tests "${dir_path}/*.json" "${dir_path}/*.mfapp")
    foreach(test_file ${tests})
        get_filename_component(test_name ${test_file} NAME_WE)
        get_filename_component(test_ext ${test_file} LAST_EXT)
        get_filename_component(test_dir ${test_file} DIRECTORY)
        string(REPLACE "." "" ext_clean ${test_ext})
        
        # Create a unique name based on relative path to avoid collisions
        file(RELATIVE_PATH rel_path ${dir_path} ${test_file})
        string(REPLACE "/" "." rel_name ${rel_path})
        set(full_test_name "${category}.${rel_name}")
        
        set(expect_fail "")
        if(test_name MATCHES "^fail_" OR test_dir MATCHES "negative")
            set(expect_fail "--expect-fail")
        endif()

        add_test(
            NAME ${full_test_name}
            COMMAND ${Python3_EXECUTABLE} "${SF_TEST_RUNNER}"
                --sfc $<TARGET_FILE:sfc>
                --runner $<TARGET_FILE:sf-runner>
                --input "${test_file}"
                ${expect_fail}
        )
    endforeach()
endfunction()

# Discover tests in various directories
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/unit/math" "unit.math")
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/unit/logic" "unit.logic")
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/unit/data" "unit.data")
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/unit/structure" "unit.structure")
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/validation" "validation")
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}/integration/test_pipeline" "integration")

# Also individual tests at the root of tests dir
register_sf_tests("${CMAKE_CURRENT_SOURCE_DIR}" "core")
