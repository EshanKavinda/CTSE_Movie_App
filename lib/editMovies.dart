import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:movie_app_ctse/home.dart';


class EditMoviePage extends StatefulWidget {
  static const editRouteName = '/edit-movie-details';
  @override
  _EditMoviePageState createState() => new _EditMoviePageState();
}

class _EditMoviePageState  extends State<EditMoviePage> {
  BuildContext _ctx;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title, _description, _rating, _year, _duration, _imageUri;
  String _type = 'recommended';
  String movieId = "";

  @override
  Widget build(BuildContext context) {

    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _ratingController = TextEditingController();
    final TextEditingController _yearController = TextEditingController();
    final TextEditingController _durationController = TextEditingController();
    final TextEditingController _imageUrlController = TextEditingController();

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final imageUrl = routeArgs['imageUrl'];
    final description = routeArgs['description'];
    final rating = routeArgs['rating'];
    final year = routeArgs['year'];
    final duration = routeArgs['duration'];

    movieId = id;
    _titleController.text = title;
    _imageUrlController.text = imageUrl;
    _descriptionController.text = description;
    _ratingController.text = rating;
    _yearController.text = year;
    _durationController.text = duration;

    _ctx = context;
    var registerBtn = new ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(26.0, 10.0, 26.0, 10.0)),
        backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
      ),
      onPressed: _submit,
      child: new Text("UPDATE"),
    );

    var deleteBtn = new ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(26.0, 10.0, 26.0, 10.0)),
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      onPressed: _removeMovie,
      child: new Text("DELETE"),
    );


    var registerForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                child: new TextFormField(
                  controller: _titleController,
                  onSaved: (val) => _title = val,
                  decoration: new InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                child: new TextFormField(
                  controller: _descriptionController,
                  onSaved: (val) => _description = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                child: new TextFormField(
                  controller: _ratingController,
                  onSaved: (val) => _rating = val,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(labelText: "Rating"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Rating is required';
                    }else if(double.parse(value) < 0 || double.parse(value) > 5){
                      return 'Rating should be between 0 - 5';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                child: new TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _year = val,
                  decoration: new InputDecoration(labelText: "Year"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Year';
                    }else if(int.parse(value) <= 1950 || int.parse(value) > 2025){
                      return 'Date should be between 1950 - 2025';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 1.0),
                child: new Column(
                  children: <Widget>[
                    new Text("Type"),
                    new RadioListTile(
                      groupValue: _type,
                      title: Text('Recommended'),
                      value: 'recommended',
                      onChanged: (val) {
                        setState(() {
                          _type = val;
                        });
                      },
                    ),
                    new RadioListTile(
                      groupValue: _type,
                      title: Text('TopRated'),
                      value: 'female',
                      onChanged: (val) {
                        setState(() {
                          _type = val;
                        });
                      },
                    ),
                    new RadioListTile(
                      groupValue: _type,
                      title: Text('Best'),
                      value: 'best',
                      onChanged: (val) {
                        setState(() {
                          _type = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 30.0),
                child: new TextFormField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _duration = val,
                  decoration: new InputDecoration(labelText: "Duration (hour)"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Duration';
                    }else if(double.parse(value) <= 0.5 || double.parse(value) > 4){
                      return 'Duration should be between 0.5 - 5 hour';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 30.0),
                child: new TextFormField(
                  controller: _imageUrlController,
                  onSaved: (val) => _imageUri = val,
                  decoration: new InputDecoration(labelText: "Image Url"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter URL';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.fromLTRB(50.0, 1.0, 30.0, 50.0),
          child: new Center(
            child: new Row(
              children: [
                registerBtn,
                deleteBtn
              ],
            ),
    )

        )
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Movie"),
      ),
      key: scaffoldKey,
      body: new SingleChildScrollView(
        child: new Container(
          child: new Center(
            child: registerForm,
          ),
        ),
      ),
    );
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });

      try {
        final databaseRef = FirebaseDatabase.instance.reference(); //database reference object
        databaseRef.child('movies').child(movieId).update({
          'title': _title, 'description': _description, 'rating': _rating, 'year': _year, 'duration': _duration, 'type': _type, 'imageUri': _imageUri
        });
        _snakbar('Movie Update Success....');
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void _removeMovie() {
    try {
      final databaseRef = FirebaseDatabase.instance.reference(); //database reference object
      databaseRef.child('movies').child(movieId).remove();
      _snakbar('Movie Remove Success....');
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      });
    } catch (e) {
      print(e);
    }

  }

  void _snakbar(String msg){
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }


}