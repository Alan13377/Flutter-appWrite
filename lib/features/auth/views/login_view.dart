import 'package:appwrite_flutter/common/loading_page.dart';
import 'package:appwrite_flutter/common/rounded_small_button.dart';
import 'package:appwrite_flutter/constant/ui_constants.dart';
import 'package:appwrite_flutter/features/auth/controllers/auth_controller.dart';
import 'package:appwrite_flutter/features/auth/views/sign_up_view.dart';
import 'package:appwrite_flutter/features/auth/widgets/auth_field.dart';
import 'package:appwrite_flutter/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) {
          return const LoginView();
        },
      );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref
        .read(
          //*notifer accede a la instancia de la clase y nos permite usar sus metodos
          //*Si no usamos el notifier solo tomamos el valor del estado
          authControllerProvider.notifier,
        )
        .login(
            email: emailController.text,
            password: passwordController.text,
            context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //*TEXTFIELD 1
                      AuthField(
                        label: "Email Address",
                        controller: emailController,
                        hintText: "Email",
                      ),
                      //*TEXTFIELD 2
                      const SizedBox(
                        height: 25,
                      ),
                      AuthField(
                        label: "Password",
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //*BUTTON
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          label: "Done",
                          onTap: login,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //*TEXTSPAN
                      RichText(
                        text: TextSpan(
                          text: "Don´t have an account? ",
                          style: const TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                                text: "Sign Up",
                                style: const TextStyle(
                                  color: Pallete.blueColor,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, SignUp.route());
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
