import 'package:flutter/material.dart';
import '../movie_details_screen.dart';

import 'package:movie_app_ctse/dashboard_screen.dart';

class HorizontalListItem extends StatelessWidget {
  final int index;
  HorizontalListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: new SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MovieDetailsScreen.routeName,
              arguments: {
                'id': recommendedMovies[index].id,
                'title': recommendedMovies[index].title,
                'imageUrl': recommendedMovies[index].imageUrl,
                'description': recommendedMovies[index].description,
                'rating': recommendedMovies[index].rating,
                'year': recommendedMovies[index].year,
                'duration': recommendedMovies[index].duration,
              },
            );
          },
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10,
                child: Hero(
                  tag: recommendedMovies[index].id,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(recommendedMovies[index].imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                recommendedMovies[index].title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )

    );
  }
}
