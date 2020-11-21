import 'package:artisto/painter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _offsets = [];
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        // _offsets.add(null);
                      });
                    },
                    child: CustomPaint(
                      painter: Paintbrush(_offsets),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
