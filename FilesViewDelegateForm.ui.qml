import QtQuick 2.4

Item {
    id: item1
    width: filesView.width
    height: 30
    property alias mouseArea : mouseArea
    property alias color : text1.color

    Text {
        id: text1
        text: name
        font.family: "Tahoma"
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.left: parent.left
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
