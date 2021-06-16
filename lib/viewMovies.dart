import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ctse/widget/allMovie_list_item.dart';
import 'login.dart';
import 'models/movie.dart';

List<Movie> allMoviesArray = [];

class ViewMoviesScreen extends StatefulWidget {
  @override
  _ViewMoviesScreenState createState() => _ViewMoviesScreenState();
}

class _ViewMoviesScreenState extends State<ViewMoviesScreen> {
  DatabaseReference _movieRef;

  @override
  void initState() {
    super.initState();

    final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    _movieRef = dbRef.reference().child('movies');

    fetchMovies();
  }


  fetchMovies() async {
    allMoviesArray.clear();
    await _movieRef.once()
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
        allMoviesArray.add(new Movie(
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
      print('********Length :${allMoviesArray.length}');
      // allMoviesArray = List.from(bestMovieList);
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                ],
              ),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: allMoviesArray.length,
                itemBuilder: (ctx, i) => AllMoviesListItem(i),
              ),
            ),
            SizedBox(height: 30,),
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
