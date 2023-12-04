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

add_subdirectory(ffi)
add_subdirectory(test)
