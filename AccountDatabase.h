#ifndef ACCOUNT_DATABASE_H
#define ACCOUNT_DATABASE_H

#include "Account.h"
#include <QtSql>
#include <optional>

class AccountDatabase
{
public:
    void setup(const QString& databasePath, const QString& password);
    QList<Account> getAccounts();
    void insertAccount(const Account& account);

private:
    void executeQuery(QSqlQuery& query,const QString& queryContent,
               const std::optional<QStringList>& oBindList = std::nullopt);

private:
    QSqlDatabase m_database;
};
#endif // ACCOUNT_DATABASE_H
