import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1
import com.iktwo.components 1.0
import "components" as ThisComponents
import "components/style.js" as Style

Item {
    id: root

    signal addToPlaylist()
    signal download()
    signal pressAndHold()

    function colorForKbps(kbps) {
        // 320, 256, 192, 128, 64
        if (kbps === 0)
            return "#2c3e50"
        else if (kbps < 64)
            return "#e74c3c"
        else if (kbps < 112)
            return "#d35400"
        else if (kbps < 128)
            return "#f39c12"
        else if (kbps < 192)
            return "#e67e22"
        else if (kbps < 256)
            return "#48C9B0"
        else if (kbps < 320)
            return "#27ae60"
        else
            return "#2ecc71"
    }

    height: 84 * ScreenValues.dp
    width: parent.width

    MouseArea {
        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
    }

    RowLayout {
        anchors.fill: parent

        Image {
            id: imageAlbum

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left; leftMargin: 8 * ScreenValues.dp
            }

            antialiasing: true
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            fillMode: Image.PreserveAspectCrop
            source: ""
        }

        Item {
            Layout.preferredWidth: 8 * ScreenValues.dp
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Label {
                id: songName

                font {
                    pixelSize: 14 * ScreenValues.dp
                    family: Theme.fontFamily
                }

                Layout.fillWidth: true
                color: Style.TEXT_COLOR_DARK
                elide: Text.ElideRight
                text: model.name
                renderType: Text.NativeRendering
                maximumLineCount: 1
            }

            RowLayout {
                Layout.fillWidth: true

                Label {
                    Layout.fillWidth: true

                    font {
                        pixelSize: 12 * ScreenValues.dp
                        family: Theme.fontFamily
                    }

                    elide: Text.ElideRight
                    color: Style.TEXT_SECONDARY_COLOR_DARK
                    text: model.artist
                    width: parent.width
                    renderType: Text.NativeRendering
                    maximumLineCount: 1
                    linkColor: Style.TEXT_SECONDARY_COLOR_DARK
                }

                Rectangle {
                    anchors.right: parent.right

                    radius: height * 0.1
                    color: colorForKbps(model.kbps)
                    Layout.preferredHeight: labelKbps.height * 1.1
                    Layout.preferredWidth: labelKbps.width * 1.1

                    Label {
                        id: labelKbps

                        anchors.centerIn: parent

                        font {
                            pixelSize: 12 * ScreenValues.dp
                            family: Theme.fontFamily
                        }

                        color: Style.TEXT_COLOR_LIGHT
                        elide: Text.ElideRight
                        renderType: Text.NativeRendering
                        maximumLineCount: 1
                        text: model.kbps + "kbps"
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                font {
                    pixelSize: 12 * ScreenValues.dp
                    family: Theme.fontFamily
                }

                elide: Text.ElideRight
                color: Style.TEXT_SECONDARY_COLOR_DARK
                width: parent.width
                renderType: Text.NativeRendering
                text: model.length
            }
        }

        RowLayout {
            id: row

            anchors.right: parent.right

            spacing: 4 * ScreenValues.dp
            Layout.preferredWidth: spacing + (48 * ScreenValues.dp * 2)
            Layout.fillHeight: true

            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 48 * ScreenValues.dp

                ImageButton {
                    anchors.fill: parent
                    source: "qrc:/images/" + Theme.getBestIconSize(Math.min(icon.height, icon.width)) + "add_to_playlist"
                    visible: model.url === "" ? false : true

                    onClicked: root.addToPlaylist()
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 48 * ScreenValues.dp

                ImageButton {
                    anchors.fill: parent
                    source: "qrc:/images/" + Theme.getBestIconSize(Math.min(icon.height, icon.width)) + "download"
                    visible: model.url === "" ? false : true

                    onClicked: root.download()
                }
            }
        }
    }

    Rectangle {
        color: "#55bdc3c7"
        height: 1 * ScreenValues.dp
        width: parent.width
    }
}
