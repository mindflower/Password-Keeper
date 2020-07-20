import QtQuick 2.14
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import Qt.labs.qmlmodels 1.0
import "std"

ApplicationWindow {
    id: root
    maximumWidth: 600
    maximumHeight: 600
    minimumWidth: 600
    minimumHeight: 600
    title: "Password Keeper"
    flags: Qt.FramelessWindowHint
    visible: true

    Material.theme: Material.Light
    Material.accent: Material.LightBlue
    Material.foreground: Material.LightBlue
    Material.primary: Material.LightBlue

    Item {
        id: head
        width: root.width
        height: toolbar.height
        MouseArea {
            anchors.fill: parent;
            property variant clickPos: "1,1"

            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                root.x += delta.x;
                root.y += delta.y;
            }
        }
        Toolbar {
            id: toolbar
            title: "Password Keeper"
            subhead: "Accounts"
            tools: [
                ToolButton {
                    icon.source: "qrc:/qml/icons/close.svg"
                    icon.color: "white"
                    opacity: 0.87
                    onClicked: Qt.quit()
                }
            ]
            second_tools: [
                ToolButton {
                    icon.source: "qrc:/qml/icons/plus.svg"
                    icon.color: "white"
                    opacity: 0.87
                    visible: openDatabaseDialog.opened
                    onClicked: addAccountDialog.visible = true
                },
                ToolButton {
                    icon.source: "qrc:/qml/icons/database.svg"
                    icon.color: "white"
                    opacity: 0.87
                    onClicked: openDatabaseDialog.visible = true
                }
            ]
        }
    }


    Item {
        width: root.width
        height: root.height - toolbar.height
        anchors.top: head.bottom
        z: -1
        ListView {
            id: view
            width: parent.width
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            anchors.fill: parent
            model: accountModel
            delegate: AccountItem {
                account: model.account
                login: model.login
                password: model.password
            }
            ScrollBar.vertical: ScrollBar {}
        }
    }

    AddAccountDialog {id: addAccountDialog}
    OpenDatabaseDialog {id: openDatabaseDialog ; visible: true}
}
