import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: button
    text: ""
    property string type: "prev"

    background: Rectangle {
        color: button.pressed ? "#a2a2a2" : "#f2f2f2"
        border.width: 1
        border.color: "#909090"
        radius: 5
        implicitWidth: 100
        implicitHeight: 40
    }

    Image {
        anchors.fill: parent
        anchors.margins: 5
        anchors.horizontalCenter: button.horizontalCenter
        anchors.verticalCenter: button.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "Images/" + button.type + ".png"
    }
}
