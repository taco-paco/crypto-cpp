add_executable(elliptic_curve_constants_test elliptic_curve_constants_test.cc)
target_link_libraries(elliptic_curve_constants_test gtest crypto gtest_main gmock ${OPTIONAL_LIBS})
add_test(elliptic_curve_constants_test elliptic_curve_constants_test)

add_executable(pedersen_hash_test pedersen_hash_test.cc)
target_link_libraries(pedersen_hash_test crypto gtest gtest_main ${OPTIONAL_LIBS})
add_test(pedersen_hash_test pedersen_hash_test)

add_executable(ecdsa_test ecdsa_test.cc)
target_link_libraries(ecdsa_test crypto gtest gtest_main ${OPTIONAL_LIBS})
add_test(ecdsa_test ecdsa_test)