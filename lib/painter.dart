import 'dart:ui';

import 'package:artisto/group_points.dart';
import 'package:flutter/material.dart';

class Paintbrush extends CustomPainter {
  List<GroupPoints> newPoints;
  Color brushColor;
  double penWidth;

  Paintbrush({this.brushColor, this.penWidth, this.newPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..strokeCap = StrokeCap.round;

    for (var x = 0; x < newPoints.length - 1; x++) {
      painter..color = newPoints[x].color;
      painter..strokeWidth = newPoints[x].strokeWidth;

      if (newPoints[x].offset != null && newPoints[x + 1].offset != null) {
        // print(points[x]);
        canvas.drawLine(newPoints[x].offset, newPoints[x + 1].offset, painter);
      } else if (newPoints[x].offset != null &&
          newPoints[x + 1].offset == null) {
        canvas.drawPoints(PointMode.points, [newPoints[x].offset], painter);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
