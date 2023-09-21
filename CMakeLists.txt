cmake_minimum_required(VERSION 3.25)

find_program(CCACHE ccache)
if(CCACHE)
  message("using ccache")
  set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
else()
  message("ccache not found cannot use")
endif()

project(altro_cpp)

add_subdirectory(test)