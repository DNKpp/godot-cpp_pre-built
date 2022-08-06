cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

project(godot-cpp)

add_library(godot-cpp INTERFACE IMPORTED)

target_include_directories(
    godot-cpp
    INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/godot-headers"
    "${CMAKE_CURRENT_SOURCE_DIR}/gen/include"
)

file(
    GLOB LIBS
    "${CMAKE_CURRENT_SOURCE_DIR}/bin/*.lib"
    "${CMAKE_CURRENT_SOURCE_DIR}/bin/*.a"
)

target_link_directories(
    godot-cpp
    INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}/bin"
)

target_link_libraries(
    godot-cpp
    INTERFACE
    ${LIBS}
)
