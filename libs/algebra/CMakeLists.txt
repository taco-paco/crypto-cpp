if(${need_boost})
    set(OPTIONAL_LIBS Boost::multiprecision)
endif()

if(NOT WIN_32)
    list(APPEND OPTIONAL_LIBS pthread)
endif()

add_library(algebra
        include/starkware/algebra/big_int.inl
        include/starkware/algebra/elliptic_curve.inl
        include/starkware/algebra/fraction_field_element.inl
        src/prime_field_element.cc
)

target_include_directories(algebra
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/crypto/include>
)
target_link_libraries(algebra PUBLIC utils gsl ${OPTIONAL_LIBS})

include(GNUInstallDirs)

install(TARGETS
        algebra
        EXPORT algebra_config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT algebra_config
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/starkware-${PROJECT_VERSION}
        NAMESPACE Starkware::
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/algebra
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING PATTERN *.h *.inl
)

add_subdirectory(test)