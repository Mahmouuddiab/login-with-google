import 'package:dartz/dartz.dart';
import 'package:login_with_google/core/failure/failure.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}