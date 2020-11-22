import 'package:flutter/material.dart';
import 'package:o_color_picker/o_color_picker.dart';

import 'package:artisto/painter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _offsets = [];
  Color _brushColor = Colors.black;

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
                        _offsets.add(location.localPosition);
                      });
                    },
                    onPanUpdate: (location) {
                      setState(() {
                        _offsets.add(location.localPosition);
                      });
                    },
                    onPanEnd: (location) {
                      setState(() {
                        _offsets.add(null);
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomPaint(
                        painter: Paintbrush(
                            points: _offsets, brushColor: _brushColor),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      IconButton(
                          icon: Icon(Icons.layers),
                          onPressed: () {
                            setState(() {
                              _offsets = [];
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
