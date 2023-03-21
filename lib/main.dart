import 'package:appwrite_flutter/features/auth/views/sign_up_view.dart';
import 'package:appwrite_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.theme,
      home: const SignUp(),
    );
  }
}

// import 'package:appwrite/appwrite.dart';

// Client client = Client();
// client
//     .setEndpoint('http://140.84.187.223/v1')
//     .setProject('641218dcb85a7ed5f1bb')
//     .setSelfSigned(status: true); // For self signed certificates, only use for development