add_library(starkex src/order.cc)

target_include_directories(starkex PUBLIC include)
target_link_libraries(starkex PUBLIC algebra PRIVATE crypto)
