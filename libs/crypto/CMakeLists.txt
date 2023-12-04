if(NOT WIN_32)
    list(APPEND OPTIONAL_LIBS pthread)
endif()

add_library(crypto
        src/elliptic_curve_constants.cc
        src/pedersen_hash.cc
        src/ecdsa.cc
)
target_include_directories(crypto PUBLIC include)
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

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/crypto
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING PATTERN *.h *.inl
)

add_subdirectory(ffi)
add_subdirectory(test)
