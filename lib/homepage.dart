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

  bool isEnable = false;

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
                  height: device.height * 0.8,
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
              ],
            ),
          ),
          //PALLETE BUTTON
          AnimatedPositioned(
            bottom: 20,
            right: isEnable ? 80 : 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.palette,
                color: Colors.black,
              ),
              mini: true,
              key: ValueKey('paintcolor'),
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
              },
            ),
            duration: Duration(milliseconds: 300),
          ),
          // SIZE BUTTON
          AnimatedPositioned(
            bottom: 20,
            right: isEnable ? 130 : 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.circle,
                color: Colors.black,
              ),
              mini: true,
              key: ValueKey('paintcolor'),
              onPressed: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Container(
                        width: device.width * 0.5,
                        height: 100,
                        child: WaveSlider(
                            displayTrackball: true,
                            onChanged: (changeVal) {
                              setState(() {
                                _penWidth = changeVal * 5;
                              });
                            }),
                      ),
                    ));
              },
            ),
            duration: Duration(milliseconds: 300),
          ),
          // CLEAR BUTTON
          AnimatedPositioned(
            bottom: 20,
            right: isEnable ? 180 : 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.layers,
                color: Colors.black,
              ),
              mini: true,
              key: ValueKey('paintcolor'),
              onPressed: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text("Clear your canvas?"),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            points = [];
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                    ],
                  ),
                );
              },
            ),
            duration: Duration(milliseconds: 300),
          ),
          //Paint Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              key: ValueKey('paintbutton'),
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  isEnable = !isEnable;
                });
              },
              child: isEnable
                  ? Icon(
                      Icons.close,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.format_paint,
                      color: Colors.black,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
