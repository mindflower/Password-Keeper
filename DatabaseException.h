#ifndef DATABASEEXCEPTION_H
#define DATABASEEXCEPTION_H

#include <QException>

class DatabaseException : public QException
{
public:
    DatabaseException(const QString& reason);
    void raise() const override;
    DatabaseException *clone() const override;
    const char *what() const override;
    QString qWhat() const;

private:
    const QString m_reason;
};

#endif // DATABASEEXCEPTION_H
