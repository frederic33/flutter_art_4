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


    /// 1. Draw the Particles

    this.particles.forEach((p) {

      var paint = Paint();
      paint.strokeWidth = 2.0;
      paint.color = p.color;
      paint.style = PaintingStyle.stroke;
      paint.blendMode = BlendMode.difference;
      canvas.drawCircle(p.position + offset, p.radius, paint);

    });


    /// 2. Draw the Frame

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
