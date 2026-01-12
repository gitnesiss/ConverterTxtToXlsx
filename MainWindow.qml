// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import Qt.labs.platform 1.1 as Platform
// import ConverterTxtToXlsx 1.0

// ApplicationWindow {
//     id: window
//     width: 800
//     height: 500  // Увеличили высоту для переключателя
//     minimumWidth: 600
//     minimumHeight: 450
//     title: "Конвертер txt в Excel v1.0"
//     visible: true
//     color: "#1e1e1e"

//     property color buttonNormal: "#404040"
//     property color buttonHover: "#505050"
//     property color buttonPressed: "#303030"
//     property color buttonDisabled: "#2a2a2a"
//     property color buttonText: "#ffffff"
//     property color buttonTextDisabled: "#888888"
//     property color accentSuccess: "#4CAF50"
//     property color accentDanger: "#f44336"
//     property color accentWarning: "#FF9800"
//     property color switchBackground: "#444"
//     property color switchHandle: "#2196F3"
//     property color switchText: "#fff"

//     Converter {
//         id: converter
//     }

//     ColumnLayout {
//         anchors.fill: parent
//         anchors.margins: 20
//         spacing: 15

//         // === ЗАГОЛОВОК ===
//         Item {
//             Layout.fillWidth: true
//             Layout.preferredHeight: 60

//             Column {
//                 anchors.centerIn: parent
//                 spacing: 5
//                 width: Math.min(parent.width - 40, 600)

//                 Text {
//                     text: "Конвертер txt в Excel"
//                     color: "white"
//                     font.bold: true
//                     font.pixelSize: 24
//                     anchors.horizontalCenter: parent.horizontalCenter
//                 }

//                 Text {
//                     text: "Преобразователь текстовых файлов программы MonitorHead в формат Excel"
//                     color: "#aaa"
//                     font.pixelSize: 12
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     horizontalAlignment: Text.AlignHCenter
//                     width: Math.min(parent.width, 500)
//                 }
//             }
//         }

//         // === БЛОК ВЫБОРА ФАЙЛА ===
//         Rectangle {
//             Layout.fillWidth: true
//             Layout.preferredHeight: 80
//             color: "#2d2d2d"
//             radius: 8
//             border.color: "#444"
//             border.width: 1

//             ColumnLayout {
//                 anchors.fill: parent
//                 anchors.margins: 10
//                 spacing: 5

//                 Text {
//                     text: "Исходный файл (.txt)"
//                     color: "#4CAF50"
//                     font.pixelSize: 14
//                     font.bold: true
//                     Layout.alignment: Qt.AlignLeft
//                 }

//                 RowLayout {
//                     spacing: 10
//                     Layout.fillWidth: true

//                     // Поле для пути к файлу
//                     Rectangle {
//                         Layout.fillWidth: true
//                         Layout.preferredHeight: 30
//                         color: "#3c3c3c"
//                         radius: 4
//                         border.color: "#555"
//                         border.width: 1

//                         TextInput {
//                             id: inputFileField
//                             anchors.fill: parent
//                             anchors.margins: 5
//                             color: "white"
//                             font.pixelSize: 12
//                             readOnly: true
//                             selectByMouse: true
//                             verticalAlignment: Text.AlignVCenter
//                             text: ""
//                             clip: true
//                         }

//                         // Плейсхолдер
//                         Text {
//                             anchors.fill: parent
//                             anchors.margins: 5
//                             color: "#888"
//                             font.pixelSize: 12
//                             text: "Выберите файл .txt"
//                             verticalAlignment: Text.AlignVCenter
//                             visible: !inputFileField.text
//                         }
//                     }

//                     // Кнопка выбора файла
//                     Rectangle {
//                         id: fileBrowseButton
//                         Layout.preferredWidth: 80
//                         Layout.preferredHeight: 30
//                         radius: 4
//                         color: getButtonColor(fileBrowseButtonMouseArea, true)

//                         Text {
//                             anchors.centerIn: parent
//                             text: "📁 Обзор"
//                             color: "white"
//                             font.pixelSize: 12
//                             font.bold: true
//                         }

