import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Rectangle {
    id: root
    visible: true
    width: 1366
    height: 768

    function updateValue() {
            //Enggine 1
            directionProp1.angle = mqttvalue.azimut1()
            rpmEngine1.value = mqttvalue.enginespeed1()
            rpmPropeller1.value = mqttvalue.propelerspeed1()
            fuel1.value = mqttvalue.fuel1() * 0.1
            temperature1.value = mqttvalue.temp1()
            depth1.text = mqttvalue.vdepth1()
            joystickUp1.value = mqttvalue.joyUD1()
            joystickRight1.value = mqttvalue.joyRL1()
            statusIndicator.active = mqttvalue.engineconect1()

            //Enggine 2
            directionProp2.angle = mqttvalue.azimut2()
            rpmEngine2.value = mqttvalue.enginespeed2()
            rpmPropeller2.value = mqttvalue.propelerspeed2()
            fuel2.value = mqttvalue.fuel2() * 0.1
            temperature2.value = mqttvalue.temp2()
            depth2.text = mqttvalue.vdepth2()
            joystickUp2.value = mqttvalue.joyUD2()
            joystickRight2.value = mqttvalue.joyRL2()
            statusIndicator1.active = mqttvalue.engineconect2()


            //WindCondition
            windDirection.angle = mqttvalue.directWind()
            windSpeed.value = mqttvalue.speedWind()
            statusIndicator2.active = mqttvalue.windconect()

            mqttvalue.maincontrol()
        }

    Item {
        id: container
        x: 0
        width: root.width
        height: root.height
        anchors.centerIn: parent

        Image {
            id: background
            x: -1
            y: -1
            source: "1.png"
        }

        Item {
            id: windCondition
            x: 538
            y: 282
            width: 291
            height: 291

            Gauge {
                id: windSpeed
                x: 230
                y: 75
                height: 200
                maximumValue: 20
                value: 0

                Text {
                    id: text2
                    x: 2
                    y: -18
                    color: "#ffffff"
                    text: qsTr("M/s")
                    font.bold: true
                    font.family: "Verdana"
                    font.pixelSize: 14
                }
            }

            Image {
                id: image
                x: 12
                y: 70
                width: 180*1.2
                height: 159*1.2

                source: "Wind.png"

                Image {
                    id: image1
                    x: 101
                    y: 44
                    source: "5.png"
                    transform: [
                        Rotation {
                            id: windDirection
                            origin.x: 11
                            origin.y: 49
                            angle: 0
                        }]
                }
            }

            StatusIndicator {
                id: statusIndicator2
                x: 10
                y: 58
                width: 50
                height: 30
                color: "#00ff00"
                active: true
            }
        }

        Item {
            id: firstEngine
            x: 33
            y: 42
            width: 425
            height: 686

            CircularGauge {
                id: rpmPropeller1
                height: 200
                x: 234
                y: 243
                width: 170
                value: 0
                maximumValue: 300
                visible: true

                style: DashboardGaugeStyleProp {}

                Image {
                    id: image2
                    x: 73
                    y: 59
                    source: "PropIcon.png"
                }
            }


            CircularGauge {
                id: rpmEngine1
                x: 18
                y: 243
                width: 170
                height: 200
                visible: true
                value: 0
                style: DashboardGaugeStyle {
                }
                maximumValue: 3000

                Image {
                    id: image3
                    x: 73
                    y: 55
                    source: "EngineIcon.png"
                }

            }


            Rectangle {
                id: rectangle
                x: 39
                y: 195
                width: 353
                height: 45
                color: "#243c4c"
                radius: 17
                border.width: 1

                Text {
                    id: text1
                    x: 25
                    y: 13
                    width: 94
                    height: 29
                    color: "#ffffff"
                    text: "Depth"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.pixelSize: 31
                    font.family: "Arial"
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 0.5
                    elide: Text.ElideNone
                }

                Text {
                    id: text4
                    x: 239
                    y: 8
                    width: 94
                    height: 29
                    color: "#ffffff"
                    text: "meter"
                    anchors.verticalCenterOffset: 0
                    font.pixelSize: 31
                    verticalAlignment: Text.AlignVCenter
                    lineHeight: 0.5
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    elide: Text.ElideNone
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: depth1
                    x: 130
                    y: 11
                    width: 94
                    height: 29
                    color: "#ffffff"
                    anchors.verticalCenterOffset: 0
                    font.pixelSize: 31
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    lineHeight: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    elide: Text.ElideNone
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            CircularGauge {
                id: temperature1
                x: 39
                value: 0
                maximumValue: 2
                y: 108
                width: 120
                height: 120

                style: IconGaugeStyle {
                    id: tempGaugeStyle

                    icon: "temperature-icon.png"
                    maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                    tickmarkLabel: Text {
                        color: "white"
                        visible: styleData.value === 0 || styleData.value === 1
                        font.pixelSize: tempGaugeStyle.toPixels(0.225)
                        text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                    }
                }
            }

            CircularGauge {
                id: fuel1
                value: 0
                maximumValue: 2
                y: 103
                width: 120
                x: 266
                height: 120

                style: IconGaugeStyle {
                    id: fuelGaugeStyle

                    icon: "fuel-icon.png"
                    minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                    tickmarkLabel: Text {
                        color: "white"
                        visible: styleData.value === 0 || styleData.value === 1
                        font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                        text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                    }
                }
            }

            Image {
                id: image5
                x: 86
                y: 430
                width: 179*1.3
                height: 159*1.3
                anchors.horizontalCenterOffset: -4
                anchors.horizontalCenter: parent.horizontalCenter
                source: "Prop.png"

                Image {
                    id: image6
                    x: 110
                    y: 52
                    source: "5.png"
                    transform: [
                        Rotation {
                            id: directionProp1
                            origin.x: 11
                            origin.y: 49
                            angle: 0
                        }]
                }
            }

            Slider {
                id: joystickUp1
                x: 39
                y: 455
                height: 200
                minimumValue: 0
                value: 1
                orientation: Qt.Vertical
                tickmarksEnabled: false
                stepSize: 1
                maximumValue: 2
            }

            Slider {
                id: joystickRight1
                x: 45
                y: 657
                width: 300
                height: 22
                minimumValue: 0
                anchors.horizontalCenter: parent.horizontalCenter
                value: 1
                activeFocusOnPress: false
                stepSize: 1
                maximumValue: 2
                tickmarksEnabled: false
            }

            StatusIndicator {
                id: statusIndicator
                x: 358
                y: 34
                width: 50
                height: 45
                color: "#00ff00"
                active: true
            }




        }

        Item {
            id: secondEngine
            x: 911
            y: 42
            width: 425
            height: 686
            CircularGauge {
                id: rpmPropeller2
                x: 234
                y: 243
                width: 170
                height: 200
                visible: true
                value: 0
                style: DashboardGaugeStyleProp {
                }
                Image {
                    id: image7
                    x: 73
                    y: 59
                    source: "PropIcon.png"
                }
                maximumValue: 300
            }

            CircularGauge {
                id: rpmEngine2
                x: 18
                y: 243
                width: 170
                height: 200
                minimumValue: 0
                stepSize: 0
                visible: true
                value: 0
                style: DashboardGaugeStyle {
                }
                Image {
                    id: image8
                    x: 73
                    y: 55
                    source: "EngineIcon.png"
                }
                maximumValue: 3000
            }

            Image {
                x: 86
                y: 430
                width: 179*1.3
                height: 159*1.3
                source: "Prop.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -4

                Image {
                    id: image9
                    x: 110
                    y: 51
                    source: "5.png"
                    transform: [
                        Rotation {
                            id: directionProp2
                            origin.x: 11
                            origin.y: 49
                            angle: 0
                        }]
                }
            }

            Rectangle {
                id: rectangle1
                x: 39
                y: 195
                width: 353
                height: 45
                color: "#243c4c"
                radius: 17
                border.width: 1
                Text {
                    id: text3
                    x: 25
                    y: 13
                    width: 94
                    height: 29
                    color: "#ffffff"
                    text: "Depth"
                    font.pixelSize: 31
                    verticalAlignment: Text.AlignVCenter
                    lineHeight: 0.5
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    elide: Text.ElideNone
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: text5
                    x: 239
                    y: 8
                    width: 94
                    height: 29
                    color: "#ffffff"
                    text: "meter"
                    anchors.verticalCenterOffset: 0
                    font.pixelSize: 31
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    lineHeight: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    elide: Text.ElideNone
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: depth2
                    x: 130
                    y: 11
                    width: 94
                    height: 29
                    color: "#ffffff"
                    anchors.verticalCenterOffset: 0
                    font.pixelSize: 31
                    verticalAlignment: Text.AlignVCenter
                    lineHeight: 0.5
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    elide: Text.ElideNone
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            CircularGauge {
                id: temperature2
                x: 39
                y: 108
                width: 120
                height: 120
                value: 0
                style: IconGaugeStyle {
                    id: tempGaugeStyle1
                    tickmarkLabel: Text {
                        color: "#ffffff"
                        text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        visible: styleData.value === 0 || styleData.value === 1
                        font.pixelSize: tempGaugeStyle1.toPixels(0.225)
                    }
                    icon: "temperature-icon.png"
                    maxWarningColor: Qt.rgba(0.5, 0, 0, 1)
                }
                maximumValue: 2
            }

            CircularGauge {
                id: fuel2
                x: 266
                y: 103
                width: 120
                height: 120
                stepSize: 2
                value: 0
                style: IconGaugeStyle {
                    id: fuelGaugeStyle1
                    tickmarkLabel: Text {
                        color: "#ffffff"
                        text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        visible: styleData.value === 0 || styleData.value === 1
                        font.pixelSize: fuelGaugeStyle1.toPixels(0.225)
                    }
                    icon: "fuel-icon.png"
                    minWarningColor: Qt.rgba(0.5, 0, 0, 1)
                }
                maximumValue: 2
            }

            Slider {
                id: joystickUp2
                x: 39
                y: 455
                height: 200
                minimumValue: 0
                stepSize: 1
                orientation: Qt.Vertical
                value: 1
                maximumValue: 2
                tickmarksEnabled: false
            }

            Slider {
                id: joystickRight2
                x: 45
                y: 657
                width: 300
                height: 22
                minimumValue: 0
                stepSize: 1
                activeFocusOnPress: false
                anchors.horizontalCenter: parent.horizontalCenter
                value: 1
                tickmarksEnabled: false
                maximumValue: 2
            }

            StatusIndicator {
                id: statusIndicator1
                x: 18
                y: 34
                width: 50
                height: 45
                color: "#00ff00"
                active: true
            }
        }

    }

}
