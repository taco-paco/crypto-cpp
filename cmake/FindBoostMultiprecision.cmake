# Allow the user can specify the include directory manually:
if(NOT EXISTS "${BoostMultiprecision_INCLUDE_DIR}")
    message(FATAL_ERROR "specify BoostMultiprecision_INCLUDE_DIR")
    find_path(BoostMultiprecision_INCLUDE_DIR
            NAMES MyHeaderOnlyLibraryName/MyHeaderOnlyLibraryName.hpp
            DOC "MyHeaderOnlyLibraryName library header files"
    )
endif()

if(EXISTS "${BoostMultiprecision_INCLUDE_DIR}")
    add_library(boost_multiprecision INTERFACE IMPORTED)
    add_library(Boost::multiprecision ALIAS boost_multiprecision)
    target_include_directories(boost_multiprecision INTERFACE ${BoostMultiprecision_INCLUDE_DIR})
else()
#    include(ExternalProject)
#    ExternalProject_Add(MyHeaderOnlyLibraryName
#            URL https://github.com/boostorg/multiprecision/archive/refs/tags/Boost_1_83_0.tar.gz
#            TIMEOUT 5
#            CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
#            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
#            BUILD_COMMAND "" # dito
#    )
#
#    # Specify include dir:
#    ExternalProject_Get_Property(MyHeaderOnlyLibraryName source_dir)
#    set(MyHeaderOnlyLibraryName_INCLUDE_DIRS ${source_dir}/include)
endif()

#if(EXISTS "${MyHeaderOnlyLibraryName_INCLUDE_DIR}")
#    set(MyHeaderOnlyLibraryName_FOUND 1)
#else()
#    set(MyHeaderOnlyLibraryName_FOUND 0)
#endif()