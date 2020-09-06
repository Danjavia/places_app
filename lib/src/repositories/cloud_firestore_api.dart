import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_app/src/models/user.dart';
import 'package:custom_app/src/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {
  // Models
  final String USERS = 'users';

  // Firebase auth
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user
  void createUser(AppUser user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.id);

    setStorage('_userId', user.id);

    return await ref.set({
      'uid': user.id,
      'name': user.name ?? '',
      'email': user.email ?? '',
      'identification': user.identification ?? '',
      'phoneNumber': user.phoneNumber,
      'countryCode': '+57',
      'country': 'CO',
      'currency': 'COP',
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'updatedAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'userType': 'CUSTOMER'
    });
  }

  // sign out user
  void signOut() async {
    deleteStorage('_userId');
    await _auth.signOut();
  }

  // get user
  Stream getUser(userId) {
    print(userId);
    return _db
      .collection(USERS)
      .doc(userId)
      .snapshots();
  }

  // Update user data
  Future<void> updateUserData(Map<String, dynamic> data) async {
    User _user = _auth.currentUser;
    if (_user != null) {
      DocumentReference _userRef = _db.collection(USERS).document(_user.uid);

      // Update data in user collection
      await _userRef.updateData(data);
    }
  }
}