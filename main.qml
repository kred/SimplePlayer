import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import com.simpleplayer 1.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: 800
    height: 480
    title: qsTr("SimplePlayer")
    color: "#f1f1f1"


    property string currentPath
    property string currentName
    property int currentIndex : -1
    property bool fullscreen : false

    onCurrentIndexChanged: {
        if (currentIndex >= 0 && currentIndex < FilesDiscoveryModel.count)
        {
            currentPath = FilesDiscoveryModel.getPath(currentIndex)
            currentName = FilesDiscoveryModel.getName(currentIndex)
        }
    }

    MediaPlayer {
        id: mediaPlayer
        source: currentIndex >= 0 ? "file://" + currentPath : ""
        autoPlay: true

        onStatusChanged: if (status == MediaPlayer.EndOfMedia)
                             playNext()

        function playPause()
        {
            if (FilesDiscoveryModel.count > 0)
            {
                if (currentIndex == -1)
                {
                    currentIndex = 0
                }
                else
                {
                    if (mediaPlayer.playbackState == MediaPlayer.PlayingState)
                        mediaPlayer.pause()
                    else
                        mediaPlayer.play()
                }
            }
        }

        function playNext()
        {
            var newIndex = currentIndex + 1
            if (newIndex >= FilesDiscoveryModel.count)
                newIndex = 0
            currentIndex = newIndex
        }

        function playPrevious()
        {
            var newIndex = currentIndex - 1
            if (newIndex < 0)
                newIndex = FilesDiscoveryModel.count - 1
            currentIndex = newIndex
        }
    }



    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        background: Rectangle {
            id: swipeBackground
            color: "#a0a0a0"

            states: [
                State {
                    name: "fullscreen"
                    PropertyChanges {
                        target: swipeBackground
                        color: "#000000"
                    }
                }
            ]

            transitions: Transition {
                ColorAnimation {
                    duration: 500
                }
            }

            state: tabBar.currentIndex == 0 ? playbackPage.state : ""
        }

        PlaybackPage {
            id: playbackPage
        }

        FilesPage {
            id: filesPage
        }

        SettingsPage {
            id: settingsPage
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Player")
        }
        TabButton {
            text: qsTr("Files")
        }
        TabButton {
            text: qsTr("Settings")
        }

        states: State {
            name: "fullscreen"
            PropertyChanges {
                target: tabBar
                height: 0
            }
        }

        transitions: Transition {
            PropertyAnimation {
                target: tabBar
                property: "height"
                duration: 500
            }
        }

        state: currentIndex == 0 ? playbackPage.state : ""
    }

    Component.onCompleted: {
        FilesDiscoveryModel.scan()
    }

    Connections {
        target: FilesDiscoveryModel
        ignoreUnknownSignals: true
        onScanningChanged: {
            if (FilesDiscoveryModel.scanning == false)
            {
                enabled = false
                loadPosition();
                positionStorageTimer.start()
            }
        }
    }

    Timer {
        id: positionStorageTimer
        triggeredOnStart: false
        repeat: true
        interval: 60000
        onTriggered: savePosition()
    }

    Timer {
        id: fullscreenTimer
        triggeredOnStart: false
        repeat: false
        interval: 3000
        onTriggered: if (tabBar.currentIndex == 0) playbackPage.state = "fullscreen"
    }

    Timer {
        id: switchToPlaybackTimer
        triggeredOnStart: false
        repeat: false
        interval: 2000
        onTriggered: {
            if (tabBar.currentIndex != 0) tabBar.currentIndex = 0
            fullscreenTimer.start()
        }
    }

    function loadPosition()
    {
        SimpleStorage.load("position")
        appWindow.currentIndex = Qt.binding(function() { return FilesDiscoveryModel.getIndex(SimpleStorage.get("path")) })
        if (appWindow.currentIndex >= 0) {
            mediaPlayer.seek(SimpleStorage.get("time"))
            mediaPlayer.play()
            fullscreenTimer.start()
        }
    }

    function savePosition()
    {
        SimpleStorage.load("position")
        SimpleStorage.set("path", currentPath)
        SimpleStorage.set("time", mediaPlayer.position)
        SimpleStorage.save("position")
    }
}
