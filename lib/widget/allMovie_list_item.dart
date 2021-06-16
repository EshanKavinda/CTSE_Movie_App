import 'package:flutter/material.dart';
import 'package:movie_app_ctse/editMovies.dart';
import 'package:movie_app_ctse/models/movie.dart';
import '../movie_details_screen.dart';
import '../viewMovies.dart';


class AllMoviesListItem extends StatelessWidget {
  final int index;
  AllMoviesListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  EditMoviePage.editRouteName,
                  arguments: {
                    'id': allMoviesArray[index].id,
                    'title': allMoviesArray[index].title,
                    'imageUrl': allMoviesArray[index].imageUrl,
                    'description': allMoviesArray[index].description,
                    'rating': allMoviesArray[index].rating,
                    'year': allMoviesArray[index].year,
                    'duration': allMoviesArray[index].duration,
                  },
                );
              },
              child: Card(
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: allMoviesArray[index].id,
                      child: Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              allMoviesArray[index].imageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            allMoviesArray[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 240,
                            child: Text(
                              allMoviesArray[index].description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
    );

  }
}
