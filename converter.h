// #ifndef CONVERTER_H
// #define CONVERTER_H

// #include <QObject>
// #include <QString>

// class Converter : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(bool formatIsXlsx READ formatIsXlsx WRITE setFormatIsXlsx NOTIFY formatChanged)

// public:
//     enum OutputFormat {
//         FormatCSV,
//         FormatXLSX
//     };
//     Q_ENUM(OutputFormat)

//     explicit Converter(QObject *parent = nullptr);

// public slots:
//     bool convertTxtToFile(const QString &inputPath, const QString &outputPath, OutputFormat format);
//     QString getLastError() const;

//     // Для QML
//     bool convertTxtToFileQML(const QString &inputPath, const QString &outputPath, int format);
//     bool formatIsXlsx() const { return m_format == FormatXLSX; }
//     void setFormatIsXlsx(bool isXlsx) {
//         if (isXlsx != (m_format == FormatXLSX)) {
//             m_format = isXlsx ? FormatXLSX : FormatCSV;
//             emit formatChanged();
//         }
//     }

// signals:
//     void formatChanged();

// private:
//     QString m_lastError;
//     OutputFormat m_format = FormatCSV;

//     // Вспомогательные функции для удаления ведущих нулей
//     QString removeLeadingZeros(const QString &str);
//     QString removeLeadingZerosFromDecimal(const QString &str);

//     // Функции для конвертации
//     bool convertToCSV(const QString &inputPath, const QString &outputPath);
//     bool convertToXLSX(const QString &inputPath, const QString &outputPath);

//     // Утилиты для обработки чисел
//     QString processNumber(const QString &str, bool isInteger);
// };

// #endif // CONVERTER_H



















#ifndef CONVERTER_H
#define CONVERTER_H

#include <QObject>
#include <QString>

class Converter : public QObject
{
    Q_OBJECT

public:
    explicit Converter(QObject *parent = nullptr);

public slots:
    bool convertTxtToXlsx(const QString &inputPath, const QString &outputPath);
    QString getLastError() const;

private:
    QString m_lastError;

    // Вспомогательные функции для удаления ведущих нулей
    QString removeLeadingZeros(const QString &str);
    QString removeLeadingZerosFromDecimal(const QString &str);
};

#endif // CONVERTER_H