//                         MouseArea {
//                             id: fileBrowseButtonMouseArea
//                             anchors.fill: parent
//                             hoverEnabled: true
//                             cursorShape: Qt.PointingHandCursor
//                             onClicked: fileDialog.open()
//                         }
//                     }
//                 }
//             }
//         }

//         // === ПЕРЕКЛЮЧАТЕЛЬ ФОРМАТА ===
//         Rectangle {
//             Layout.fillWidth: true
//             Layout.preferredHeight: 60
//             color: "#2d2d2d"
//             radius: 8
//             border.color: "#444"
//             border.width: 1

//             RowLayout {
//                 anchors.fill: parent
//                 anchors.margins: 10
//                 spacing: 15

//                 Text {
//                     text: "Формат выходного файла:"
//                     color: "#aaa"
//                     font.pixelSize: 14
//                     Layout.alignment: Qt.AlignVCenter
//                 }

//                 // Переключатель формата
//                 Rectangle {
//                     Layout.preferredWidth: 200
//                     Layout.preferredHeight: 40
//                     color: switchBackground
//                     radius: 20

//                     Row {
//                         anchors.fill: parent
//                         anchors.margins: 2

//                         // Левая часть - XLSX
//                         Rectangle {
//                             id: xlsxOption
//                             width: parent.width / 2
//                             height: parent.height
//                             color: converter.formatIsXlsx ? switchHandle : "transparent"
//                             radius: 18

//                             Text {
//                                 anchors.centerIn: parent
//                                 text: "XLSX"
//                                 color: switchText
//                                 font.pixelSize: 12
//                                 font.bold: true
//                             }

//                             MouseArea {
//                                 anchors.fill: parent
//                                 cursorShape: Qt.PointingHandCursor
//                                 onClicked: {
//                                     if (!converter.formatIsXlsx) {
//                                         converter.setFormatIsXlsx(true);
//                                         updateFileNameExtension();
//                                     }
//                                 }
//                             }
//                         }

//                         // Правая часть - CSV
//                         Rectangle {
//                             id: csvOption
//                             width: parent.width / 2
//                             height: parent.height
//                             color: !converter.formatIsXlsx ? switchHandle : "transparent"
//                             radius: 18

//                             Text {
//                                 anchors.centerIn: parent
//                                 text: "CSV"
//                                 color: switchText
//                                 font.pixelSize: 12
//                                 font.bold: true
//                             }

//                             MouseArea {
//                                 anchors.fill: parent
//                                 cursorShape: Qt.PointingHandCursor
//                                 onClicked: {
//                                     if (converter.formatIsXlsx) {
//                                         converter.setFormatIsXlsx(false);
//                                         updateFileNameExtension();
//                                     }
//                                 }
//                             }
//                         }
//                     }

//                     // Анимация переключения
//                     Behavior on color {
//                         ColorAnimation { duration: 200 }
//                     }
//                 }

//                 // Информация о форматах
//                 Text {
//                     text: converter.formatIsXlsx ?
//                           "✓ Нативный формат Excel" :
//                           "✓ Универсальный текстовый формат"
//                     color: "#4CAF50"
//                     font.pixelSize: 11
//                     Layout.alignment: Qt.AlignVCenter
//                 }
//             }
//         }

//         // === БЛОК НАСТРОЕК ВЫХОДНОГО ФАЙЛА ===
//         Rectangle {
//             Layout.fillWidth: true
//             Layout.preferredHeight: 110
//             color: "#2d2d2d"
//             radius: 8
//             border.color: "#444"
//             border.width: 1

//             ColumnLayout {
//                 anchors.fill: parent
//                 anchors.margins: 10
//                 spacing: 5

//                 Text {
//                     text: converter.formatIsXlsx ? "Выходной файл (.xlsx)" : "Выходной файл (.csv)"
//                     color: "#4CAF50"
//                     font.pixelSize: 14
//                     font.bold: true
//                     Layout.alignment: Qt.AlignLeft
//                 }

//                 // Путь сохранения
//                 RowLayout {
//                     spacing: 10
//                     Layout.fillWidth: true

