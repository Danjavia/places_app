import 'package:custom_app/src/repositories/cloud_firestore_repository.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:custom_app/src/utils/mocks.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  Currency cop = Currency.create('COP', 0, invertSeparators: true, pattern: 'S0.000');

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
      body: Container(
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int position){
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(transactions[position]['description']),
                    subtitle: Text(transactions[position]['date']),
                    leading: Image(image: AssetImage('assets/images/transactions/comida.png')),
                    trailing: Text('${Money.fromInt(transactions[position]['price'], cop)}'),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
