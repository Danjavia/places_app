import 'package:custom_app/src/repositories/cloud_firestore_repository.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:flutter/material.dart';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              child: Icon(Icons.exit_to_app, size: 25.0, color: Colors.white,),
              onTap: () {
                _cloudFirestoreRepository.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (_) => false
                );
              },
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
