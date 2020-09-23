///
/// Creation date: 23 September 2020 at 12:57
/// Created by: Frederic Crassat (crassat@orange.fr)
/// Project: coding_with_indy PART 4
/// Copyright (c) 2020
///

/// Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// My Own Imports
import 'my-painter.dart';


void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrangeAccent, // status bar color
    systemNavigationBarColor: Colors.black, // navigation bar color
  ));

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Art 3',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: MyPainter(),

    );
  }
}



