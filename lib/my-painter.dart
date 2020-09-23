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

          // setState(() {
          //   updateBlobField();
          // });

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
    debugPrint("debug Size of Screen : $size");

    return Scaffold(
      body: CustomPaint(
        painter: MyPainterCanvas(rgn, this.particles, size),
      ),
      // // appBar: AppBar(
      // //   title: Text("Art 3 Circles", style: TextStyle(fontSize: 20, color: Colors.black),),
      // //   backgroundColor: Colors.deepOrangeAccent,
      // // ),
      // body: SafeArea(
      //
      //   child: Container(
      //
      //     color: Colors.white,
      //
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //
      //         CustomPaint(
      //
      //           foregroundPainter: MyPainterCanvas(rgn, particles, MediaQuery.of(context).size),
      //           // painter: MyPainterCanvas(rgn, particles, animation.value),
      //           // child: Column(
      //           //   children: [
      //           //     SizedBox(height: 8),
      //           //     Text("radius factor : $radiusFactor", style: TextStyle(color: Colors.blueAccent),),
      //           //     Slider(
      //           //       value: radiusFactor,
      //           //       min: 1.0,
      //           //       max: 10.0,
      //           //       label: radiusFactor.toString(),
      //           //       // divisions: 0,
      //           //       onChanged: (value) {
      //           //         setState(() {
      //           //           // radiusFactor = value;
      //           //         });
      //           //       },
      //           //     ),
      //           //   ],
      //           // ),
      //         ),
      //
      //
      //       ],
      //     ),
      //   ),
      //
      // ),
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

  double W = 600.0;
  double Step = 10.0;
  double radiusParticle = 10;
  Color colorParticle = Colors.grey;

  void blobField() {

    for (var y = 1; y < W / Step; y++) {
      var x = 0.0;
      var p = Particle()
        ..radius = radiusParticle
        ..color  = colorParticle
        ..origin = Offset(x, y.toDouble());
      setParticle(p);
      particles.add(p);
      // debugPrint("create particle with offset : ${p.position}");
    }

  }

  void setParticle(Particle p) {
    var x = p.origin.dx;
    var y = p.origin.dy * Step;
    var px = x;
    var py = y;
    p.position = Offset(px, py);
  }

  Particle newParticle(Offset origin) {

    const double radius = 100;

    return Particle()
      ..color = Colors.grey
      ..radius = radius
      ..position = origin + getRandomPosition(radius);
    // for particle velocity
      // ..theta = rgn.nextDouble() * 2 * pi
      // ..speed = 0.1;
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


  void updateBlobField() {


    // // move the particles around in its orbit
    // this.particles.forEach((p) {
    //
    //   p.position += polarToCartesian(p.speed, p.theta);
    //
    // });
    //
    // particles.add(newParticle(origin));
    //
    // while(particles.length > particleCount * 1.02) {
    //   particles.removeAt(0);
    // }


  }



}


// End of file


/// 🧹TO DELETE
