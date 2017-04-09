import QtQuick 2.4
import com.simpleplayer 1.0

FilesPageForm {
    Binding {
        target: filesView
        property: "currentIndex"
        value: appWindow.currentIndex
    }

    Connections {
        target: scanButton
        onClicked: {
            mediaPlayer.stop()
            appWindow.currentIndex = -1
            FilesDiscoveryModel.scan()
        }
    }
}
