import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import QtQuick.Extras 1.4

Item {
    id: settingsPage
    width: 800
    property alias leftFrame: leftFrame

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
        anchors.topMargin: 0

        ColumnLayout {
            id: leftFrameLayout
            anchors.fill: parent
            spacing: 0
            Label {
                id: titleLabel1
                color: "#ffffff"
                text: qsTr("Settings")
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
        }
    }


    Rectangle {
        id: background1
        x: 758
        y: 98
        color: "#dfdfdf"
        radius: 10
        anchors.rightMargin: -5
        anchors.leftMargin: -5
        anchors.bottomMargin: -5
        anchors.topMargin: -5
        enabled: false
        border.color: "#bfbfbf"
        anchors.top: columnLayout.top
        anchors.right: columnLayout.right
        anchors.bottom: columnLayout.bottom
        anchors.left: columnLayout.left
    }

    ColumnLayout {
        id: columnLayout
        height: 130
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.left: leftFrame.right

        Label {
            id: audioDeviceLabel
            text: qsTr("Audio output device:")
            font.underline: true
            font.pixelSize: 16
            Layout.fillWidth: true
            Layout.maximumHeight: 20
            Layout.minimumHeight: 20
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            font.bold: true
        }

        RadioButton {
            id: jackButton
            text: qsTr("Jack output")
            ButtonGroup.group: radioGroup
            checked: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        RowLayout {
            id: rowLayout
            width: 100
            height: 100
            Layout.fillWidth: true

            RadioButton {
                id: btButton
                text: qsTr("Bluetooth device")
                ButtonGroup.group: radioGroup
                Layout.columnSpan: 1
                Layout.fillWidth: true
                Layout.maximumHeight: 50
                Layout.minimumHeight: 50
                Layout.preferredHeight: 50
            }

            Button {
                id: scanButton
                text: qsTr("Scan")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: btButton.checked
            }
        }

        ButtonGroup {
            id: radioGroup
        }

    }


}
