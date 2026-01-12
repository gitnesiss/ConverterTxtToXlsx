import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

ApplicationWindow {
    id: window
    width: 600
    height: 400
    minimumWidth: 500
    minimumHeight: 300
    title: "Converter txt-to-xlsx v1.0"
    visible: true

    Converter {
        id: converter
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // Заголовок
        Label {
            text: "Converter txt-to-xlsx"
            font.bold: true
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
            color: "#2c3e50"
        }

        Label {
            text: "Преобразователь текстовых файлов в Excel формат"
            font.pixelSize: 12
            Layout.alignment: Qt.AlignHCenter
            color: "#7f8c8d"
        }

        // Блок выбора файла
        GroupBox {
            title: "Исходный файл (.txt)"
            Layout.fillWidth: true

            ColumnLayout {
                width: parent.width
                spacing: 10

                RowLayout {
                    TextField {
                        id: inputFileField
                        Layout.fillWidth: true
                        placeholderText: "Выберите файл .txt для преобразования"
                        readOnly: true
                    }

                    Button {
                        text: "📁 Обзор"
                        onClicked: fileDialog.open()
                    }
                }
            }
        }

        // Блок настроек выходного файла
        GroupBox {
            title: "Выходной файл (.xlsx)"
            Layout.fillWidth: true

            GridLayout {
                width: parent.width
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                Label { text: "Путь сохранения:" }
                TextField {
                    id: outputPathField
                    Layout.fillWidth: true
                    placeholderText: "Путь для сохранения файла"
                }

                Label { text: "Имя файла:" }
                TextField {
                    id: outputNameField
                    Layout.fillWidth: true
                    placeholderText: "результат.xlsx"
                }
            }
        }

        // Кнопка преобразования
        Button {
            id: convertButton
            text: "🚀 Преобразовать"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            enabled: inputFileField.text && outputPathField.text && outputNameField.text

            onClicked: {
                var inputPath = inputFileField.text
                var outputDir = outputPathField.text
                var fileName = outputNameField.text

                // Убедимся, что имя файла имеет правильное расширение
                if (!fileName.endsWith(".xlsx")) {
                    fileName = fileName + ".xlsx"
                    outputNameField.text = fileName
                }

                var outputPath = outputDir + "/" + fileName

                // Показываем индикатор загрузки
                busyIndicator.running = true
                convertButton.enabled = false
                statusLabel.text = "Преобразование файла..."

                // Запускаем преобразование
                var success = converter.convertTxtToXlsx(inputPath, outputPath)
                busyIndicator.running = false
                convertButton.enabled = true

                if (success) {
                    statusLabel.text = "✓ Файл успешно преобразован!"
                    statusLabel.color = "green"

                    // Создаем и показываем диалог успеха
                    successDialog.text = "Файл успешно преобразован!\n\n" +
                                       "Исходный файл: " + inputPath + "\n" +
                                       "Результат: " + outputPath
                    successDialog.open()
                } else {
                    statusLabel.text = "✗ Ошибка при преобразовании"
                    statusLabel.color = "red"

                    // Создаем и показываем диалог ошибки
                    errorDialog.text = "Ошибка преобразования:\n" + converter.getLastError()
                    errorDialog.open()
                }
            }
        }

        // Прогресс и статус
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            BusyIndicator {
                id: busyIndicator
                running: false
                visible: running
            }

            Label {
                id: statusLabel
                text: "Готов к работе"
            }
        }

        // Информация о программе
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "© 2024 Converter txt-to-xlsx v1.0"
            font.pixelSize: 10
            color: "gray"
        }
    }

    // Диалог выбора файла (исправленный для Qt 6.9)
    FileDialog {
        id: fileDialog
        title: "Выберите текстовый файл"
        nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)

        onAccepted: {
            var filePath = selectedFile.toString()
            // Убираем префикс "file:///" для Windows
            if (Qt.platform.os === "windows") {
                filePath = filePath.replace(/^file:\/\//, "")
            } else {
                filePath = filePath.replace(/^file:\/\//, "/")
            }

            inputFileField.text = filePath

            // Автоматически заполняем выходные поля
            var lastSlash = Math.max(filePath.lastIndexOf('/'), filePath.lastIndexOf('\\'))
            var path = filePath.substring(0, lastSlash)
            var fullFileName = filePath.substring(lastSlash + 1)
            var fileName = fullFileName.substring(0, fullFileName.lastIndexOf('.'))

            outputPathField.text = path
            outputNameField.text = fileName + ".xlsx"

            statusLabel.text = "Файл выбран: " + fullFileName
        }

        onRejected: {
            statusLabel.text = "Выбор файла отменен"
        }
    }

    // Диалог успеха
    Dialog {
        id: successDialog
        title: "Успешно"
        modal: true
        standardButtons: Dialog.Ok

        width: 400
        height: 200

        contentItem: ColumnLayout {
            spacing: 10

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: successDialog.text
            }
        }
    }

    // Диалог ошибки
    Dialog {
        id: errorDialog
        title: "Ошибка"
        modal: true
        standardButtons: Dialog.Ok

        width: 400
        height: 200

        contentItem: ColumnLayout {
            spacing: 10

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: errorDialog.text
                color: "red"
            }
        }
    }
}
