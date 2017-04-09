#include <QCoreApplication>
#include <QFile>
#include <QDataStream>
#include "simplestorage.h"

SimpleStorage::SimpleStorage(QObject *parent) : QObject(parent)
{

}

void SimpleStorage::load(const QString & name)
{
    m_properties.clear();

    QString path = QCoreApplication::instance()->applicationDirPath() + "/" + name + ".storage";
    QFile file(path);
    if (file.open(QIODevice::ReadOnly))
    {
        QDataStream stream(&file);
        stream >> m_properties;
    }
}

void SimpleStorage::save(const QString & name)
{
    QString path = QCoreApplication::instance()->applicationDirPath() + "/" + name + ".storage";
    QFile file(path);
    if (file.open(QIODevice::WriteOnly))
    {
        QDataStream stream(&file);
        stream << m_properties;
        file.flush();
    }
}

void SimpleStorage::set(const QString & property, const QVariant & value)
{
    m_properties.insert(property, value);
}

QVariant SimpleStorage::get(const QString & property)
{
    return m_properties.value(property);
}
