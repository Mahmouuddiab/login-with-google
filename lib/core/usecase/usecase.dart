import 'package:dartz/dartz.dart';
import 'package:login_with_google/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}