#ifndef IMAGEHANDLER_H
#define IMAGEHANDLER_H

#include <QtCore>
#include <QObject>
#include <QImage>


class ImageHandler : public QObject
{
    Q_OBJECT
private:
    QImage m_image;
public:
    explicit ImageHandler(QObject *parent = nullptr);
public slots:
    void slotSetImage(const QVariant& preview);
    QImage slotGetImage()const;

signals:

};

#endif // IMAGEHANDLER_H
