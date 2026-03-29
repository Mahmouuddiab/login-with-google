import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:login_with_google/core/failure/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data source/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final remoteUser = await remoteDataSource.signInWithGoogle();
      return Right(remoteUser);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.currentUser();

      if (userModel == null) {
        return const Right(null);
      }

      return Right(userModel); // ✅ UserModel extends UserEntity
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}