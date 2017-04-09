#ifndef FILESDISCOVERYTHREAD_H
#define FILESDISCOVERYTHREAD_H

#include <QThread>

class FilesDiscoveryThread : public QThread
{
    Q_OBJECT
public:
    FilesDiscoveryThread(QObject *parent, const QString & rootDir);


signals:
    void sendNewPath(const QString & path, const QString & name);

protected:
    void run();


private:
    void recursiveScan(const QString & path);

private:
    const QString m_rootDir;
    QStringList m_nameFilters;


};

#endif // FILESDISCOVERYTHREAD_H
