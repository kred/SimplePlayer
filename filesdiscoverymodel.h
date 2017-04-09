#ifndef FILESDISCOVERYMODEL_H
#define FILESDISCOVERYMODEL_H

#include <QAbstractListModel>
#include <QMutex>
#include <QThread>
#include <tuple>

class QQmlEngine;
class QJSEngine;
class FilesDiscoveryThread;

typedef std::pair<QString, QString> PathPair; // <Path, Name>


class FilesDiscoveryModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool scanning READ scanning NOTIFY scanningChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum FilesDiscoveryRoles {
        PathRole = Qt::UserRole + 1,
        NameRole,
        IndexRole,
    };


public:
    FilesDiscoveryModel();
    ~FilesDiscoveryModel();

    virtual QHash<int, QByteArray> roleNames() const;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

public slots:
    int count() const;
    void scan();
    bool scanning() const;
    void clean();
    QString getName(int index);
    QString getPath(int index);
    int getIndex(const QString & path);

signals:
    void scanningChanged();
    void countChanged();

private slots:
    void receiveNewPath(const QString & path, const QString & name);
    void scanningFinished();


private:
    QList<PathPair> m_data;
    QString m_rootDir;
    FilesDiscoveryThread* m_discoveryThread;

};

static QObject *filesDiscoverySingletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    FilesDiscoveryModel *model = new FilesDiscoveryModel();
    return model;
}

#endif // FILESDISCOVERYMODEL_H
