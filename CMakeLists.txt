cmake_minimum_required(VERSION 3.25)

find_program(CCACHE ccache)
if(CCACHE)
  message("using ccache")
  set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
else()
  message("ccache not found cannot use")
endif()

project(altro_cpp)

list(APPEND CMAKE_PREFIX_PATH /absolute/path/to/drakelocation/build/install)
find_package(drake REQUIRED)

add_library(my_lib ...)
target_link_libraries(my_lib drake::drake)

add_subdirectory(test)