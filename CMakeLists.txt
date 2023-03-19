cmake_minimum_required(VERSION 3.24)

project(godot-cpp_pre-built)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include("get_cpm")

CPMAddPackage(
	NAME godot-cpp
	GIT_TAG ${${PROJECT_NAME}_GODOT_CPP_TAG}
	GITHUB_REPOSITORY godotengine/godot-cpp
)

include(GNUInstallDirs)

install(TARGETS godot-cpp)
install(DIRECTORY
	"${godot-cpp_SOURCE_DIR}/gdextension"
	"${godot-cpp_SOURCE_DIR}/include/godot_cpp"
	"${godot-cpp_BINARY_DIR}/gen/include/godot_cpp"
	TYPE INCLUDE
)
install(
	FILES "${PROJECT_SOURCE_DIR}/godot-cpp_template.cmake"
	DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/.."
	RENAME "CMakeLists.txt"
)
