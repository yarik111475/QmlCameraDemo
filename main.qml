import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.12
import Qt.labs.platform 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Qml Camera Demo")
    header: Rectangle{
        id: headerRect;
        width: parent.width;
        height: 60;
    }

    Camera{
        id: sourceCamera;
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto;
        captureMode: Camera.CaptureStillImage;
        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }
        imageCapture{
            onImageCaptured: {
                //here we can access image using 'preview' parameter
                console.log("camera image captured...");
            }
        }

    }
    Rectangle{
        anchors.fill: parent;
        anchors.margins: 10;
        implicitWidth: videoOut.width+videoOut.anchors.margins*2;
        implicitHeight: videoOut.height+videoOut.anchors.margins*2;
        border{
            width: 1;
            color: "black";
        }
        VideoOutput{
            id: videoOut;
            anchors.fill: parent;
            anchors.margins: 10;
            source: sourceCamera;
            autoOrientation: true;
        }
    }

    footer: Rectangle{
        id: footerRect;
        width: parent.width;
        height: 60;

        Row{
            anchors.centerIn: parent;
            anchors.margins: 10;
            spacing: 10;
            Button{
                id: startButton;
                text: qsTr("Start");
                onClicked: {
                    sourceCamera.start();
                    captureTimer.start();
                }
            }
            Button{
                id: stopButton;
                text: qsTr("Stop");
                onClicked: {
                    sourceCamera.stop();
                    captureTimer.stop();
                }
            }
            Button{
                id: quitButton;
                text: qsTr("Quit");
                onClicked: {
                    Qt.quit();
                }
            }
        }
    }
    Timer{
        id: captureTimer;
        running: false;
        interval: 250;
        repeat: true;
        onTriggered: {
            if(sourceCamera.imageCapture.ready){
                sourceCamera.imageCapture.capture();
            }
        }
    }
    Component.onCompleted: {
        sourceCamera.stop();
    }
}
