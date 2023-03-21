import 'package:appwrite_flutter/constant/ui_constants.dart';
import 'package:appwrite_flutter/features/auth/controllers/auth_controller.dart';
import 'package:appwrite_flutter/features/auth/views/login_view.dart';
import 'package:appwrite_flutter/features/auth/widgets/auth_field.dart';
import 'package:appwrite_flutter/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/common.dart';

class SignUp extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) {
          return const SignUp();
        },
      );
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final appbar = UIConstants.appBar();
  //*Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref
        .read(
          //*notifer accede a la instancia de la clase y nos permite usar sus metodos
          //*Si no usamos el notifier solo tomamos el valor del estado
          authControllerProvider.notifier,
        )
        .signUp(
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
                        child:
                            RoundedSmallButton(label: "Done", onTap: onSignUp),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //*TEXTSPAN
                      RichText(
                        text: TextSpan(
                          text: "Alredy have an account? ",
                          style: const TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                                text: "Login",
                                style: const TextStyle(
                                  color: Pallete.blueColor,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      LoginView.route(),
                                    );
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
