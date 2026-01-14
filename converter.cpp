#include "converter.h"
#include <QFile>
#include <QTextStream>
#include <QFileInfo>
#include <QDir>
#include <QDebug>
#include <QRegularExpression>

Converter::Converter(QObject *parent) : QObject(parent)
{
}

bool Converter::convertTxtToXlsx(const QString &inputPath, const QString &outputPath)
{
    m_lastError.clear();

    qDebug() << "=== Starting conversion ===";
    qDebug() << "Input path:" << inputPath;
    qDebug() << "Output path:" << outputPath;

    // Проверка входного файла
    QFile inputFile(inputPath);
    if (!inputFile.exists()) {
        m_lastError = "Входной файл не существует: " + inputPath;
        qDebug() << "Error:" << m_lastError;
        return false;
    }

    qDebug() << "Input file exists, trying to open...";
    if (!inputFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_lastError = "Не удалось открыть входной файл: " + inputPath;
        qDebug() << "Error:" << m_lastError;
        return false;
    }

    qDebug() << "Input file opened successfully";

    // Меняем расширение на .csv вместо .xlsx
    QString csvOutputPath = outputPath;
    if (csvOutputPath.endsWith(".xlsx", Qt::CaseInsensitive)) {
        csvOutputPath = csvOutputPath.left(csvOutputPath.length() - 5) + ".csv";
    } else if (!csvOutputPath.endsWith(".csv", Qt::CaseInsensitive)) {
        csvOutputPath = csvOutputPath + ".csv";
    }

    qDebug() << "CSV output path:" << csvOutputPath;

    // Проверка выходного пути
    QFileInfo outputInfo(csvOutputPath);
    QDir outputDir = outputInfo.absoluteDir();
    qDebug() << "Output directory:" << outputDir.absolutePath();

    if (!outputDir.exists()) {
        qDebug() << "Output directory doesn't exist, creating...";
        if (!outputDir.mkpath(".")) {
            m_lastError = "Не удалось создать директорию для выходного файла: " + outputDir.absolutePath();
            qDebug() << "Error:" << m_lastError;
            inputFile.close();
            return false;
        }
        qDebug() << "Output directory created";
    }

    // Открываем выходной файл
    QFile outputFile(csvOutputPath);
    qDebug() << "Trying to open output file...";
    if (!outputFile.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate)) {
        m_lastError = "Не удалось создать выходной файл: " + csvOutputPath;
        qDebug() << "Error:" << m_lastError;
        inputFile.close();
        return false;
    }

    qDebug() << "Output file opened successfully";

    QTextStream in(&inputFile);
    QTextStream out(&outputFile);
    out.setEncoding(QStringConverter::Utf8);

    // Добавляем BOM для правильной кодировки UTF-8 в Excel
    out << "\xFEFF";

    // Заголовки столбцов (используем разделитель ';')
    out << "Time_ms;PITCH;ROLL;YAW;Dizziness;Nystagmus\n";
    qDebug() << "Header written";

    int lineCount = 0;
    int processedLines = 0;

    qDebug() << "Starting to read input file...";
    while (!in.atEnd()) {
        QString line = in.readLine().trimmed();
        lineCount++;

        // Пропускаем пустые строки и комментарии
        if (line.isEmpty() || line.startsWith('#')) {
            continue;
        }

        qDebug() << "Original line:" << line;

        // Разделяем строку на части
        QStringList parts = line.split(';');
        qDebug() << "Parts count:" << parts.size();

        if (parts.size() >= 6) {
            // Обрабатываем каждую часть
            QStringList processedParts;

            for (int i = 0; i < parts.size(); i++) {
                QString part = parts[i];

                if (i == 0) { // Time_ms - первая колонка
                    // Удаляем ведущие нули для Time_ms
                    part = removeLeadingZeros(part);
                } else if (i >= 1 && i <= 3) { // PITCH, ROLL, YAW (столбцы 2-4)
                    // Заменяем точку на запятую для десятичных чисел
                    part = part.replace('.', ',');
                    // Удаляем ведущие нули для десятичных чисел
                    part = removeLeadingZerosFromDecimal(part);
                }
                // Dizziness и Nystagmus (столбцы 5-6, флаги 0/1) оставляем как есть

                processedParts.append(part);
            }

            // Собираем обратно строку с разделителем ';'
            QString processedLine = processedParts.join(';');
            out << processedLine << "\n";

            processedLines++;

            // Выводим отладочную информацию для первых нескольких строк
            if (processedLines <= 3) {
                qDebug() << "Processed line" << processedLines << ":" << processedLine;
            }
        }
    }

    inputFile.close();
    outputFile.close();

    qDebug() << "File processing completed";
    qDebug() << "Total lines read:" << lineCount;
    qDebug() << "Processed lines:" << processedLines;

    if (processedLines == 0) {
        m_lastError = "Файл не содержит данных для преобразования (только комментарии или пустые строки)";
        qDebug() << "Error:" << m_lastError;
        outputFile.remove();
        return false;
    }

    qDebug() << "=== Conversion successful! ===";
    qDebug() << "CSV file saved to:" << csvOutputPath;

    // Сообщаем пользователю о реальном имени файла
    m_lastError = QString("Файл успешно преобразован!\nСохранен как: %1\n\n"
                          "При открытии в Excel:\n"
                          "1. Выберите 'Все файлы (*.*)'\n"
                          "2. Укажите кодировку UTF-8\n"
                          "3. Выберите разделитель ';'").arg(csvOutputPath);

    return true;
}

QString Converter::getLastError() const
{
    return m_lastError;
}

// Вспомогательная функция для удаления ведущих нулей из целых чисел
QString Converter::removeLeadingZeros(const QString &str)
{
    if (str.isEmpty()) {
        return str;
    }

    QString result = str;

    // Удаляем все ведущие нули, но оставляем последний ноль, если строка состоит только из нулей
    while (result.length() > 1 && result.startsWith('0') && !result.startsWith("0.")) {
        result = result.mid(1);
    }

    return result;
}

// Вспомогательная функция для удаления ведущих нулей из десятичных чисел
QString Converter::removeLeadingZerosFromDecimal(const QString &str)
{
    if (str.isEmpty()) {
        return str;
    }

    QString result = str;

    // Обрабатываем отрицательные числа
    bool isNegative = false;
    if (result.startsWith('-')) {
        isNegative = true;
        result = result.mid(1);
    }

    // Удаляем ведущие нули перед точкой/запятой
    // Например: "001.23" -> "1.23", "000.5" -> "0.5"
    if (result.contains('.') || result.contains(',')) {
        // Находим позицию десятичного разделителя
        int dotPos = result.indexOf('.');
        int commaPos = result.indexOf(',');
        int separatorPos = (dotPos != -1) ? dotPos : commaPos;

        if (separatorPos > 0) {
            QString integerPart = result.left(separatorPos);
            QString decimalPart = result.mid(separatorPos);

            // Удаляем ведущие нули из целой части
            while (integerPart.length() > 1 && integerPart.startsWith('0')) {
                integerPart = integerPart.mid(1);
            }

            result = integerPart + decimalPart;
        }
    } else {
        // Для целых чисел используем обычную функцию
        result = removeLeadingZeros(result);
    }

    // Восстанавливаем знак минуса если нужно
    if (isNegative) {
        result = "-" + result;
    }

    return result;
}
