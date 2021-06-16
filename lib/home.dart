import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ctse/addMovie.dart';
import 'package:movie_app_ctse/dashboard_screen.dart';
import 'package:movie_app_ctse/play_page.dart';
import 'package:movie_app_ctse/viewMovies.dart';

import 'models/clips.dart';
import 'models/user.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  BuildContext _ctx;
  final AppUser user;
  HomePage({Key key, @required this.user}) : super(key: key);

  //----UI Start----//
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var menuBtn = new RaisedButton(
      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      onPressed: _navigateVideos,
      child: new Text("Watch Trailers"),
      color: Colors.blue,
    );

    var btn1 = new RaisedButton(
      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      onPressed: _btnPressed,
      child: new Text("Btn 1"),
      color: Colors.green,
    );

    var btn2 = new RaisedButton(
      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      onPressed: _btnPressed,
      child: new Text("Btn 2"),
      color: Colors.green,
    );

    var welcomeTxt = new Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 70.0),
      child: new Text("Welcome ${user.name}",),
    );

    return Scaffold(
      body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  welcomeTxt,
                  Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              side: BorderSide(color: Colors.black45, width: 1)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => AddMoviePage()),
                            );
                          },
                          minWidth: 240,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            "Add Movies",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              side: BorderSide(color: Colors.black45, width: 1)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => ViewMoviesScreen()),
                            );
                          },
                          minWidth: 240,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            "Edit Movies",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              side: BorderSide(color: Colors.black45, width: 1)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => DashboardScreen()),
                            );
                          },
                          minWidth: 240,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            "HOME",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
  //----UI End----//

  void _btnPressed(){
  }

  void _navigateVideos() {
    int age = int.parse(user.age);
    int weight = int.parse(user.weight);
    if(true){
      Navigator.push(_ctx, CupertinoPageRoute(builder: (context) => PlayPage(clips: VideoClip.Clips18_28)),);
    }

  }
}






