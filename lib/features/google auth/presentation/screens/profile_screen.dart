import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../domain/entity/user_entity.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(), // ✅ inject properly
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthAuthenticated) {
            final UserEntity user = state.user;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    user.displayName?? "",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    user.email ?? 'No Email',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOutUser(); // ✅ clean access
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
          }

          if (state is AuthUnauthenticated) {
            return const Center(child: Text('User not authenticated'));
          }

          if (state is AuthError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          // ✅ Better fallback
          return const Center(child: Text('Checking authentication...'));
        },
      ),
    );
  }
}