///
/// Creation date: 23 September 2020 at 12:57
/// Created by: Frederic Crassat (crassat@orange.fr)
/// Project: coding_with_indy PART 4
/// Copyright (c) 2020

/// Imports
import 'package:flutter/material.dart';
import 'dart:math';

/// My Own Imports
import 'particle.dart';




class MyPainterCanvas extends CustomPainter {

  List<Particle> particles;
  Random rgn;
  Size canvasSize;

  Offset offset;
  final double W = 600.0;

  // Constructor
  MyPainterCanvas(this.rgn, this.particles, this.canvasSize) {

    offset = Offset(canvasSize.width / 2, canvasSize.height / 2 - W / 2);

  }

  @override
  void paint(Canvas canvas, Size size) {

    var dx1 = canvasSize.width / 2 - W / 2;
    var dy1 = canvasSize.height / 2 - W / 2;

    var dx2 = canvasSize.width / 2 + W / 2;
    var dy2 = canvasSize.height / 2 - W / 2;


    /// 1. Draw the Particles

    this.particles.forEach((p) {

      var paint = Paint();
      paint.strokeWidth = 5.0;
      paint.color = p.color;
      paint.style = PaintingStyle.stroke;
      //paint.blendMode = BlendMode.modulate;
      paint.blendMode = BlendMode.xor;

      canvas.drawCircle(p.position + offset, p.radius, paint);

      var pleft = p.origin + Offset(dx1, dy1);
      canvas.drawLine(pleft, p.position + offset, paint);

      var pright = p.origin + Offset(dx2, dy2);
      canvas.drawLine(pright, p.position + offset, paint);

    });


    /// 2. Draw the Frame
    drawFrame(canvas);


  }

  void drawFrame(Canvas canvas) {

    var center = Offset(canvasSize.width / 2, canvasSize.height / 2);

    var border = Paint()
      ..color = Colors.grey
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    var rect = Rect.fromCenter(center: center, width: W, height: W);
    canvas.drawRect(rect, border);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

/// Functions


}

// End of file


/// 🧹TO DELETE