//                     Text {
//                         text: "Путь сохранения:"
//                         color: "#aaa"
//                         font.pixelSize: 12
//                         Layout.preferredWidth: 100
//                     }

//                     Rectangle {
//                         Layout.fillWidth: true
//                         Layout.preferredHeight: 30
//                         color: "#3c3c3c"
//                         radius: 4
//                         border.color: "#555"
//                         border.width: 1

//                         TextInput {
//                             id: outputPathField
//                             anchors.fill: parent
//                             anchors.margins: 5
//                             color: "white"
//                             font.pixelSize: 12
//                             verticalAlignment: Text.AlignVCenter
//                             selectByMouse: true
//                         }
//                     }

//                     // Кнопка выбора папки
//                     Rectangle {
//                         id: folderBrowseButton
//                         Layout.preferredWidth: 80
//                         Layout.preferredHeight: 30
//                         radius: 4
//                         color: getButtonColor(folderBrowseButtonMouseArea, true)

//                         Text {
//                             anchors.centerIn: parent
//                             text: "📁 Обзор"
//                             color: "white"
//                             font.pixelSize: 12
//                             font.bold: true
//                         }

//                         MouseArea {
//                             id: folderBrowseButtonMouseArea
//                             anchors.fill: parent
//                             hoverEnabled: true
//                             cursorShape: Qt.PointingHandCursor
//                             onClicked: folderDialog.open()
//                         }
//                     }
//                 }

//                 // Имя файла
//                 RowLayout {
//                     spacing: 10
//                     Layout.fillWidth: true

//                     Text {
//                         text: "Имя файла:"
//                         color: "#aaa"
//                         font.pixelSize: 12
//                         Layout.preferredWidth: 100
//                     }

//                     Rectangle {
//                         Layout.fillWidth: true
//                         Layout.preferredHeight: 30
//                         color: "#3c3c3c"
//                         radius: 4
//                         border.color: "#555"
//                         border.width: 1

//                         TextInput {
//                             id: outputNameField
//                             anchors.fill: parent
//                             anchors.margins: 5
//                             color: "white"
//                             font.pixelSize: 12
//                             verticalAlignment: Text.AlignVCenter
//                             text: "результат.csv"
//                             selectByMouse: true
//                         }
//                     }
//                 }
//             }
//         }

//         // === КНОПКА ПРЕОБРАЗОВАНИЯ ===
//         Rectangle {
//             id: convertButton
//             Layout.preferredWidth: 220
//             Layout.preferredHeight: 50
//             Layout.alignment: Qt.AlignHCenter
//             radius: 6
//             color: getConvertButtonColor(convertButtonMouseArea, convertButton.enabled)
//             enabled: inputFileField.text && outputPathField.text && outputNameField.text

//             Row {
//                 anchors.centerIn: parent
//                 spacing: 10

//                 Image {
//                     source: converter.formatIsXlsx ? "qrc:/xlsx-icon.png" : "qrc:/csv-icon.png"
//                     width: 24
//                     height: 24
//                     sourceSize.width: 24
//                     sourceSize.height: 24
//                 }

//                 Text {
//                     text: "ПРЕОБРАЗОВАТЬ В " + (converter.formatIsXlsx ? "XLSX" : "CSV")
//                     color: convertButton.enabled ? "white" : "#888"
//                     font.pixelSize: 14
//                     font.bold: true
//                     verticalAlignment: Text.AlignVCenter
//                 }
//             }

//             MouseArea {
//                 id: convertButtonMouseArea
//                 anchors.fill: parent
//                 hoverEnabled: true
//                 cursorShape: convertButton.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
//                 onClicked: {
//                     if (!convertButton.enabled) {
//                         statusLabel.text = "✗ Заполните все поля!"
//                         statusLabel.color = "#f44336"
//                         return
//                     }

//                     var inputPath = inputFileField.text
//                     var outputDir = outputPathField.text
//                     var fileName = outputNameField.text

//                     if (!inputPath || !outputDir || !fileName) {
//                         statusLabel.text = "✗ Заполните все поля!"
//                         statusLabel.color = "#f44336"
//                         return
//                     }

