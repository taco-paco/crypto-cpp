add_library(gsl INTERFACE)
target_include_directories(gsl
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/gsl/include>
)

install(TARGETS gsl
        EXPORT gsl_config
)

install(EXPORT gsl_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING
        PATTERN *.hpp
)
