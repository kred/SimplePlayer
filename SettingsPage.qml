import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Extras 1.4

SettingsPageForm {
    ButtonGroup {
        id: radioGroup
        buttons: [ jackButton, btButton ]
    }

    Binding {
        target: scanButton
        property: "visible"
        value: btButton.checked
    }


}
