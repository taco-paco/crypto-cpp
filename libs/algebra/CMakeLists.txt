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

target_include_directories(algebra PUBLIC include)
target_link_libraries(algebra PUBLIC utils gsl)
# TODO: remove?
#target_link_libraries(algebra PUBLIC ${OPTIONAL_LIBS})

add_subdirectory(test)