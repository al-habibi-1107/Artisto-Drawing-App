import 'dart:ui';

import 'package:flutter/material.dart';

class Paintbrush extends CustomPainter {
  List<Offset> points;

  Paintbrush({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final background = Paint()..color = Colors.white;
    canvas.drawRect(rect, background);

    final painter = Paint()
      ..strokeWidth = 4
      ..color = Colors.black;

    for (var x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        // print(points[x]);
        canvas.drawLine(points[x], points[x + 1], painter);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[x]], painter);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
