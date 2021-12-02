#include "imagehandler.h"

ImageHandler::ImageHandler(QObject *parent) : QObject(parent)
{

}

void ImageHandler::slotSetImage(const QVariant &preview)
{
    qDebug()<<"image set in imagehandler object";
    m_image=preview.value<QImage>();
}

QImage ImageHandler::slotGetImage() const
{
    return m_image;
}
