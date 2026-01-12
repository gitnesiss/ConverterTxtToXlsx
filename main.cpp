// #include <QGuiApplication>
// #include <QQmlApplicationEngine>
// #include <QIcon>
// #include "converter.h"

// int main(int argc, char *argv[])
// {
//     QGuiApplication app(argc, argv);

//     app.setOrganizationName("ConverterApp");
//     app.setApplicationName("Converter txt-to-xlsx");
//     app.setApplicationVersion("1.0.0");

//     // Регистрация C++ типа для использования в QML
//     qmlRegisterType<Converter>("ConverterTxtToXlsx", 1, 0, "Converter");

//     // Регистрация enum
//     qmlRegisterUncreatableType<Converter>("ConverterTxtToXlsx", 1, 0, "OutputFormat",
//                                           "OutputFormat is an enum of Converter");

//     QQmlApplicationEngine engine;

//     // Загружаем главный QML файл
//     engine.load(QUrl(QStringLiteral("qrc:/MainWindow.qml")));

//     if (engine.rootObjects().isEmpty()) {
//         return -1;
//     }

//     return app.exec();
// }



















#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "converter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("ConverterApp");
    app.setApplicationName("Converter txt-to-xlsx");
    app.setApplicationVersion("1.0.0");

    // Регистрация C++ типа для использования в QML
    qmlRegisterType<Converter>("ConverterTxtToXlsx", 1, 0, "Converter");

    QQmlApplicationEngine engine;

    // Загружаем главный QML файл
    engine.load(QUrl(QStringLiteral("qrc:/MainWindow.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
