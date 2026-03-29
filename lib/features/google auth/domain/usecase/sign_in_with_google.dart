import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:login_with_google/core/failure/failure.dart';
import 'package:login_with_google/core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class SignInWithGoogle implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}