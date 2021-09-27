cmake_minimum_required(VERSION 3.0)

# Set project name
project(SimpleOpenGL C CXX)
# Set C++ version
set(CXX_STANDARD 11)
# Set the folder where the executable is created
set(EXECUTABLE_OUTPUT_PATH 
    ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE}
)

# Grab all the source files
file(GLOB_RECURSE MY_SOURCES
    src/*
)
# Create target executable
add_executable(${PROJECT_NAME}
    ${MY_SOURCES}
)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD ${CXX_STANDARD})

# Set include directories
include_directories(
    src
)

# OpenGL
find_package(OpenGL REQUIRED)
include_directories(
    ${OPENGL_INCLUDE_DIR}
)
target_link_libraries(${PROJECT_NAME}
    ${OPENGL_LIBRARIES}
)

# GLFW
set(GLFW_DIR lib/glfw)
option(GLFW_BUILD_EXAMPLES "Build the GLFW example programs" OFF)
option(GLFW_BUILD_TESTS "Build the GLFW test programs" OFF)
option(GLFW_BUILD_DOCS "Build the GLFW documentation" OFF)
option(GLFW_INSTALL "Generate installation target" OFF)
option(GLFW_DOCUMENT_INTERNALS "Include internals in documentation" OFF)
add_subdirectory(${GLFW_DIR} binary_dir EXCLUDE_FROM_ALL)
include_directories(${GLFW_DIR}/include)
include_directories(${GLFW_DIR}/deps)
target_link_libraries(${PROJECT_NAME}
    glfw
)

# Glad
add_library(GLAD STATIC lib/glad/src/glad.c)
include_directories(
    lib/glad/include
)
target_link_libraries(${PROJECT_NAME}
    GLAD
)

##
# Add a post build operation to copy shaders to the output folder (where the executable is created)
##
function(copy_folder_to_the_output_folder _FOLDERPATH)
    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/${_FOLDERPATH}
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/${_FOLDERPATH}
    )
endfunction()
copy_folder_to_the_output_folder("assets")