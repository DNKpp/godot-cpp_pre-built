cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

project(godot-cpp_pre-built)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include("get_cpm")

set(godot-cpp_TARGET_DIR "${PROJECT_SOURCE_DIR}/godot-cpp" CACHE STRING "")

CPMAddPackage(
	NAME godot-cpp
	GIT_TAG ${${PROJECT_NAME}_GODOT_CPP_TAG}
	GITHUB_REPOSITORY godotengine/godot-cpp
)

add_custom_target(
	${PROJECT_NAME}
	ALL
	DEPENDS "$<TARGET_FILE:godot-cpp>"
    VERBATIM
)

message(STATUS "Bin: ${godot-cpp_BINARY_DIR}")

add_custom_command(
    TARGET ${PROJECT_NAME}
	POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "copy godot-cpp artifact files to \"${godot-cpp_TARGET_DIR}\""
	# just a workaround, because godot-cpp switched its output dir
	COMMAND ${CMAKE_COMMAND} -E make_directory "${godot-cpp_BINARY_DIR}/bin" "${godot-cpp_BINARY_DIR}/gen"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_BINARY_DIR}/bin" "${godot-cpp_SOURCE_DIR}/bin"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_BINARY_DIR}/gen" "${godot-cpp_SOURCE_DIR}/gen"

	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_SOURCE_DIR}/bin" "${godot-cpp_TARGET_DIR}/bin"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_BINARY_DIR}/gen" "${godot-cpp_TARGET_DIR}/gen"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_SOURCE_DIR}/godot-headers" "${godot-cpp_TARGET_DIR}/godot-headers"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${godot-cpp_SOURCE_DIR}/include" "${godot-cpp_TARGET_DIR}/include"
	COMMAND ${CMAKE_COMMAND} -E copy "${PROJECT_SOURCE_DIR}/godot-cpp_template.cmake" "${godot-cpp_TARGET_DIR}/CMakeLists.txt"
	DEPENDS "$<TARGET_FILE:godot-cpp>"
    VERBATIM
	USES_TERMINAL
)
