# cmake_minimum_required(VERSION 3.16)
# project(Converter_txt_to_xlsx VERSION 1.0.0 LANGUAGES CXX)

# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_AUTOMOC ON)

# # Поиск Qt6
# find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2)

# # Исполняемый файл
# add_executable(converter_txt_to_xlsx
#     main.cpp
#     converter.cpp
# )

# # Явно указываем заголовочные файлы
# target_sources(converter_txt_to_xlsx PRIVATE
#     converter.h
# )

# # Создаем ресурсный файл для QML
# qt_add_resources(converter_txt_to_xlsx "qml"
#     PREFIX "/"
#     FILES MainWindow.qml
# )

# # Включаем заголовочные файлы QXlsx
# target_include_directories(converter_txt_to_xlsx PRIVATE
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/header
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/QXlsx/header  # Также пробуем этот путь
# )

# # Добавляем исходные файлы QXlsx напрямую
# target_sources(converter_txt_to_xlsx PRIVATE
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxdocument.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxformat.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxworksheet.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxcell.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxcellreference.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxcellrange.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxworkbook.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxutility.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxstyles.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxsharedstrings.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxrelationships.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxzipwriter.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxzipreader.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxabstractsheet.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxabstractooxmlfile.cpp
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/source/xlsxcontenttypes.cpp
# )

# # Подключаем библиотеки
# target_link_libraries(converter_txt_to_xlsx PRIVATE
#     Qt6::Core
#     Qt6::Quick
#     Qt6::QuickControls2
# )

# # Для Windows: отключаем консольное окно
# if(WIN32)
#     set_target_properties(converter_txt_to_xlsx PROPERTIES
#         WIN32_EXECUTABLE TRUE
#     )
# endif()

# # Указываем выходную директорию
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

# # УДАЛЕНЫ ПРОБЛЕМНЫЕ МАКРОСЫ:
# # target_compile_definitions(converter_txt_to_xlsx PRIVATE
# #     QT_NO_CAST_FROM_ASCII
# #     QT_NO_CAST_TO_ASCII
# # )


















# cmake_minimum_required(VERSION 3.16)
# project(Converter_txt_to_xlsx VERSION 1.0.0 LANGUAGES CXX)

# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_AUTOMOC ON)

# # Поиск Qt6
# find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2)

# # Подключаем QXlsx из папки QXlsx в корне проекта
# add_subdirectory(QXlsx)

# # Исполняемый файл
# add_executable(converter_txt_to_xlsx
#     main.cpp
#     converter.cpp
# )

# # Явно указываем заголовочные файлы
# target_sources(converter_txt_to_xlsx PRIVATE
#     converter.h
# )

# # Создаем ресурсный файл для QML
# qt_add_resources(converter_txt_to_xlsx "qml"
#     PREFIX "/"
#     FILES MainWindow.qml
# )

# # Подключаем библиотеки
# target_link_libraries(converter_txt_to_xlsx PRIVATE
#     Qt6::Core
#     Qt6::Quick
#     Qt6::QuickControls2
#     QtXlsx::Core
# )

# # Включаем заголовочные файлы QXlsx
# target_include_directories(converter_txt_to_xlsx PRIVATE
#     ${CMAKE_CURRENT_SOURCE_DIR}/QXlsx/header
# )

# # Для Windows: отключаем консольное окно
# if(WIN32)
#     set_target_properties(converter_txt_to_xlsx PROPERTIES
#         WIN32_EXECUTABLE TRUE
#     )
# endif()

# # Указываем выходную директорию
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})



















cmake_minimum_required(VERSION 3.16)
project(Converter_txt_to_xlsx VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

# Поиск Qt6
find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2)

# Исполняемый файл
add_executable(converter_txt_to_xlsx
    main.cpp
    converter.cpp
)

# Явно указываем заголовочные файлы
target_sources(converter_txt_to_xlsx PRIVATE
    converter.h
)

# Создаем ресурсный файл для QML
qt_add_resources(converter_txt_to_xlsx "qml"
    PREFIX "/"
    FILES MainWindow.qml
)

# Подключаем библиотеки
target_link_libraries(converter_txt_to_xlsx PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
)

# Для Windows: отключаем консольное окно
if(WIN32)
    set_target_properties(converter_txt_to_xlsx PROPERTIES
        WIN32_EXECUTABLE TRUE
    )
endif()

# Указываем выходную директорию
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
