import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.1
import "std"

Item {
    id: root
    width: parent.width
    height: 60
    property alias account: accountText.text
    property alias login: loginText.text
    property string password: ""
    property bool hidden: true

    Row {
        width: root.width
        height: root.height
        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: 120
            TitleText {
                id: accountText
                x: 30
                color: "black"
            }
            MediumText {
                id: loginText
                x: 30
                color: "black"
                font.pixelSize: 14
                opacity: 0.7
            }
        }
        TextInput {
            id: passwordText
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: TextInput.AlignHCenter
            enabled: false
            width: 350
            color: "black"
            opacity: 0.7
            font.pixelSize: 20
            font.letterSpacing: 0.5
            selectByMouse: true
            selectionColor: Material.accentColor
            text: hidden ? "************" : root.password
            echoMode: hidden ? TextInput.Password : TextInput.Normal
        }
        ToolButton{
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/qml/icons/eye.svg"
            icon.color: "black"
            opacity: 0.7
            onClicked: {
                hideTimer.stop()
                if (hidden) {
                    hidden = false
                    hideTimer.start()
                }
                else {
                    hidden = true
                }
            }
        }
        ToolButton{
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/qml/icons/copy.svg"
            icon.color: "black"
            opacity: 0.7
            onClicked: passwordText.copy()
        }
    }
    Divider{}
    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.hidden = true
    }
}
