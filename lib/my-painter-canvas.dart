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


// ignore: non_constant_identifier_names
Offset PolarToCartesian(double radius, double theta) {

  return Offset(radius * cos(theta), radius * sin(theta));

}


class MyPainterCanvas extends CustomPainter {

  List<Particle> particles;
  Random rgn;
  double animationValue;

  // Constructor
  MyPainterCanvas(this.rgn, this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {

    this.particles.forEach((p) {

      // Paint the objects
      var paint = Paint();
      //paint.strokeWidth = 10;
      //paint.style = PaintingStyle.stroke;
      paint.blendMode = BlendMode.modulate; //modulate, xor,
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);

    });


  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

/// Functions


}

// End of file


/// 🧹TO DELETE
