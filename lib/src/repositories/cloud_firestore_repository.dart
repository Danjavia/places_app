import 'package:custom_app/src/models/user.dart';
import 'package:custom_app/src/repositories/cloud_firestore_api.dart';

class CloudFirestoreRespository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  // Create new user
  void createUser(AppUser user) => _cloudFirestoreAPI.createUser(user);

  // sign out user
  void signOut() => _cloudFirestoreAPI.signOut();

  // get cars
  Stream getUser(String userId) => _cloudFirestoreAPI.getUser(userId);

  // update user data
  void updateUserDataFirestore(Map<String, dynamic> data) => _cloudFirestoreAPI.updateUserData(data);
}