#include "AccountModel.h"
#include "DatabaseException.h"

using namespace std;

AccountModel::AccountModel(QObject *parent):
    QAbstractListModel(parent)
{
}


int AccountModel::rowCount(const QModelIndex&) const
{
    return m_data.size();
}

QVariant AccountModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
    {
        return QVariant();
    }

    switch (role)
    {
    case AccountRole:
        return m_data.at(index.row()).account;
    case LoginRole:
        return m_data.at(index.row()).login;
    case PasswordRole:
        return m_data.at(index.row()).password;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> AccountModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[AccountRole] = "account";
    roles[LoginRole] = "login";
    roles[PasswordRole] = "password";
    return roles;
}

bool AccountModel::addAccount(const QString& account, const QString& login,
                              const QString& password)
{
    try
    {
        beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
        const auto acc = Account{account, login, password};
        m_database.insertAccount(acc);
        m_data.append(acc);
        endInsertRows();
        return true;
    }
    catch (const DatabaseException& ex)
    {
        m_lastError = ex.qWhat();
        qDebug() << m_lastError;
        return false;
    }
}

bool AccountModel::openDatabase(const QString& databasePath, const QString& password)
{
    try
    {
        beginResetModel();
        m_data.clear();
        endResetModel();

        m_database.setup(databasePath, password);
        const auto accounts = m_database.getAccounts();
        if (!accounts.empty())
        {
            beginInsertRows(QModelIndex(), m_data.size(), m_data.size() + accounts.size() - 1);
            m_data.append(accounts);
            endInsertRows();
        }
        return true;
    }
    catch (const DatabaseException& ex)
    {
        m_lastError = ex.qWhat();
        qDebug() << m_lastError;
        return false;
    }
}

QString AccountModel::getLastError()
{
    return m_lastError;
}
