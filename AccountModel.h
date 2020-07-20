#ifndef ACCOUNTLISTVIEW_H
#define ACCOUNTLISTVIEW_H
#include <qqml.h>
#include <QAbstractListModel>
#include "AccountDatabase.h"


class AccountModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles
    {
        AccountRole = Qt::UserRole + 1,
        LoginRole,
        PasswordRole
    };

    AccountModel(QObject *parent = 0);
    int rowCount(const QModelIndex& = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool addAccount(const QString& account, const QString& login,
                                const QString& password);
    Q_INVOKABLE bool openDatabase(const QString& databasePath, const QString& password);
    Q_INVOKABLE QString getLastError();

private:
    QList<Account> m_data;
    AccountDatabase m_database;
    QString m_lastError;

};

#endif // ACCOUNTLISTVIEW_H
