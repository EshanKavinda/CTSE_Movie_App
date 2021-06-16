import 'package:flutter/material.dart';
import 'package:movie_app_ctse/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:movie_app_ctse/register.dart';

import 'home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageStatus {
  BuildContext _ctx;
  //create keys to handle form
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPageHandler _pageHanlder;

  _LoginPageState() {
    _pageHanlder = new LoginPageHandler(this);
  }

  //----UI Start----//
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    //login button
    var loginBtn = new ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(300, 50), //////// HERE
      ),
      onPressed: _submitLogin,
      child: new Text("Login"),
    );
    //register button
    var registerBtn = new ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.redAccent,
        onPrimary: Colors.white,
        shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(300, 50), //////// HERE
      ),
      onPressed: _register,
      child: new Text("Register"),
    );
    var loginForm = new Column(
      //Set Alingment
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //create login form
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                //Email text feild
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Email"),
                ),
              ),
              new Padding(
                //Password text feild
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),
        registerBtn
      ],
    );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.white10])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: new Text("             Login"),
          backgroundColor: Colors.blueGrey,
        ),
        key: scaffoldKey,
        //Create scroll view
        body: new SingleChildScrollView(
          child: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        ),
      ),
    );
  }
  //----UI End----//

  //Show login error massages
  @override
  void onLoginError(String error) {
    _showSnackBar(error);
  }

  //Login success method
  @override
  void onLoginSuccess(AppUser user) async {
    if (user.flaglogged == "logged") {
      _showSnackBar("Logged..");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              user: user,
            ),
            // MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
          ));
    } else {
      _showSnackBar("Error");
    }
  }

  //Register button on pressed method
  void _register() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
  }

  //Log in button on Pressed method
  void _submitLogin() {
    final form = formKey.currentState;

    //validate the form
    if (form.validate()) {
      setState(() {
        form.save();
        _pageHanlder.doLogin(_email, _password);
      });
    }
  }

  //show messages
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}


//Login page status methods
abstract class LoginPageStatus {
  void onLoginSuccess(AppUser user);
  void onLoginError(String error);
}

//Handle the login page
class LoginPageHandler {
  LoginPageStatus _view;
  LoginPageHandler(this._view);

  //login method
  doLogin(String useremail, String password) async {
    try {
      //create firebase auth instance
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: password);
      //check user status
      if (userCredential != null) {
        //Create realtime database referance
        final databaseRef = FirebaseDatabase.instance.reference();
        //read firebase realtime data
        databaseRef
            .child('users')
            .orderByChild("email")
            .equalTo(useremail)
            .once()
            .then((DataSnapshot snapshot) {
          print('Data : ${snapshot.value}');
          //Map data snapshot
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values) {
            var name = values["name"].toString();
            var email = values["email"].toString();
            var gender = values["gender"].toString();
            var age = values["age"].toString();
            var weight = values["weight"].toString();
            //Create user object
            AppUser user =
            AppUser.name(name, email, null, weight, gender, age, "logged");
            _view.onLoginSuccess(user);
          });
        });
      }
      //  Handle auth exceptions
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _view.onLoginError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _view.onLoginError('Wrong password provided for that user.');
      }
    }
  }
}
