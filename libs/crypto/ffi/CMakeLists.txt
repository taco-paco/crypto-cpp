add_subdirectory(js)

add_library(crypto_c_exports
    SHARED
        src/pedersen_hash.cc
        src/ecdsa.cc
        src/utils.cc
)

target_link_libraries(crypto_c_exports PUBLIC gsl algebra PRIVATE crypto)
target_include_directories(crypto_c_exports
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/crypto/ffi/include>
)

install(TARGETS
        crypto_c_exports
        EXPORT crypto_c_exports_config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT crypto_c_exports_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/crypto/ffi
        FILES_MATCHING
        PATTERN *.h
        PATTERN *.inl
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/crypto_lib/crypto_lib.go
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/crypto_lib/ ${CMAKE_CURRENT_BINARY_DIR}/crypto_lib/
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/crypto_lib/crypto_lib.go
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/crypto_lib_test.go
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/crypto_lib_test.go ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/crypto_lib_test.go
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/ecdsa.h
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/include/starkware/crypto/ffi/ecdsa.h ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/include/starkware/crypto/ffi/ecdsa.h
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/pedersen_hash.h
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/include/starkware/crypto/ffi/pedersen_hash.h ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/include/starkware/crypto/ffi/pedersen_hash.h
)

add_custom_target(
  CopyGoFiles ALL
  DEPENDS
    ${CMAKE_CURRENT_BINARY_DIR}/crypto_lib/crypto_lib.go
    ${CMAKE_CURRENT_BINARY_DIR}/crypto_lib_test.go
    ${CMAKE_CURRENT_BINARY_DIR}/ecdsa.h
    ${CMAKE_CURRENT_BINARY_DIR}/pedersen_hash.h
)