//                     // Проверяем правильное расширение
//                     var hasCorrectExtension = false;
//                     if (converter.formatIsXlsx) {
//                         hasCorrectExtension = fileName.toLowerCase().endsWith(".xlsx");
//                         if (!hasCorrectExtension) {
//                             fileName = fileName.replace(/\.[^/.]+$/, "") + ".xlsx";
//                             outputNameField.text = fileName;
//                         }
//                     } else {
//                         hasCorrectExtension = fileName.toLowerCase().endsWith(".csv");
//                         if (!hasCorrectExtension) {
//                             fileName = fileName.replace(/\.[^/.]+$/, "") + ".csv";
//                             outputNameField.text = fileName;
//                         }
//                     }

//                     var outputPath = outputDir + "/" + fileName

//                     // Показываем индикатор загрузки
//                     busyIndicator.running = true
//                     convertButton.enabled = false
//                     statusLabel.text = "Преобразование файла..."
//                     statusLabel.color = "#2196f3"

//                     // Запускаем преобразование
//                     var format = converter.formatIsXlsx ? Converter.FormatXLSX : Converter.FormatCSV
//                     var success = converter.convertTxtToFileQML(inputPath, outputPath, format)

//                     busyIndicator.running = false
//                     convertButton.enabled = inputFileField.text && outputPathField.text && outputNameField.text

//                     if (success) {
//                         statusLabel.text = "✓ Файл успешно преобразован!"
//                         statusLabel.color = "#4CAF50"
//                         resultDialog.title = "Успешно"
//                         resultLabel.text = "Файл успешно преобразован:\n" + outputPath +
//                                          "\n\n" + converter.getLastError()
//                         resultDialog.open()
//                     } else {
//                         statusLabel.text = "✗ Ошибка при преобразовании"
//                         statusLabel.color = "#f44336"
//                         resultDialog.title = "Ошибка"
//                         resultLabel.text = "Ошибка преобразования:\n" + converter.getLastError()
//                         resultDialog.open()
//                     }
//                 }
//             }
//         }

//         // === СТАТУС И ПРОГРЕСС ===
//         RowLayout {
//             Layout.alignment: Qt.AlignHCenter
//             spacing: 10

//             BusyIndicator {
//                 id: busyIndicator
//                 running: false
//                 visible: running
//                 Layout.preferredWidth: 20
//                 Layout.preferredHeight: 20
//             }

//             Text {
//                 id: statusLabel
//                 text: "Готов к работе"
//                 color: "#aaa"
//                 font.pixelSize: 14
//             }
//         }

//         // === ИНФОРМАЦИЯ О ПРОГРАММЕ ===
//         Text {
//             Layout.alignment: Qt.AlignHCenter
//             text: "© 2026 Конвертер txt в Excel v1.0"
//             color: "#666"
//             font.pixelSize: 10
//         }
//     }

//     // === ДИАЛОГИ ВЫБОРА ФАЙЛОВ ===
//     Platform.FileDialog {
//         id: fileDialog
//         title: "Выберите текстовый файл"
//         nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]

//         onAccepted: {
//             var fileUrl = fileDialog.file.toString()
//             var filePath = urlToLocalPath(fileUrl)

//             inputFileField.text = filePath

//             // Автоматически заполняем выходные поля
//             var lastSlash = Math.max(filePath.lastIndexOf('\\'), filePath.lastIndexOf('/'))
//             if (lastSlash > 0) {
//                 var path = filePath.substring(0, lastSlash)
//                 var fullFileName = filePath.substring(lastSlash + 1)
//                 var fileName = fullFileName

//                 // Убираем расширение .txt если есть
//                 if (fileName.toLowerCase().endsWith(".txt")) {
//                     fileName = fileName.substring(0, fileName.length - 4)
//                 }

//                 outputPathField.text = path
//                 // Добавляем правильное расширение
//                 if (converter.formatIsXlsx) {
//                     if (!fileName.toLowerCase().endsWith(".xlsx")) {
//                         fileName = fileName + ".xlsx"
//                     }
//                 } else {
//                     if (!fileName.toLowerCase().endsWith(".csv")) {
//                         fileName = fileName + ".csv"
//                     }
//                 }
//                 outputNameField.text = fileName

