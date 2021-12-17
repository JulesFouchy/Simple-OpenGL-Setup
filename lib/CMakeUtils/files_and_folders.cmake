#! Copies FILE to the directory where the executable of your TARGET will be created (you can optionally specify a third argument to override that destination folder)
#  FILE can be either an absolute or a relative path. If it is relative it will be relative to ${CMAKE_SOURCE_DIR}.
#  Unlike the default CMake functions this one will re-copy the file whenever it changes
function(Cool__target_copy_file TARGET FILE)
    # Get OUT_DIR as an optional parameter
    if (${ARGC} GREATER_EQUAL 3)
        set(OUT_DIR ${ARGV2})
    else()
        set(OUT_DIR $<TARGET_FILE_DIR:${TARGET}>)
    endif()
    # Get the part of the file path relative to the top-level CMakeLists.txt
    cmake_path(RELATIVE_PATH FILE BASE_DIRECTORY ${CMAKE_SOURCE_DIR} OUTPUT_VARIABLE FILE_RELATIVE_PATH)
    if (NOT FILE_RELATIVE_PATH)
        set(FILE_RELATIVE_PATH ${FILE})
    endif()
    # Add the copy command
    set(DUMMY_OUTPUT_NAME ${CMAKE_CURRENT_BINARY_DIR}/DUMMY_${FILE_RELATIVE_PATH}_${TARGET})
    add_custom_command(
        COMMENT "Copying \"${FILE_RELATIVE_PATH}\""
        OUTPUT ${DUMMY_OUTPUT_NAME}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DUMMY_OUTPUT_NAME} # Create a dummy directory that CMake will use as a timestamp reference to know if the actual file has changed, when it checks for the OUTPUT (unfortunately OUTPUT can't use a generator expression so we can't use our actual output file as the OUTPUT)
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/${FILE_RELATIVE_PATH} ${OUT_DIR}/${FILE_RELATIVE_PATH} # Actual copy of the file to the destination
        MAIN_DEPENDENCY ${FILE}
    )
    target_sources(${TARGET} PRIVATE ${FILE}) # Required for the custom command to be run when we build our target
endfunction()

#! Copies FOLDER and all its files to the directory where the executable of your TARGET will be created (you can optionally specify a third argument to override that destination folder)
#  FOLDER can be either an absolute or a relative path. If it is relative it will be relative to ${CMAKE_SOURCE_DIR}.
#  Unlike the default CMake functions this one will re-copy the files of the folder whenever they change or a file is added
function(Cool__target_copy_folder TARGET FOLDER)
    # Get OUT_DIR as an optional parameter
    if (${ARGC} GREATER_EQUAL 3)
        set(OUT_DIR ${ARGV2})
    else()
        set(OUT_DIR $<TARGET_FILE_DIR:${TARGET}>)
    endif()
    # Copy each file
    file(GLOB_RECURSE FILES CONFIGURE_DEPENDS ${FOLDER}/*)
    foreach(FILE ${FILES})
        Cool__target_copy_file(${TARGET} ${FILE} ${OUT_DIR})
    endforeach()
endfunction()

function(Cool__create_file_if_it_doesnt_exist FILE)
    file(APPEND ${FILE} "")
endfunction()