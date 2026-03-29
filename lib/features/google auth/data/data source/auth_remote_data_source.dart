import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future <UserModel?> currentUser();
}