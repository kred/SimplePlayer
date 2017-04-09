#include "filesdiscoverymodel.h"
#include "filesdiscoverythread.h"

FilesDiscoveryModel::FilesDiscoveryModel()
    : m_rootDir("/media/filmy/filmy"), m_discoveryThread(nullptr)
{
    m_discoveryThread = new FilesDiscoveryThread(this, "/home/krzys/Wideo");
    connect(m_discoveryThread, SIGNAL(sendNewPath(QString,QString)), this, SLOT(receiveNewPath(QString,QString)));
    connect(m_discoveryThread, SIGNAL(finished()), this, SLOT(scanningFinished()));
}

FilesDiscoveryModel::~FilesDiscoveryModel()
{
    if (m_discoveryThread->isRunning())
        m_discoveryThread->terminate();
    m_discoveryThread->wait();
}

QHash<int, QByteArray> FilesDiscoveryModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[PathRole] = "path";
    roles[NameRole] = "name";
    roles[IndexRole] = "index";

    return roles;
}

int FilesDiscoveryModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant FilesDiscoveryModel::data(const QModelIndex &index, int role) const
{
    QVariant ret;

    if (!(index.row() < 0 || index.row() >= m_data.count()))
    {
        switch(role)
        {
        case PathRole:
            ret = QVariant(m_data[index.row()].first);
            break;
        case NameRole:
            ret = QVariant(m_data[index.row()].second);
            break;
        case IndexRole:
            ret = QVariant(index.row());
            break;
        }
    }

    return ret;
}

int FilesDiscoveryModel::count() const
{
    return m_data.count();
}

void FilesDiscoveryModel::scan()
{
    if (!scanning())
    {
        clean();
        m_discoveryThread->start();
        emit scanningChanged();
    }
}

bool FilesDiscoveryModel::scanning() const
{
    bool runing = m_discoveryThread->isRunning();
    return runing;
}

void FilesDiscoveryModel::clean()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
    emit countChanged();
}

QString FilesDiscoveryModel::getName(int index)
{
    QString ret;

    if (!(index < 0 || index >= m_data.count()))
    {
        ret = m_data[index].second;
    }

    return ret;
}

QString FilesDiscoveryModel::getPath(int index)
{
    QString ret;

    if (!(index < 0 || index >= m_data.count()))
    {
        ret = m_data[index].first;
    }

    return ret;
}

int FilesDiscoveryModel::getIndex(const QString & path)
{
    int i = 0;
    for(auto it = m_data.begin(); it != m_data.end(); ++it, ++i)
    {
        if (it->first == path)
            return i;
    }
    return -1;
}

void FilesDiscoveryModel::receiveNewPath(const QString &path, const QString &name)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.append(PathPair(path, name));
    endInsertRows();
    emit countChanged();
}

void FilesDiscoveryModel::scanningFinished()
{
    emit scanningChanged();
}
