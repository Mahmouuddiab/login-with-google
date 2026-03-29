import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_google/core/di/di.dart';
import 'package:login_with_google/features/google%20auth/presentation/screens/home_screen.dart';
import 'package:login_with_google/features/google%20auth/presentation/screens/profile_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to HomeScreen when user is authenticated
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthUnauthenticated || state is AuthInitial) {
              return _buildUnauthenticatedView(context);
            }

            if (state is AuthError) {
              return _buildErrorView(context, state.message);
            }

            // While navigating, we can show a loader
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildUnauthenticatedView(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => authCubit.googleSignIn(),
        label: const Text('Sign in with Google'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => authCubit.googleSignIn(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}