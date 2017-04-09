#include <QDir>
#include <QFileInfo>
#include "filesdiscoverythread.h"

FilesDiscoveryThread::FilesDiscoveryThread(QObject *parent, const QString & rootDir)
    : QThread(parent), m_rootDir(rootDir)
{
    m_nameFilters << "*.mkv" << "*.flv" << "*.avi" << "*.mpg" << "*.mpeg" << "*.mp4" << "*.mov";
}

void FilesDiscoveryThread::run()
{
    recursiveScan(m_rootDir);
}

void FilesDiscoveryThread::recursiveScan(const QString &path)
{
    if (QThread::currentThread()->isInterruptionRequested())
    {
        return;
    }

    QDir activeDir(path);

    QStringList entryDirs;
    QStringList entryFiles;

    entryDirs = activeDir.entryList(QDir::Dirs | QDir::NoSymLinks | QDir::NoDot | QDir::NoDotDot | QDir::Readable, QDir::Name);
    for(auto dir : entryDirs)
    {
        recursiveScan(activeDir.path() + "/" + dir);
    }

    entryFiles = activeDir.entryList(m_nameFilters, QDir::Files | QDir::NoSymLinks | QDir::NoDot | QDir::NoDotDot | QDir::Readable, QDir::Name);

    for(auto path : entryFiles)
    {
        QString name = QFileInfo(activeDir.path() + "/" + path).fileName();
        emit sendNewPath(activeDir.path() + "/" + path, name);
    }

}
