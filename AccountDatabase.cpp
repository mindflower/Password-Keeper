#include "AccountDatabase.h"
#include "DatabaseException.h"

using namespace std;

void AccountDatabase::setup(const QString& databasePath, const QString& password)
{
    if (m_database.isOpen())
    {
        m_database.close();
    }
    m_database = QSqlDatabase::addDatabase("SQLITECIPHER");
    m_database.setDatabaseName(databasePath);
    m_database.setPassword(password);
    if (!m_database.open())
    {
        throw DatabaseException(m_database.lastError().driverText());
    }

    QSqlQuery query;
    executeQuery(query,"SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'account_table'");
    query.first();
    if (query.value(0).toInt() == 0)
    {
        executeQuery(query,
                     "CREATE TABLE account_table ("
                     " account TEXT,"
                     " login TEXT,"
                     " password TEXT"
                     ")");
    }

    executeQuery(query, "SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'database_hash'");
    query.first();
    if (query.value(0).toInt() == 0)
    {
        executeQuery(query,
                     "CREATE TABLE database_hash ("
                     " hash TEXT"
                     ")");
    }
}

QList<Account> AccountDatabase::getAccounts()
{
    QSqlQuery query;
    executeQuery(query, "SELECT * FROM account_table");

    QList<Account> result;
    const QSqlRecord record = query.record();
    while (query.next())
    {
        const QString account = query.value(record.indexOf("account")).toString();
        const QString login = query.value(record.indexOf("login")).toString();
        const QString password = query.value(record.indexOf("password")).toString();
        result.append({account, login, password});
    }
    return result;
}

void AccountDatabase::insertAccount(const Account& account)
{
    QSqlQuery query;
    qDebug() << account.login;
    executeQuery(query, "INSERT INTO account_table VALUES (?,?,?)",
                 {{account.account, account.login, account.password}});
}

void AccountDatabase::executeQuery(QSqlQuery& query, const QString& queryContent,
                            const optional<QStringList>& oBindList)
{
    query.prepare(queryContent);
    if (oBindList.has_value())
    {
        const auto& bindList = oBindList.value();
        for (const auto& elem : bindList)
        {
            query.addBindValue(elem);
        }
    }

    if (!query.exec())
    {
        throw DatabaseException(query.lastError().text());
    }
}
