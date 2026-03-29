import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      // ✅ Use Firebase's built-in provider (no GoogleSignIn() instance needed)
      final userCredential = await FirebaseAuth.instance.signInWithProvider(
        GoogleAuthProvider(),
      );

      final user = userCredential.user;
      if (user == null) throw Exception('User is null');

      return UserModel.fromFirebaseUser(user);

    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) return null;

      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }
}