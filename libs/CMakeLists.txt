add_subdirectory(algebra)
add_subdirectory(utils)
add_subdirectory(crypto)
add_subdirectory(starkex)

configure_file("starkware-config.cmake.in" "starkware-config.cmake")
install(FILE "starkware-config.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
)