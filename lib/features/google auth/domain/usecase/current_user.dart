import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}