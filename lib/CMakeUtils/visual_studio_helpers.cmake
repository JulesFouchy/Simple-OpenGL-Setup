function(Cool__vs_hide_all_build_and_zero_check)
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endfunction()

# Recreate the folder architecture inside the Visual Studio solution
function(Cool__vs_register_files _FILES)
    foreach(_file IN ITEMS ${_FILES})
        get_filename_component(_filepath "${_file}" PATH)
        string(REPLACE "${CMAKE_SOURCE_DIR}" "" _group_path "${_filepath}")
        string(REPLACE "/" "\\" _group_path "${_group_path}")
        source_group("${_group_path}" FILES "${_file}")
    endforeach()
endfunction()