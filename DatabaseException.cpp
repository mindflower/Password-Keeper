#include "DatabaseException.h"

DatabaseException::DatabaseException(const QString& reason) :
    m_reason(reason)
{
}

void DatabaseException::raise() const
{
    throw *this;
}

DatabaseException *DatabaseException::clone() const
{
    return new DatabaseException(*this);
}

const char *DatabaseException::what() const
{
    return m_reason.toStdString().c_str();
}

QString DatabaseException::qWhat() const
{
    return m_reason;
}
