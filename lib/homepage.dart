import 'package:artisto/group_points.dart';
import 'package:flutter/material.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:wave_slider/wave_slider.dart';

import 'package:artisto/painter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroupPoints> points = [];

  Color _brushColor = Colors.black;
  double _penWidth = 3;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: device.width,
            height: device.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(52, 148, 230, 1),
                  Color.fromRGBO(236, 110, 173, 1)
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: device.width * 0.9,
                  height: device.height * 0.7,
                  child: GestureDetector(
                    onPanDown: (location) {
                      setState(() {
                        points = List.from(points)
                          ..add(
                            GroupPoints(
                                color: _brushColor,
                                offset: location.localPosition,
                                strokeWidth: _penWidth),
                          );

                        // _offsets.add(location.localPosition);
                      });
                    },
                    onPanUpdate: (location) {
                      setState(() {
                        points = List.from(points)
                          ..add(
                            GroupPoints(
                                color: _brushColor,
                                offset: location.localPosition,
                                strokeWidth: _penWidth),
                          );

                        // _offsets.add(location.localPosition);
                      });
                    },
                    onPanEnd: (location) {
                      setState(() {
                        points = List.from(points)
                          ..add(
                            GroupPoints(
                                color: _brushColor,
                                offset: null,
                                strokeWidth: _penWidth),
                          );
                        // _offsets.add(null);
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomPaint(
                        painter: Paintbrush(
                          brushColor: _brushColor,
                          penWidth: _penWidth,
                          newPoints: points,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: device.height * 0.04,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45)),
                  height: device.height * 0.08,
                  width: device.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.palette,
                            color: _brushColor,
                          ),
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              child: AlertDialog(
                                backgroundColor: Colors.white70,
                                content: Container(
                                  height: 220,
                                  child: OColorPicker(
                                    selectedColor: _brushColor,
                                    colors: primaryColorsPalette,
                                    onColorChange: (color) {
                                      setState(() {
                                        _brushColor = color;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                      Container(
                        width: device.width * 0.5,
                        height: 100,
                        child: WaveSlider(
                            displayTrackball: true,
                            sliderHeight: 50,
                            onChanged: (changeVal) {
                              setState(() {
                                _penWidth = changeVal * 7;
                              });
                            }),
                      ),
                      IconButton(
                          icon: Icon(Icons.layers),
                          onPressed: () {
                            setState(() {
                              points = [];
                            });
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
