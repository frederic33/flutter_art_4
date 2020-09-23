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

  /// Particles container
  List<Particle> particles = List<Particle>();

  /// Random generator instance
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  /// Animation controller
  Animation<double> animation;
  AnimationController controller;




  @override void initState() {

    super.initState();

    /// 🧩 Controller of Animation
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));

    /// 🧩 Animation Behaviour
    animation = Tween<double>(begin: 0, end:300).animate(controller)

    /// 🧩 Animation Listener
      ..addListener(() {
        if (this.particles.length == 0) {
          // create
          createBlobField();

        } else {
          // update
          setState(() {
            updateBlobField();
          });

        }
        setState(() {
          // The state that has changed here is the animation object's value
        });
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Art 3 Circles", style: TextStyle(fontSize: 20, color: Colors.black),),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SafeArea(

        child: Container(

          color: Colors.white,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomPaint(

                foregroundPainter: MyPainterCanvas(rgn, particles, animation.value),
                // painter: MyPainterCanvas(rgn, particles, animation.value),
                // child: Column(
                //   children: [
                //     SizedBox(height: 8),
                //     Text("radius factor : $radiusFactor", style: TextStyle(color: Colors.blueAccent),),
                //     Slider(
                //       value: radiusFactor,
                //       min: 1.0,
                //       max: 10.0,
                //       label: radiusFactor.toString(),
                //       // divisions: 0,
                //       onChanged: (value) {
                //         setState(() {
                //           // radiusFactor = value;
                //         });
                //       },
                //     ),
                //   ],
                // ),
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


  int particleCount = 50;
  Size size;
  Offset origin;
  double radius;

  void createBlobField() {

    // get the size of the screen
    size = MediaQuery.of(context).size;

    // center of the screen
    origin = Offset(size.width / 2, size.height / 2);

    radius = size.width;

    blobField(origin, radius);

  }

  void blobField(Offset origin, double radius) {

    while (particles.length < particleCount) {
      particles.add(newParticle(origin));
    }

  }

  Particle newParticle(Offset origin) {

    const double radius = 100;

    return Particle()
      ..color = Colors.grey
      ..radius = radius
      ..position = origin + getRandomPosition(radius)
    // for particle velocity
      ..theta = rgn.nextDouble() * 2 * pi
      ..speed = 0.1;
  }

  Offset getRandomPosition(double radius) {
    var t = rgn.nextDouble() * 2 * pi;
    return PolarToCartesian(radius, t);
  }


  Color _getRandomColor(Random rgn, double d, double a) {

    var a = 255;
    // sine => -1 to +1, we map that from 0 to 255
    var r = (sin(d * 2 * pi) * 127.0 + 127).toInt();
    var g = (cos(d * 2 * pi) * 127.0 + 127).toInt();
    var b = rgn.nextInt(255);
    return Color.fromARGB(a, r, g, b);

  }


  void updateBlobField() {


    // move the particles around in its orbit
    this.particles.forEach((p) {

      p.position += PolarToCartesian(p.speed, p.theta);

    });

    particles.add(newParticle(origin));

    while(particles.length > particleCount * 1.02) {
      particles.removeAt(0);
    }
  }



}


// End of file


/// 🧹TO DELETE
