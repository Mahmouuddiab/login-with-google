import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
  }) : super(
    uid: uid,
    email: email,
    displayName: displayName,
    photoURL: photoURL,
  );

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}