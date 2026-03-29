// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/google%20auth/data/data%20source/auth_remote_data_source.dart'
    as _i696;
import '../../features/google%20auth/data/data%20source/auth_remote_data_source_impl.dart'
    as _i482;
import '../../features/google%20auth/data/repository/auth_repository_impl.dart'
    as _i341;
import '../../features/google%20auth/domain/repository/auth_repository.dart'
    as _i461;
import '../../features/google%20auth/domain/usecase/current_user.dart' as _i821;
import '../../features/google%20auth/domain/usecase/sign_in_with_google.dart'
    as _i222;
import '../../features/google%20auth/domain/usecase/sign_out.dart' as _i81;
import '../../features/google%20auth/presentation/cubit/auth_cubit.dart'
    as _i839;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i696.AuthRemoteDataSource>(
      () => _i482.AuthRemoteDataSourceImpl(
        googleSignIn: gh<_i116.GoogleSignIn>(),
        firebaseAuth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i461.AuthRepository>(
      () => _i341.AuthRepositoryImpl(
        remoteDataSource: gh<_i696.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i821.GetCurrentUser>(
      () => _i821.GetCurrentUser(gh<_i461.AuthRepository>()),
    );
    gh.factory<_i222.SignInWithGoogle>(
      () => _i222.SignInWithGoogle(gh<_i461.AuthRepository>()),
    );
    gh.factory<_i81.SignOut>(() => _i81.SignOut(gh<_i461.AuthRepository>()));
    gh.factory<_i839.AuthCubit>(
      () => _i839.AuthCubit(
        signInWithGoogle: gh<_i222.SignInWithGoogle>(),
        signOut: gh<_i81.SignOut>(),
        getCurrentUser: gh<_i821.GetCurrentUser>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i946.RegisterModule {}
