
macro(include_once)
    string(REGEX REPLACE  "\\.|\\/" "_" __underlined_parent_list_name "${CMAKE_CURRENT_LIST_FILE}")
    if(__INCLUDE_${underlined_parent_list_name}_ONCE__)
        return()
    endif()
    set(__INCLUDE_${underlined_parent_list_name}_ONCE__ TRUE)
endmacro()
