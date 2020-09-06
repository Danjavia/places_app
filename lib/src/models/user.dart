import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String identification;
  final String phoneNumber;
  final String countryCode;
  final String country;
  final String currencyCode;
  final String createdAt;
  final String updatedAt;
  final String userType;
  final List<dynamic> soatNotifications;
  final List<dynamic> rtmNotifications;

  User({
    Key key,
    @required this.id,
    @required this.phoneNumber,
    this.name,
    this.email,
    @required this.identification,
    @required this.countryCode,
    @required this.country,
    @required this.currencyCode,
    @required this.createdAt,
    @required this.updatedAt,
    this.userType,
    this.soatNotifications,
    this.rtmNotifications,
  });

  factory User.fromMap(Map data) {
    data = data ?? { };
    return User(
      id: data['id'],
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'],
      identification: data['identification'],
      countryCode: data['countryCode'],
      country: data['country'],
      userType: data['userType'],
      soatNotifications: data['soatNotifications'],
      rtmNotifications: data['rtmNotifications'],
    );
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    doc = doc ?? { };
    Map data = doc.data as Map;

    return User(
      id: doc.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'],
      identification: data['identification'],
      countryCode: data['countryCode'],
      country: data['country'],
      userType: data['userType'],
      soatNotifications: data['soatNotifications'],
      rtmNotifications: data['rtmNotifications'],
    );
  }
}