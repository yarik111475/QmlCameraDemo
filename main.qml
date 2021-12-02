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
        height: 50;
        color: "gray";
        Text{
            color: "white";
            anchors.centerIn: parent;
            renderType: Text.NativeRendering;
            font.pointSize: 20;
            horizontalAlignment: Text.AlignHCenter;
            text: "Qml Camera Demo";
        }
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
                //console.log("camera image captured...");
                ImageHandler.slotSetImage(preview);
            }
        }

    }
    Rectangle{
        anchors.fill: parent;
        anchors.margins: 10;
        implicitWidth: videoOut.width+videoOut.anchors.margins*2;
        implicitHeight: videoOut.height+videoOut.anchors.margins*2;
        color: "steelblue";
        border{
            width: 1;
            color: "black";
        }
        VideoOutput{
            id: videoOut;
            visible: false;
            anchors.fill: parent;
            anchors.margins: 10;
            source: sourceCamera;
            autoOrientation: true;
        }
    }

    footer: Rectangle{
        id: footerRect;
        width: parent.width;
        height: 50;
        color: "gray";

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
                    videoOut.visible=true;
                }
            }
            Button{
                id: stopButton;
                text: qsTr("Stop");
                onClicked: {
                    sourceCamera.stop();
                    captureTimer.stop();
                    videoOut.visible=false;
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
