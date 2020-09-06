import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future getStorage(key) async {
  final storage = new FlutterSecureStorage();
  dynamic value = await storage.read(key: key);
  return value;
}

Future setStorage(String key, dynamic value) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: key, value: value);
}

void deleteStorage(String key) async {
  final storage = new FlutterSecureStorage();
  await storage.delete(key: key);
}

void deleteAllStorage() async {
  final storage = new FlutterSecureStorage();
  await storage.deleteAll();
}

// Modal
Future<bool> showModal(BuildContext context, String title, Widget content, actions) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: Text(title),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
            ]
          ),
        ),
        contentPadding: EdgeInsets.all(25),
        actions: actions,
      );
    });
}

// Generate Firestore Id
String generateId() => Firestore.instance.collection('').document().documentID;