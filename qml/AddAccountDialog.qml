import QtQuick 2.15
import QtQuick.Controls.Material 2.1
import "std"

MaterialDialog {
    id: root
    visible: false
    title: "Adding account"
    width: 500
    content: Column {
        Row{
            Text{
                width: 130
                y: 13
                opacity: 0.38
                text: "Account"
            }
            MaterialTextField{
                id: accountField
                width: 200
                hint: "Input account name"
                tooltip: "Empty account name"
                onTextChanged: {correct = text.length != 0}
            }
        }
        Row{
            Text{
                width: 130
                y: 13
                opacity: 0.38
                text: "Login"
            }
            MaterialTextField{
                id: loginField
                width: 200
                hint: "Input login"
                tooltip: "Empty login"
                onTextChanged: {correct = text.length != 0}
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
                width: 200
                hint: "Input password"
                tooltip: "Empty password"
                onTextChanged: {correct = text.length != 0}
            }
            FlatButton {
                text: "Generate"
                onClicked: {
                    var result = "";
                    var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()";
                    var charactersLength = characters.length;
                    for ( var i = 0; i < 20; i++ ) {
                       result += characters.charAt(Math.floor(Math.random() * charactersLength));
                    }
                    passwordField.text = result
                }
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
            text: "Add"
            color: Material.accentColor
            onClicked: {
                accountField.textChanged()
                loginField.textChanged()
                passwordField.textChanged()
                var correct =
                        accountField.correct &&
                        loginField.correct &&
                        passwordField.correct
                if (correct) {
                    accountModel.addAccount(accountField.text, loginField.text, passwordField.text)
                    parent.resetAndClose()
                }
            }
        }

        function resetAndClose(){
            root.visible = false
            accountField.text = ""
            loginField.text = ""
            passwordField.text = ""
            accountField.correct = true
            loginField.correct = true
            passwordField.correct = true
        }
    }
}
