add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/ComFprimeConfig")

register_fprime_config(
    fprime-featherm4-freertos-reference-config
  CONFIGURATION_OVERRIDES
    "${CMAKE_CURRENT_LIST_DIR}/TlmChanImplCfg.hpp"
    "${CMAKE_CURRENT_LIST_DIR}/CommandDispatcherImplCfg.hpp"
  INTERFACE # No buildable files generated
)