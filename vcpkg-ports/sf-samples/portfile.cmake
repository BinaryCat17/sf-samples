set(SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../sf-samples")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    GENERATOR "Ninja"
)

vcpkg_cmake_install()

# Install tools to bin/ folder
vcpkg_copy_tools(
    TOOL_NAMES sf-runner sf-window
    AUTO_CLEAN
)

file(WRITE "${CURRENT_PACKAGES_DIR}/share/sf-samples/copyright" "Copyright (c) SionFlow")
