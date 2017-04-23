import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: button

    font.pixelSize: 14

    background: Rectangle {
        color: button.pressed ? "#a2a2a2" : "#f2f2f2"
        border.width: 1
        border.color: "#909090"
        radius: 5
        implicitWidth: 100
        implicitHeight: 40
    }
}
