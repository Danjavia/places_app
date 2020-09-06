import 'package:custom_app/src/screens/home/home.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:custom_app/src/screens/sign/signup.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
  'login'   : (BuildContext context) => Login(),
  'signup'  : (BuildContext context) => Sign(),
  'home'    : (BuildContext context) => Home(),
};