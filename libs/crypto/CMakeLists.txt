if(NOT WIN_32)
    list(APPEND OPTIONAL_LIBS pthread)
endif()

add_library(crypto
        src/elliptic_curve_constants.cc
        src/pedersen_hash.cc
        src/ecdsa.cc
)
target_include_directories(algebra
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/crypto/include>
)
target_link_libraries(crypto PUBLIC algebra gsl PRIVATE utils)

include(GNUInstallDirs)

install(TARGETS
        crypto
        EXPORT crypto_config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT crypto_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/crypto
        FILES_MATCHING
        PATTERN *.h
        PATTERN *.inl
)

add_subdirectory(ffi)
add_subdirectory(test)
