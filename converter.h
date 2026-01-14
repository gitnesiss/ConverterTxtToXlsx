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
