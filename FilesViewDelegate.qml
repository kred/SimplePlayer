import QtQuick 2.4

FilesViewDelegateForm {
    color: filesView.currentIndex == index ? "#ff0000" : "#000000"
    Connections {
        target: mouseArea
        onClicked: {
            appWindow.currentIndex = index
            switchToPlaybackTimer.start()
        }
    }
}
