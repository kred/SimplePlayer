#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "filesdiscoverymodel.h"
#include "simplestorage.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType<FilesDiscoveryModel>("com.simpleplayer", 1, 0, "FilesDiscoveryModel", filesDiscoverySingletonProvider);
    qmlRegisterSingletonType<SimpleStorage>("com.simpleplayer", 1, 0, "SimpleStorage", simpleStorageSingletonProvider);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
