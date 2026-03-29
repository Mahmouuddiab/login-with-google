import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:login_with_google/core/failure/failure.dart';
import 'package:login_with_google/core/usecase/usecase.dart';
import '../../domain/usecase/current_user.dart';
import '../../domain/usecase/sign_in_with_google.dart';
import '../../domain/usecase/sign_out.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  AuthCubit({
    required this.signInWithGoogle,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    checkAuth(); // 🔥 auto-run on app start
  }


  Future<void> checkAuth() async {
    emit(AuthLoading());

    final result = await getCurrentUser(NoParams());

    result.fold(
          (failure) => emit(AuthError(_mapFailureToMessage(failure))),
          (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  /// 🔑 Google Sign-In
  Future<void> googleSignIn() async {
    emit(AuthLoading());

    final result = await signInWithGoogle(NoParams());

    result.fold(
          (failure) => emit(AuthError(_mapFailureToMessage(failure))),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// 🚪 Sign Out
  Future<void> signOutUser() async {
    emit(AuthLoading());

    final result = await signOut(NoParams());

    result.fold(
          (failure) => emit(AuthError(_mapFailureToMessage(failure))),
          (_) => emit(AuthUnauthenticated()),
    );
  }

  /// 🧠 Error Mapping
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server communication failed';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}