import 'package:custom_app/src/repositories/cloud_firestore_repository.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transacciones'),
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
