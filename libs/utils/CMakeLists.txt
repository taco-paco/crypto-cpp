add_library(utils INTERFACE)
target_include_directories(utils
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/utils/include>
)

include(GNUInstallDirs)

install(TARGETS
        utils
        EXPORT utils_config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT utils_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/utils
        FILES_MATCHING
        PATTERN *.h
        PATTERN *.inl
)

add_subdirectory(test)