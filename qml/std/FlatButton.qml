import QtQuick 2.0

Item{
    id: root
    property bool disabled: false
    property bool dark: false
    property color color : "#000000"
    property alias text: txt.text
    signal clicked()

    width : rect.width
    height: 32


    Rectangle{
        id: rect
        width: (txt.width + 16 ) < 64 ? 64 : txt.width + 16
        height: root.height
        color: dark ? p_300: "#03A9F4"

        radius: 2
        opacity: !disabled ? dark ? mouse.pressed ? 0.25 : mouse.containsMouse ? 0.15 : 0 : mouse.pressed ? 0.4 : mouse.containsMouse ? 0.2 : 0 : 0
    }
    Item{
        clip: true
        width: rect.width
        height: rect.height
        x: rect.x
        y: rect.y

        Ripple{
            id: ripple
            color: txt.color
            y:  rect.height/2
        }
    }

    ButtonText{
        id: txt
        color: root.color == "#000000" ? root.dark ? "white" : "black" : root.color
        text: "Button"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: dark ? disabled? 0.3 : 0.9 : disabled ? 0.26 : 0.9
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: !disabled
        onClicked: {
            root.clicked()
            ripple.x = mouse.x
            ripple.anim()
        }
    }
}
