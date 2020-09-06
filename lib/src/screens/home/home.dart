import 'package:custom_app/src/screens/home/screens/restaurants.dart';
import 'package:custom_app/src/screens/home/screens/transactions.dart';
import 'package:custom_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  final user;
  Home({ Key key, this.user }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Restaurants(),
    Transactions(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            title: Text('restaurantes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Transacciones'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Hexcolor(purpleColor),
        onTap: _onItemTapped,
      ),
    );
  }
}
