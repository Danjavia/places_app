import 'package:custom_app/src/screens/home/home.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:custom_app/src/utils/helpers.dart';
import 'package:custom_app/src/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _sheetController;
  bool _autoValidate = false;
  String _email;
  String _password;
  bool _loading = false;
  String errorMsg;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/sign/sign.png')),
                      SizedBox(height: 40.0),
                      CustomTextField(
                        onSaved: (input) {
                          _email = input;
                        },
                        validator: emailValidator,
                        icon: Icon(Icons.email),
                        hint: "Correo Electrónico",
                      ),
                      SizedBox(height: 10.0),
                      CustomTextField(
                        icon: Icon(Icons.lock),
                        obscure: true,
                        onSaved: (input) => _password = input,
                        validator: (input) => input.isEmpty ? "*Este campo es requerido" : null,
                        hint: "Contraseña",
                      ),
                      SizedBox(height: 10.0),
                      filledButton('Registrarme', Colors.white, Colors.deepPurple, Colors.deepPurple, Colors.white, _signup),
                      SizedBox(height: 10.0),
                      FlatButton(
                        child: Text(
                          'Ya tengo una cuenta',
                          style: GoogleFonts.overpass(
                              fontSize: 18.0
                          ),
                        ),
                        onPressed: () {
                          // Redirect to Login
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                                  (_) => false
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget filledButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        function();
      },
    );
  }

  void _signup() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      setState(() {
        this._loading = true;
      });
      try {
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print(user);
        // Redirect to Sign
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(user: user,)),
              (_) => false
        );
      } catch (error) {
        switch (error.code) {
          case "user-not-found":
            {
              setState(() {
                errorMsg =
                "El usuario ingresado no existe";

                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          case "wrong-password":
            {
              setState(() {
                errorMsg = "La contraseña es incorrecta";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              print(error.code);
              setState(() {
                errorMsg = error.code;
              });
            }
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
