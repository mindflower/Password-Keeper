import QtQuick 2.0
import QtQuick.Controls.Material 2.1

Item{
    id : root
    width: parent.width
    height: is_double ? 56 + 72 : 56
    property alias title: txt_title.text
    property alias tools: rect_tools.children
    property alias second_tools: rect_tools2.children
    property alias subhead: txt_subhead.text
    property bool is_double : second_tools.length > 0 || subhead.length>0

    Shadow{
        target: rect_0
        size: 4
    }

    Rectangle{
        id: rect_0
        color: Material.primaryColor

        width: root.width
        height: is_double ? 56 + 72 : 56

        Item{
            id: rect_1
            width: root.width
            height: 56

            TitleText{
                id: txt_title
                x: 26
                text: ""
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }

            Item{
                anchors.verticalCenter: parent.verticalCenter
                height: 44
                width: childrenRect.width
                anchors.right: parent.right
                anchors.rightMargin: 16
                Row{
                    id: rect_tools
                }
            }
        }

        Item{
            y:56
            id: rect_2
            width: root.width-62-16
            x: 62
            height: 72
            TitleText{
                id: txt_subhead
                text: ""
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
            Item{
                anchors.right: parent.right
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                width: childrenRect.width
                Row{
                    id: rect_tools2
                }

            }
        }
    }
}
