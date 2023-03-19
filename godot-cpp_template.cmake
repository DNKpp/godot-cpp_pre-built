cmake_minimum_required(VERSION 3.24)

project(godot-cpp)

add_library(godot-cpp INTERFACE IMPORTED GLOBAL)

target_include_directories(
    godot-cpp
    INTERFACE
    "include"
    "include/gdextension"
)

file(
    GLOB LIBS
    "lib/*.lib"
    "lib/*.a"
)

target_link_directories(
    godot-cpp
    INTERFACE
    "lib"
)

target_link_libraries(
    godot-cpp
    INTERFACE
    ${LIBS}
)

target_compile_definitions(
    godot-cpp
    INTERFACE
	$<$<CONFIG:Debug>:
		DEBUG_ENABLED
		DEBUG_METHODS_ENABLED
	>
	$<$<CXX_COMPILER_ID:MSVC>:
		TYPED_METHOD_BIND
	>
)
