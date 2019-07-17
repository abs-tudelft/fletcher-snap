
if(NOT "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitinfo.txt" IS_NEWER_THAN "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone  "https://github.com/abs-tudelft/cmake-modules.git" "cmake-modules-src"
    WORKING_DIRECTORY "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/abs-tudelft/cmake-modules.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout master --
  WORKING_DIRECTORY "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'master'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  submodule update --recursive --init 
  WORKING_DIRECTORY "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitinfo.txt"
    "/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/jhpeltenburg/workspace/fletcher-snap/runtime/build/_deps/cmake-modules-subbuild/cmake-modules-populate-prefix/src/cmake-modules-populate-stamp/cmake-modules-populate-gitclone-lastrun.txt'")
endif()

