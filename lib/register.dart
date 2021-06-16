import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app_ctse/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  BuildContext _ctx;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _email, _password, _weight, _age;
  String _gender = 'male';

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var registerBtn = new ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(150, 50), //////// HERE
      ),
      onPressed: _submit,
      child: new Text("Register"),
    );

    var registerForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 1.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Name"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 1.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Email"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 1.0),
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 1.0),
                child: new TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _weight = val,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Mobile Number"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 1.0),
                child: new Column(
                  children: <Widget>[
                    new Text("Gender"),
                    new RadioListTile(
                      groupValue: _gender,
                      title: Text('Male'),
                      value: 'male',
                      onChanged: (val) {
                        setState(() {
                          _gender = val;
                        });
                      },
                    ),
                    new RadioListTile(
                      groupValue: _gender,
                      title: Text('Female'),
                      value: 'female',
                      onChanged: (val) {
                        setState(() {
                          _gender = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                child: new TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _age = val,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Age"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your age';
                    } else if (int.parse(value) >= 60 ||
                        int.parse(value) < 18) {
                      return 'Your age should be between 18 - 60';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
          child: registerBtn,
        )
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Register"),
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
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        if (userCredential != null) {
          final databaseRef =
          FirebaseDatabase.instance.reference(); //database reference object
          databaseRef.child('users').push().set({
            'name': _name,
            'email': _email,
            'weight': _weight,
            'gender': _gender,
            'age': _age
          });
          _snakbar('Registration Success. Please login to system');
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          _snakbar('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          _snakbar('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _snakbar(String msg) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }
}
