import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:login_with_google/core/failure/failure.dart';
import 'package:login_with_google/core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

@injectable
class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}