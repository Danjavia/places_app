import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  final String id;
  final String email;
  final String country;
  final String createdAt;
  final String updatedAt;

  AppUser({
    Key key,
    @required this.id,
    this.email,
    @required this.country,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory AppUser.fromMap(Map data) {
    data = data ?? { };
    return AppUser(
      id: data['id'],
      email: data['email'],
      country: data['country'],
    );
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    doc = doc ?? { };
    Map data = doc.data as Map;

    return AppUser(
      id: doc.id,
      email: data['email'],
      country: data['country'],
    );
  }
}