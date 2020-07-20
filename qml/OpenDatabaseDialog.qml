import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.1
import "std"

MaterialDialog {
    id: root
    visible: false
    title: "Open database"
    width: 500
    property bool opened: false
    content: Column {
        Row{
            Text{
                width: 130
                y: 13
                opacity: 0.38
                text: "Database path"
            }
            MaterialTextField{
                id: databaseField
                width: 280
                hint: "Input database path"
                tooltip: "Empty database path"
                text: applicationDirPath + "/database.sqlite"
                onTextChanged: {correct = text.length != 0}
            }
            ToolButton{
                icon.source: "qrc:/qml/icons/file.svg"
                icon.color: "black"
                opacity: 0.87
                onClicked: {fileDialog.open()}
            }
        }
        Row{
            Text{
                width: 130
                y: 13
                opacity: 0.38
                text: "Password"
            }
            MaterialTextField{
                id: passwordField
                width: 190
                hint: "Input password"
                tooltip: "Empty password"
                echoMode: TextInput.Password
                onTextChanged: {correct = text.length != 0}
            }
        }
    }

    actions: Row {
        FlatButton{
            text: "Cancel"
            color: Material.accentColor
            onClicked: {
                parent.resetAndClose()
            }
        }
        FlatButton{
            text: "Open"
            color: Material.accentColor
            onClicked: {
                databaseField.textChanged()
                passwordField.textChanged()
                var correct =
                        databaseField.correct &&
                        passwordField.correct
                if (correct) {
                    accountModel.openDatabase(databaseField.text, passwordField.text)
                    parent.resetAndClose()
                    root.opened = true
                }
            }
        }

        function resetAndClose() {
            root.visible = false
            databaseField.text = ""
            passwordField.text = ""
            databaseField.correct = true
            passwordField.correct = true
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a database"
        nameFilters: [ "SQLite files (*.sqlite)", "All files (*)" ]
        selectMultiple: false
        onAccepted: {
            var path = fileDialog.fileUrl.toString();
            path = path.replace(/^(file:\/{3})/,"");
            databaseField.text = path
        }
    }
}
