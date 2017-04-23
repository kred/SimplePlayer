import QtQuick 2.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import com.simpleplayer 1.0
import QtQuick.Extras 1.4

Item {
    id: filesPage
    width: 800
    height: 480
    property alias leftFrame: leftFrame
    property alias filesView: filesView
    property alias scanButton: scanButton

    Frame {
        id: leftFrame
        width: 200
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        background: Rectangle {
            color: "black"
        }

        ColumnLayout {
            id: leftFrameLayout
            anchors.fill: parent

            Label {
                id: titleLabel
                color: "#ffffff"
                text: qsTr("Files")
                Layout.rowSpan: 1
                font.family: "Tahoma"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                verticalAlignment: Text.AlignVCenter
                font.underline: false
                font.bold: true
                font.pixelSize: 32
            }

            ColumnLayout {
                id: countTextLayout
                width: 100
                height: 100
                spacing: 0
                Layout.rowSpan: 3
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true

                Label {
                    id: label1
                    color: "#ffffff"
                    text: qsTr("Found")
                    font.pixelSize: 12
                    Layout.fillWidth: true
                }

                Label {
                    id: label2
                    color: "#ffffff"
                    text: FilesDiscoveryModel.count
                    font.pixelSize: 14
                    wrapMode: Text.WrapAnywhere
                    Layout.fillWidth: true
                }

                Label {
                    id: label3
                    color: "#ffffff"
                    text: qsTr("media files")
                    font.pixelSize: 12
                    Layout.fillWidth: true
                }
            }

            PushButton {
                id: scanButton
                text: qsTr("Scan")
                Layout.preferredHeight: 48
                Layout.minimumHeight: 48
                Layout.maximumHeight: 48
                Layout.maximumWidth: 200
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        x: 627
        y: 8
        width: 128
        height: 128
        anchors.horizontalCenter: filesView.horizontalCenter
        anchors.verticalCenter: filesView.verticalCenter
        running: FilesDiscoveryModel.scanning
    }

    ListView {
        id: filesView
        anchors.bottomMargin: 15
        anchors.topMargin: 15
        anchors.rightMargin: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5
        clip: true
        delegate: FilesViewDelegate {
        }
        anchors.left: leftFrame.right
        boundsBehavior: Flickable.StopAtBounds
        model: FilesDiscoveryModel
        highlightFollowsCurrentItem: true
    }
}
