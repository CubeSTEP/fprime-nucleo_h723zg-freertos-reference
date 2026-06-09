####
# This sets up the build system for the 'fprime-nucleo_h723zg-freertos-reference' project, including
# components and deployments from project.cmake. In addition, it imports the core F Prime components.
####

cmake_minimum_required(VERSION 3.13)
project(fprime-nucleo_h723zg-freertos-reference C CXX)        

# Disable GTEST install for Arduino Target, Conflicts with fprime_arudino_libraries
set(INSTALL_GTEST OFF CACHE BOOL "Disable installing embedded GoogleTest." FORCE)

###
# F' Core Setup
# This includes all of the F prime core components, and imports the make-system.
###
include("${CMAKE_CURRENT_LIST_DIR}/lib/fprime/cmake/FPrime.cmake")

# NOTE: register custom targets between these two lines
fprime_setup_included_code()

# On STM32H7, fprime-arduino modules may be registered with a
# `fprime-arduino_` prefix. Provide compatibility aliases expected by
# this deployment topology and override files.
if (TARGET fprime-arduino_Arduino_Drv_StreamDriver AND NOT TARGET Arduino_Drv_StreamDriver)
	add_library(Arduino_Drv_StreamDriver INTERFACE)
	target_link_libraries(Arduino_Drv_StreamDriver INTERFACE fprime-arduino_Arduino_Drv_StreamDriver)
endif()
if (TARGET fprime-arduino_Arduino_Drv_HardwareRateDriver AND NOT TARGET Arduino_Drv_HardwareRateDriver)
	add_library(Arduino_Drv_HardwareRateDriver INTERFACE)
	target_link_libraries(Arduino_Drv_HardwareRateDriver INTERFACE fprime-arduino_Arduino_Drv_HardwareRateDriver)
endif()
if (TARGET fprime-arduino_Arduino_Svc_ArduinoTime AND NOT TARGET Arduino_Svc_ArduinoTime)
	add_library(Arduino_Svc_ArduinoTime INTERFACE)
	target_link_libraries(Arduino_Svc_ArduinoTime INTERFACE fprime-arduino_Arduino_Svc_ArduinoTime)
endif()


# This includes project-wide objects
include("${CMAKE_CURRENT_LIST_DIR}/project.cmake")

# FpySequencer is not used by this deployment and currently trips a
# framework/toolchain compatibility issue under the FreeRTOS cross build.
set_target_properties(Svc_FpySequencer PROPERTIES EXCLUDE_FROM_ALL TRUE)
