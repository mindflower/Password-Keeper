import QtQuick 2.15
import QtQuick.Controls.Material 2.1

Item{
    id: root
    width: parent.width
    height: clmn.childrenRect.height

    property alias text: txt.text
    property alias echoMode: txt.echoMode
    property alias enabled: txt.enabled
    property alias hint: txt_hint.text
    property alias tooltip: txt_tooltip.text
    property bool correct: true

    Column{
        id: clmn
        Item{
            width: root.width - clmn.x
            height: txt.height + 28
            clip: true

            Text{
                id: txt_hint
                y:12
                font.pixelSize: 16
                visible: !root.text.length
                opacity: 0.26
            }
            TextInput{
                id: txt
                width: root.width - clmn.x
                y: 12
                height: 19
                font.pixelSize: 16
                focus: true
                activeFocusOnTab: true
                wrapMode: Text.NoWrap
                opacity: root.disabled? 0.26 : 0.87
                selectByMouse: true
                selectionColor: Material.accentColor

                cursorDelegate: Rectangle{
                    width: 2
                    height: 16
                    color: root.correct? Material.accentColor : Material.color(Material.Pink)
                    visible: txt.activeFocus

                    NumberAnimation on opacity{
                        id: cursor_blink_anim
                        from: 6.0
                        to: -6.0
                        duration: 3000
                        loops: -1
                    }
                    onXChanged: cursor_blink_anim.restart()
                }

                onCursorRectangleChanged: ensureVisible(cursorRectangle)
                onTextChanged: root.textChanged()

                function ensureVisible(r){
                    txt.x = r.x < txt.width? 0 : txt.width - r.x - 2
                }
            }

            Rectangle{
                y: txt.y + txt.height + 8
                width: root.width  - clmn.x
                height: txt.activeFocus? 2: 1
                color: !root.correct ? Material.color(Material.Pink) : txt.activeFocus? Material.accentColor :"black"
                opacity: !root.correct ? 1:  txt.activeFocus? 1 : 0.12
                visible: true
            }


        }
        Item{
            width: 20
            height: 20
            Text{
                id: txt_tooltip
                text: ""
                y:-4
                height: 10
                visible: !root.correct
                color: Material.color(Material.Pink)
                font.pixelSize: 12
            }
        }
    }
}
