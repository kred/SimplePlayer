import QtQuick 2.7
import com.simpleplayer 1.0

PlaybackPageForm {
    transitions: Transition {
        ParallelAnimation {
            PropertyAnimation {
                target: leftFrame
                property: "anchors.leftMargin"
                duration: 500
            }

            PropertyAnimation {
                target: videoSlider
                properties: "anchors.rightMargin,width,opacity"
                duration: 500
            }
        }
    }


    Connections {
        target: videoSlider
        onPositionChanged: mediaPlayer.seek(videoSlider.position * mediaPlayer.duration)
    }

    Connections {
        target: appWindow
        onCurrentIndexChanged: appWindow.currentIndex >= 0 ?
                                        currentIndexLabel.text = (appWindow.currentIndex + 1) + "/" + FilesDiscoveryModel.count
                                      : currentIndexLabel.text = ""
    }

    Binding {
        target: videoSlider
        property: "value"
        value: mediaPlayer.position / mediaPlayer.duration
    }

    Binding {
        target: videoSlider
        property: "visible"
        value: appWindow.currentIndex >= 0
    }

    Connections {
        target: mediaPlayer
        onPositionChanged: appWindow.currentIndex >= 0 ? positionLabel.text = msToTimeCode(mediaPlayer.position) + " / " + msToTimeCode(mediaPlayer.duration) : positionLabel.text = ""
    }


    Connections {
        target: playButton
        onClicked: mediaPlayer.playPause()
    }

    Connections {
        target: nextButton
        onClicked: mediaPlayer.playNext()
    }

    Connections {
        target: prevButton
        onClicked: mediaPlayer.playPrevious()
    }

    function zeroPad(num, places) {
      var zero = places - num.toString().length + 1;
      return Array(+(zero > 0 && zero)).join("0") + num;
    }

    function msToTimeCode(t)
    {
        if (t < 0)
            return "00:00:00";
        var tsec = Math.floor(t / 1000);
        var hours = Math.floor(tsec / 3600);
        var minutes = Math.floor((tsec - hours * 3600) / 60);
        var seconds = (tsec - hours * 3600 - minutes * 60);
        return zeroPad(hours,2) + ":" + zeroPad(minutes,2) + ":" + zeroPad(seconds,2);
    }

}
