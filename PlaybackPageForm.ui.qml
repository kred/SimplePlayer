import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import QtQuick.Extras 1.4

Item {
    id: playbackPage
    width: 800
    property alias fileNameLabel: fileNameLabel
    property alias leftFrame: leftFrame
    property alias videoOutput: videoOutput
    property alias videoSlider: videoSlider
    property alias positionLabel: positionLabel
    property alias currentIndexLabel: currentIndexLabel
    property alias prevButton: prevButton
    property alias playButton: playButton
    property alias nextButton: nextButton

    VideoOutput {
        id: videoOutput
        anchors.left: leftFrame.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        source: mediaPlayer

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
        }

        Slider {
            id: videoSlider
            y: 350
            width: 400
            anchors.right: parent.right
            anchors.rightMargin: 100
        }
    }

    Row {
        id: controlButtonsRow
        x: 201
        y: 316
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Frame {
        id: leftFrame
        x: 0
        y: 9
        width: 200
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        background: Rectangle {
            color: "#000000"
        }
        anchors.leftMargin: 0
        ColumnLayout {
            id: leftFrameLayout
            spacing: 0
            Label {
                id: titleLabel1
                color: "#ffffff"
                text: qsTr("Playback")
                Layout.maximumHeight: 40
                Layout.minimumHeight: 40
                Layout.preferredHeight: 40
                font.underline: false
                font.family: "Tahoma"
                font.bold: true
                Layout.rowSpan: 1
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                font.pixelSize: 32
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
            }

            Text {
                id: currentIndexLabel
                color: "#ffffff"
                text: qsTr("")
                Layout.minimumHeight: 15
                Layout.preferredHeight: 15
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.fillWidth: true
                font.family: "Tahoma"
                font.pixelSize: 12
            }

            Text {
                id: fileNameLabel
                height: 150
                color: "#ffffff"
                text: appWindow.currentIndex >= 0 ? currentName : ""
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 150
                Layout.rowSpan: 1
                enabled: false
                Layout.fillHeight: false
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WrapAnywhere
                clip: true
                font.family: "Tahoma"
                Layout.maximumHeight: 150
                Layout.minimumHeight: 150
                Layout.fillWidth: true
                font.pixelSize: 12
            }

            Text {
                id: positionLabel
                color: "#ffffff"
                text: qsTr("")
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                enabled: false
                Layout.minimumHeight: 100
                Layout.maximumHeight: 100
                Layout.fillHeight: false
                Layout.fillWidth: true
                font.pixelSize: 12
            }

            RowLayout {
                id: rowLayout1
                Layout.preferredHeight: 48
                Layout.minimumHeight: 48
                Layout.maximumHeight: 48
                spacing: 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                Button {
                    id: prevButton
                    width: 50
                    height: 50
                    text: qsTr("")
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50

                    Image {
                        id: prevButtonImage
                        width: 30
                        height: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        fillMode: Image.PreserveAspectFit
                        source: "Images/prev.png"
                    }
                }

                Button {
                    id: playButton
                    width: 50
                    height: 50
                    text: qsTr("")
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    Image {
                        id: playButtonImage
                        width: 30
                        height: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        source: mediaPlayer.playbackState == MediaPlayer.PlayingState ? "Images/pause.png" : "Images/play.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Button {
                    id: nextButton
                    width: 50
                    height: 50
                    text: qsTr("")
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                    Image {
                        id: nextButtonImage
                        width: 30
                        height: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        source: "Images/next.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            anchors.fill: parent
        }
        anchors.topMargin: 0
    }

    Connections {
        target: mouseArea1
        onClicked: playbackPage.state = (playbackPage.state == "" ? "fullscreen" : "")
    }

    states: [
        State {
            name: ""

            PropertyChanges {
                target: leftFrame
                anchors.leftMargin: 0
            }

            PropertyChanges {
                target: videoSlider
                width: 400
                anchors.rightMargin: 100
                opacity: 1
            }

            PropertyChanges {
                target: appWindow
                fullscreen: false
            }
        },
        State {
            name: "fullscreen"

            PropertyChanges {
                target: leftFrame
                anchors.leftMargin: -200
            }

            PropertyChanges {
                target: videoSlider
                width: 0
                anchors.rightMargin: 300
                opacity: 0
            }

            PropertyChanges {
                target: appWindow
                fullscreen: true
            }
        }
    ]
}
