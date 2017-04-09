#ifndef SIMPLESTORAGE_H
#define SIMPLESTORAGE_H

#include <QObject>
#include <QMap>
#include <QVariant>

class QQmlEngine;
class QJSEngine;

class SimpleStorage : public QObject
{
    Q_OBJECT
public:
    explicit SimpleStorage(QObject *parent = 0);

signals:

public slots:
    void load(const QString & name);
    void save(const QString & name);
    void set(const QString & property, const QVariant & value);
    QVariant get(const QString & property);


private:
    QMap<QString, QVariant> m_properties;

};

static QObject *simpleStorageSingletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    SimpleStorage *storage = new SimpleStorage();
    return storage;
}

#endif // SIMPLESTORAGE_H
