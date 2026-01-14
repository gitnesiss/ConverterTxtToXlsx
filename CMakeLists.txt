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
