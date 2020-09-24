import 'package:fast_noise/fast_noise.dart';
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
import 'my-painter-canvas.dart';



class MyPainter extends StatefulWidget {

  MyPainter({Key key}) : super(key: key);

  @override
  _MyPainterState createState() => _MyPainterState();

}



class _MyPainterState extends State<MyPainter> with SingleTickerProviderStateMixin {

  /// A. Particles container
  List<Particle> particles = List<Particle>();

  /// B. Animation controller
  Animation<double> animation;
  AnimationController controller;

  /// C. Random generator instance
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  // D. Constants
  final int durationInSeconds = 10;
  final double durationEndInMS = 300;

  double factor = 0.0;

  @override void initState() {

    super.initState();

    /// 🧩 Controller of Animation & Animation Behaviour
    controller = AnimationController(vsync: this, duration: Duration(seconds: durationInSeconds));
    animation = Tween<double>(begin: 0, end:durationEndInMS).animate(controller)

    /// 🧩 Animation Listener
      ..addListener(() {

        if (this.particles.length == 0) {   /// create

          createBlobField();

        } else {                            /// update

          setState(() {

            updateBlobField();

          });

        }

      })
    /// 🧩 Animation Status Listener
      ..addStatusListener((status) {
        setState(() {
          // The state that has changed here is the animation object's value
          if (status == AnimationStatus.completed) {

            controller.repeat();

          } else if (status == AnimationStatus.dismissed) {

            controller.forward();

          }

        });

      });

    controller.forward();



  }


  /// BUILD --------------
  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;


    return Scaffold(
      // body: CustomPaint(
      //   painter: MyPainterCanvas(rgn, this.particles, size),
      // ),
      //
      appBar: AppBar(
        title: Text("Art 4 Lignes ondulantes", style: TextStyle(fontSize: 20, color: Colors.black),),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SafeArea(

        child: Container(

          color: Colors.white,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomPaint(

                // foregroundPainter: MyPainterCanvas(rgn, particles, size),
                painter: MyPainterCanvas(rgn, particles, size),
                child: Column(
                  children: [
                    // SizedBox(height: 8),
                    // Text("radius factor : $factor", style: TextStyle(color: Colors.blueAccent),),
                    Slider(
                      value: factor,
                      min: 0.0,
                      max: 0.1,
                      label: factor.toString(),
                      onChanged: (value) {
                        setState(() {
                          factor = value;
                        });
                      },
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),

      ),
    );

  }

  /// DISPOSE --------------
  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }


  /// FUNCTIONS

  Size size;

  void createBlobField() {

    blobField();

  }

  double W              = 600.0;
  double Step           = 6.0;
  double radiusParticle = 3;
  Color colorParticle   = Colors.grey;

  void blobField() {

    for (var y = 1; y < W / Step; y++) {

      var x = 0.0;

      var p = Particle()
        ..position = Offset(x, y.toDouble())
        ..radius = radiusParticle
        ..color  = colorParticle
        ..origin = Offset(x, y.toDouble());

      particles.add(p);

    }

  }
  
  var perlin = PerlinNoise();
  

  void setParticle(Particle p) {

    var x = p.origin.dx;
    var y = p.origin.dy * Step;

    var xx = x * 0.2;
    var yy = y * 0.01;
    var zz = t * 0.5;

    var n = perlin.singlePerlin3(1942, xx, yy, zz);

    var dx = mapRange(n, 0, 1, -Step.toDouble(), Step.toDouble());
    var dy = mapRange(n, 0, 1, -Step.toDouble(), Step.toDouble());
    var px = x + dx;
    var py = y + dy;

    p.position = Offset(px, py);

  }



  double mapRange(double value, double min1, double max1, double min2, double max2) {

    double range1 = min1 - max1;
    double range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }



  Offset getRandomPosition(double radius) {
    var t = rgn.nextDouble() * 2 * pi;
    return polarToCartesian(radius, t);
  }


  Color _getRandomColor(Random rgn, double d, double a) {

    var a = 255;
    // sine => -1 to +1, we map that from 0 to 255
    var r = (sin(d * 2 * pi) * 127.0 + 127).toInt();
    var g = (cos(d * 2 * pi) * 127.0 + 127).toInt();
    var b = rgn.nextInt(255);
    return Color.fromARGB(a, r, g, b);

  }

  // ignore: non_constant_identifier_names
  Offset polarToCartesian(double speed, double theta) {

    return Offset(speed * cos(theta), speed * sin(theta));

  }

  var t = 0.0;
  final stepT = 0.001;

  void updateBlobField() {


   this.particles.forEach((p) {


     setParticle(p);

   });

   t += stepT + factor;

  }



}



// End of file


/// 🧹TO DELETE
