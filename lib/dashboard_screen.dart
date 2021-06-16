import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ctse/widget/horizontal_list_item.dart';
import 'package:movie_app_ctse/widget/top_rated_list_item.dart';
import 'package:movie_app_ctse/widget/vertical_list_item.dart';
import 'login.dart';
import 'models/movie.dart';

List<Movie> recommendedMovies = [];

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DatabaseReference _movieRef;

  @override
  void initState() {
    super.initState();

    final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    _movieRef = dbRef.reference().child('movies');

    fetchMovies();
  }


  fetchMovies() async {
    recommendedMovies.clear();
   await _movieRef.orderByChild("type")
        .equalTo("recommended")
        .once()
        .then((DataSnapshot snapshot) async {
      print('Data : ${snapshot.value}');
      Map <dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        var id = key.toString();
        var title = values["title"].toString();
        var description = values["description"].toString();
        var duration = values["duration"].toString();
        var rating = values["rating"].toString();
        var year = values["year"].toString();
        var imageUri = values["imageUri"].toString();
        recommendedMovies.add(new Movie(
            id: id,
            title: title,
            imageUrl: imageUri,
            description: description,
            rating: rating,
            year: year,
            duration: duration
        ));
      });
    });

    setState(() {
      print('********Length :${recommendedMovies.length}');
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedMovies.length,
                itemBuilder: (ctx, i) => HorizontalListItem(i),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Best of 2019',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: bestMovieList.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Top Rated Movies',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedMovieList.length,
                itemBuilder: (ctx, i) => TopRatedListItem(i),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        },
        child: Icon(
          Icons.people,
        ),
      ),
    );
  }





}
