add_library(starkex src/order.cc)

target_include_directories(starkex
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/starkex/include>
)
target_link_libraries(starkex PUBLIC algebra PRIVATE crypto)

include(GNUInstallDirs)

install(TARGETS
        starkex
        EXPORT starkex_config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT starkex_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/starkex
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING PATTERN *.h *.inl
)

add_subdirectory(test)