//                 statusLabel.text = "Файл выбран: " + fullFileName
//                 statusLabel.color = "#aaa"
//             }
//         }
//     }

//     Platform.FolderDialog {
//         id: folderDialog
//         title: "Выберите папку для сохранения"

//         onAccepted: {
//             var folderUrl = folderDialog.folder.toString()
//             var folderPath = urlToLocalPath(folderUrl)

//             outputPathField.text = folderPath
//             statusLabel.text = "Папка для сохранения выбрана"
//             statusLabel.color = "#aaa"
//         }
//     }

//     // === ДИАЛОГ РЕЗУЛЬТАТА ===
//     Popup {
//         id: resultDialog
//         width: 550
//         height: 220
//         modal: true
//         focus: true
//         anchors.centerIn: parent
//         closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

//         background: Rectangle {
//             color: "#2d2d2d"
//             radius: 8
//             border.color: "#444"
//             border.width: 2

//             // Заголовок диалога
//             Rectangle {
//                 width: parent.width
//                 height: 40
//                 color: "#3d3d3d"
//                 radius: 8

//                 Text {
//                     anchors.centerIn: parent
//                     text: resultDialog.title
//                     color: resultDialog.title === "Успешно" ? "#4CAF50" : "#f44336"
//                     font.pixelSize: 16
//                     font.bold: true
//                 }

//                 // Кнопка закрытия
//                 Rectangle {
//                     width: 30
//                     height: 30
//                     radius: 15
//                     color: closeResultMouseArea.pressed ? "#3a3a3a" : (closeResultMouseArea.containsMouse ? "#2a2a2a" : "transparent")
//                     anchors {
//                         right: parent.right
//                         top: parent.top
//                         margins: 5
//                     }

//                     Text {
//                         anchors.centerIn: parent
//                         text: "✕"
//                         color: "white"
//                         font.pixelSize: 14
//                         font.bold: true
//                     }

//                     MouseArea {
//                         id: closeResultMouseArea
//                         anchors.fill: parent
//                         hoverEnabled: true
//                         cursorShape: Qt.PointingHandCursor
//                         onClicked: resultDialog.close()
//                     }
//                 }
//             }
//         }

//         contentItem: ColumnLayout {
//             anchors.fill: parent
//             anchors.margins: 2
//             spacing: 15

//             Text {
//                 id: resultLabel
//                 Layout.fillWidth: true
//                 Layout.fillHeight: true
//                 color: "white"
//                 font.pixelSize: 14
//                 wrapMode: Text.Wrap
//                 Layout.topMargin: 45
//                 Layout.leftMargin: 15
//                 Layout.rightMargin: 15
//             }

//             // Кнопка OK
//             Rectangle {
//                 Layout.preferredWidth: 100
//                 Layout.preferredHeight: 35
//                 Layout.alignment: Qt.AlignHCenter
//                 Layout.bottomMargin: 10
//                 radius: 4
//                 color: okResultMouseArea.pressed ? "#45a049" : (okResultMouseArea.containsMouse ? "#5cbf62" : "#4CAF50")

//                 Text {
//                     anchors.centerIn: parent
//                     text: "OK"
//                     color: "white"
//                     font.pixelSize: 14
//                     font.bold: true
//                 }

//                 MouseArea {
//                     id: okResultMouseArea
//                     anchors.fill: parent
//                     hoverEnabled: true
//                     cursorShape: Qt.PointingHandCursor
//                     onClicked: resultDialog.close()
//                 }
//             }
//         }
//     }

//     // === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
//     function getButtonColor(mouseArea, enabled) {
//         if (!enabled) return buttonDisabled
//         if (mouseArea.pressed) return buttonPressed
//         if (mouseArea.containsMouse) return buttonHover
//         return buttonNormal
//     }

//     function getConvertButtonColor(mouseArea, enabled) {
//         if (!enabled) return "#555"
//         if (mouseArea.pressed) return converter.formatIsXlsx ? "#1a5276" : "#3a5c42"
//         if (mouseArea.containsMouse) return converter.formatIsXlsx ? "#2e86c1" : "#5cbf62"
//         return converter.formatIsXlsx ? "#3498db" : "#4CAF50"
//     }

