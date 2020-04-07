# VULKAN,VULKANGL Shaders processing

execute_process(
  COMMAND
  "${PYTHON_EXECUTABLE}" 
  ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan/gen_glsl.py
  --glsl-path ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan/glsl
  --output-path ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan
  RESULT_VARIABLE error_code)

if(error_code)
  message(FATAL_ERROR "Failed to gen glsl.h and glsl.cpp with shaders sources for VULKAN backend")
endif()

if(NOT USE_VULKAN_SHADERC_RUNTIME)

message(STATUS "CMAKE_BINARY_DIR:${CMAKE_BINARY_DIR}")

execute_process(
    COMMAND
    "${PYTHON_EXECUTABLE}" 
    ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan/gen_spv.py
    --glsl-path ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan/glsl
    --output-path ${CMAKE_CURRENT_LIST_DIR}/../aten/src/ATen/native/vulkan
    --glslc-path=/home/ivankobzarev/android_ndk/android-ndk-r20/shader-tools/linux-x86_64/glslc
    --tmp-spv-path=${CMAKE_BINARY_DIR}
    RESULT_VARIABLE error_code)

  if(error_code)
    message(FATAL_ERROR "Failed to gen spv.h and spv.cpp with precompiled shaders for VULKAN backend")
  endif()

endif()
