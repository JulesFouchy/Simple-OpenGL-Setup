# CMakeUtils

Small utility functions for CMake.

Example usage:

```cmake
include("CMakeUtils/files_and_folders.cmake")
Cool__target_copy_folder(${PROJECT_NAME} "my_assets")
```

## files_and_folders

### target_copy_file(TARGET FILE OUT_DIR?)

Unlike the default CMake functions this one will re-copy the file whenever it changes.

It copies *FILE* to the directory where the executable of your *TARGET* will be created (you can optionally specify a third argument to override that destination folder).
*FILE* can be either an absolute or a relative path. If it is relative it will be relative to *${CMAKE_SOURCE_DIR}*.

```cmake
Cool__target_copy_file(${PROJECT_NAME} "my_config.json")
```

### target_copy_folder(TARGET FOLDER OUT_DIR?)

Unlike the default CMake functions this one will re-copy the files of the folder whenever they change or a file is added.

It copies *FOLDER* and all its files to the directory where the executable of your *TARGET* will be created (you can optionally specify a third argument to override that destination folder).
*FOLDER* can be either an absolute or a relative path. If it is relative it will be relative to *${CMAKE_SOURCE_DIR}*.

```cmake
Cool__target_copy_folder(${PROJECT_NAME} "my_assets")
```

### create_file_if_it_doesnt_exist(FILE)

```cmake
Cool__create_file_if_it_doesnt_exist(${CMAKE_SOURCE_DIR}/imgui.ini)
```

This can be useful in some cases to make sure a file exists before trying to copy it with `Cool__target_copy_file`, because that command will crash if the file doesn't exist.

## visual_studio_helpers

Functions that are specific to Visual Studio (NB: not Visual Studio Code).

### vs_hide_all_build_and_zero_check()

CMake for Visual Studio creates a few helper targets that you don't really want to see: you can hide them with this function.

```cmake
Cool__vs_hide_all_build_and_zero_check()
```

### vs_register_files(FILES)

Recreates your folder architecture inside the Visual Studio solution.

```cmake
file(GLOB_RECURSE MY_SOURCES CONFIGURE_DEPENDS src/*)
Cool__vs_register_files(${MY_SOURCES})
```