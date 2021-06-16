import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ctse/editMovies.dart';
import 'package:movie_app_ctse/login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'movie_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(new MaterialApp(
    home: new MyApp(),
    routes: {
        MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
        EditMoviePage.editRouteName: (ctx) => EditMoviePage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new DashboardScreen(),
        title: new Text('Welcome In Movie App',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.asset('images/movie_icon.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: DashboardScreen(),
//       routes: {
//         MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
//       },
//     );
//   }
// }
