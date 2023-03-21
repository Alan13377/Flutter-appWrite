import 'package:appwrite_flutter/common/common.dart';
import 'package:appwrite_flutter/features/auth/controllers/auth_controller.dart';
import 'package:appwrite_flutter/features/auth/views/sign_up_view.dart';
import 'package:appwrite_flutter/features/home/views/home_view.dart';
import 'package:appwrite_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserProvider = ref.watch(currentUserAccountProvider);
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.theme,
      //*Persistencia de Sesion
      home: ref.watch(currentUserAccountProvider).when(
          data: (data) {
            if (data != null) {
              print(data.email);
              return const HomeView();
            }
            return const SignUp();
          },
          error: (error, stackTrace) {
            return ErrorPage(error: error.toString());
          },
          loading: () => const LoadingPage()),
    );
  }
}

// import 'package:appwrite/appwrite.dart';

// Client client = Client();
// client
//     .setEndpoint('http://140.84.187.223/v1')
//     .setProject('641218dcb85a7ed5f1bb')
//     .setSelfSigned(status: true); // For self signed certificates, only use for development