//     function urlToLocalPath(url) {
//         var filePath
//         if (url.startsWith("file:///")) {
//             // Windows
//             filePath = url.substring(8)
//             filePath = filePath.replace(/\//g, "\\")
//         } else if (url.startsWith("file://")) {
//             // Linux/Mac
//             filePath = url.substring(7)
//         } else {
//             filePath = url
//         }
//         return filePath
//     }

//     function updateFileNameExtension() {
//         var fileName = outputNameField.text
//         if (!fileName) return

//         // Убираем старое расширение
//         var baseName = fileName.replace(/\.[^/.]+$/, "")

//         // Добавляем новое расширение
//         if (converter.formatIsXlsx) {
//             outputNameField.text = baseName + ".xlsx"
//         } else {
//             outputNameField.text = baseName + ".csv"
//         }
//     }

//     // При изменении переключателя обновляем расширение файла
//     Connections {
//         target: converter
//         function onFormatChanged() {
//             updateFileNameExtension()
//         }
//     }
// }



















import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1 as Platform
import ConverterTxtToXlsx 1.0

ApplicationWindow {
    id: window
    width: 800
    height: 450
    minimumWidth: 600
    minimumHeight: 400
    title: "Конвертер txt-to-csv v1.0"
    visible: true
    color: "#1e1e1e"  // Основной темный фон

    // Цветовая схема как в Main.qml
    property color buttonNormal: "#404040"
    property color buttonHover: "#505050"
    property color buttonPressed: "#303030"
    property color buttonDisabled: "#2a2a2a"
    property color buttonText: "#ffffff"
    property color buttonTextDisabled: "#888888"
    property color accentSuccess: "#4CAF50"
    property color accentDanger: "#f44336"
    property color accentWarning: "#FF9800"

    Converter {
        id: converter
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // === ЗАГОЛОВОК ===
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 60

            Column {
                anchors.centerIn: parent
                spacing: 5
                width: Math.min(parent.width - 40, 600) // Ограничиваем ширину

                Text {
                    text: "Конвертер txt-to-csv"
                    color: "white"
                    font.bold: true
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Преобразователь текстовых файлов программы MonitorHead в формат для Excel"
                    color: "#aaa"
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    width: Math.min(parent.width, 500)
                    // wrapMode: Text.NoWrap  // Запретил перенос строк
                    // elide: Text.ElideNone  // Запретил сокращение текста
                    // wrapMode: Text.Wrap
                }
            }
        }

        // === БЛОК ВЫБОРА ФАЙЛА ===
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#2d2d2d"
            radius: 8
            border.color: "#444"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                Text {
                    text: "Исходный файл (.txt)"
                    color: "#4CAF50"
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    // Поле для пути к файлу
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        color: "#3c3c3c"
                        radius: 4
                        border.color: "#555"
                        border.width: 1

                        TextInput {
                            id: inputFileField
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "white"
                            font.pixelSize: 12
                            readOnly: true
                            selectByMouse: true
                            verticalAlignment: Text.AlignVCenter
                            text: ""
                            clip: true
                        }

                        // Плейсхолдер
                        Text {
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "#888"
                            font.pixelSize: 12
                            text: "Выберите файл .txt"
                            verticalAlignment: Text.AlignVCenter
                            visible: !inputFileField.text
                        }
                    }

                    // Кнопка выбора файла
                    Rectangle {
                        id: fileBrowseButton
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 30
                        radius: 4
                        color: getButtonColor(fileBrowseButtonMouseArea, true)

                        Text {
                            anchors.centerIn: parent
                            text: "📁 Обзор"
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            id: fileBrowseButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: fileDialog.open()
                        }
                    }
                }
            }
        }

        // === БЛОК НАСТРОЕК ВЫХОДНОГО ФАЙЛА ===
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 110
            color: "#2d2d2d"
            radius: 8
            border.color: "#444"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                Text {
                    text: "Выходной файл (.csv)"
                    color: "#4CAF50"
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                // Путь сохранения
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Путь сохранения:"
                        color: "#aaa"
                        font.pixelSize: 12
                        Layout.preferredWidth: 100
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        color: "#3c3c3c"
                        radius: 4
                        border.color: "#555"
                        border.width: 1

                        TextInput {
                            id: outputPathField
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "white"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            selectByMouse: true
                        }
                    }

                    // Кнопка выбора папки
                    Rectangle {
                        id: folderBrowseButton
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 30
                        radius: 4
                        color: getButtonColor(folderBrowseButtonMouseArea, true)

                        Text {
                            anchors.centerIn: parent
                            text: "📁 Обзор"
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            id: folderBrowseButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: folderDialog.open()
                        }
                    }
                }

                // Имя файла
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Имя файла:"
                        color: "#aaa"
                        font.pixelSize: 12
                        Layout.preferredWidth: 100
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        color: "#3c3c3c"
                        radius: 4
                        border.color: "#555"
                        border.width: 1

                        TextInput {
                            id: outputNameField
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "white"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            text: "результат.csv"
                            selectByMouse: true
                        }
                    }
                }
            }
        }

        // === КНОПКА ПРЕОБРАЗОВАНИЯ ===
        Rectangle {
            id: convertButton
            Layout.preferredWidth: 200
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignHCenter
            radius: 6
            color: getConvertButtonColor(convertButtonMouseArea, convertButton.enabled)
            enabled: inputFileField.text && outputPathField.text && outputNameField.text

            Text {
                anchors.centerIn: parent
                text: "ПРЕОБРАЗОВАТЬ"
                color: convertButton.enabled ? "white" : "#888"
                font.pixelSize: 14
                font.bold: true
            }

            MouseArea {
                id: convertButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: convertButton.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: {
                    if (!convertButton.enabled) {
                        statusLabel.text = "✗ Заполните все поля!"
                        statusLabel.color = "#f44336"
                        return
                    }

                    var inputPath = inputFileField.text
                    var outputDir = outputPathField.text
                    var fileName = outputNameField.text

                    // Убедимся, что путь не пустой
                    if (!inputPath || !outputDir || !fileName) {
                        statusLabel.text = "✗ Заполните все поля!"
                        statusLabel.color = "#f44336"
                        return
                    }

                    // Добавляем .csv только если его нет
                    if (!fileName.toLowerCase().endsWith(".csv")) {
                        fileName = fileName + ".csv"
                        outputNameField.text = fileName
                    }

                    var outputPath = outputDir + "/" + fileName

                    // Показываем индикатор загрузки
                    busyIndicator.running = true
                    convertButton.enabled = false
                    statusLabel.text = "Преобразование файла..."
                    statusLabel.color = "#2196f3"

                    // Запускаем преобразование
                    var success = converter.convertTxtToXlsx(inputPath, outputPath)

                    busyIndicator.running = false
                    convertButton.enabled = inputFileField.text && outputPathField.text && outputNameField.text

                    if (success) {
                        statusLabel.text = "✓ Файл успешно преобразован!"
                        statusLabel.color = "#4CAF50"
                        resultDialog.title = "Успешно"
                        resultLabel.text = "Файл успешно преобразован:\n" + outputPath
                        resultDialog.open()
                    } else {
                        statusLabel.text = "✗ Ошибка при преобразовании"
                        statusLabel.color = "#f44336"
                        resultDialog.title = "Ошибка"
                        resultLabel.text = "Ошибка преобразования:\n" + converter.getLastError()
                        resultDialog.open()
                    }
                }
            }
        }

        // === СТАТУС И ПРОГРЕСС ===
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            BusyIndicator {
                id: busyIndicator
                running: false
                visible: running
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
            }

            Text {
                id: statusLabel
                text: "Готов к работе"
                color: "#aaa"
                font.pixelSize: 14
            }
        }

        // === ИНФОРМАЦИЯ О ПРОГРАММЕ ===
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "© 2026 Конвертер txt-to-csv v1.0"
            color: "#666"
            font.pixelSize: 10
        }
    }

    // === ДИАЛОГИ ВЫБОРА ФАЙЛОВ ===
    Platform.FileDialog {
        id: fileDialog
        title: "Выберите текстовый файл"
        nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]

        onAccepted: {
            var fileUrl = fileDialog.file.toString()
            var filePath = urlToLocalPath(fileUrl)

            inputFileField.text = filePath

            // Автоматически заполняем выходные поля
            var lastSlash = Math.max(filePath.lastIndexOf('\\'), filePath.lastIndexOf('/'))
            if (lastSlash > 0) {
                var path = filePath.substring(0, lastSlash)
                var fullFileName = filePath.substring(lastSlash + 1)
                var fileName = fullFileName

                // Убираем расширение .txt если есть
                if (fileName.toLowerCase().endsWith(".txt")) {
                    fileName = fileName.substring(0, fileName.length - 4)
                }

                outputPathField.text = path
                // Добавляем .csv только если его еще нет
                if (!fileName.toLowerCase().endsWith(".csv")) {
                    fileName = fileName + ".csv"
                }
                outputNameField.text = fileName

                statusLabel.text = "Файл выбран: " + fullFileName
                statusLabel.color = "#aaa"
            }
        }
    }

    Platform.FolderDialog {
        id: folderDialog
        title: "Выберите папку для сохранения"

        onAccepted: {
            var folderUrl = folderDialog.folder.toString()
            var folderPath = urlToLocalPath(folderUrl)

            outputPathField.text = folderPath
            statusLabel.text = "Папка для сохранения выбрана"
            statusLabel.color = "#aaa"
        }
    }

    // === ДИАЛОГ РЕЗУЛЬТАТА ===
    Popup {
        id: resultDialog
        width: 500
        height: 200
        modal: true
        focus: true
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "#2d2d2d"
            radius: 8
            border.color: "#444"
            border.width: 2

            // Заголовок диалога
            Rectangle {
                width: parent.width
                height: 40
                color: "#3d3d3d"
                radius: 8

                Text {
                    anchors.centerIn: parent
                    text: resultDialog.title
                    color: resultDialog.title === "Успешно" ? "#4CAF50" : "#f44336"
                    font.pixelSize: 16
                    font.bold: true
                }

                // Кнопка закрытия
                Rectangle {
                    width: 30
                    height: 30
                    radius: 15
                    color: closeResultMouseArea.pressed ? "#3a3a3a" : (closeResultMouseArea.containsMouse ? "#2a2a2a" : "transparent")
                    anchors {
                        right: parent.right
                        top: parent.top
                        margins: 5
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "✕"
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: closeResultMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: resultDialog.close()
                    }
                }
            }
        }

        contentItem: ColumnLayout {
            anchors.fill: parent
            anchors.margins: 2
            spacing: 15

            Text {
                id: resultLabel
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                font.pixelSize: 14
                wrapMode: Text.Wrap
                Layout.topMargin: 45
                Layout.leftMargin: 15
                Layout.rightMargin: 15
            }

            // Кнопка OK
            Rectangle {
                Layout.preferredWidth: 100
                Layout.preferredHeight: 35
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 10
                radius: 4
                color: okResultMouseArea.pressed ? "#45a049" : (okResultMouseArea.containsMouse ? "#5cbf62" : "#4CAF50")

                Text {
                    anchors.centerIn: parent
                    text: "OK"
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                }

                MouseArea {
                    id: okResultMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: resultDialog.close()
                }
            }
        }
    }

    // === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
    function getButtonColor(mouseArea, enabled) {
        if (!enabled) return buttonDisabled
        if (mouseArea.pressed) return buttonPressed
        if (mouseArea.containsMouse) return buttonHover
        return buttonNormal
    }

    function getConvertButtonColor(mouseArea, enabled) {
        if (!enabled) return "#555"
        if (mouseArea.pressed) return "#3a5c42"
        if (mouseArea.containsMouse) return "#5cbf62"
        return "#4CAF50"
    }

    function urlToLocalPath(url) {
        var filePath
        if (url.startsWith("file:///")) {
            // Windows
            filePath = url.substring(8)
            filePath = filePath.replace(/\//g, "\\")
        } else if (url.startsWith("file://")) {
            // Linux/Mac
            filePath = url.substring(7)
        } else {
            filePath = url
        }
        return filePath
    }
}
