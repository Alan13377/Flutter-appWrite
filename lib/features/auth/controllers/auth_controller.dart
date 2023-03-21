import 'package:appwrite/models.dart' as model;
import 'package:appwrite_flutter/apis/auth_api.dart';
import 'package:appwrite_flutter/core/utils.dart';
import 'package:appwrite_flutter/features/auth/views/login_view.dart';
import 'package:appwrite_flutter/features/home/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
  //state = isLoading

  Future<model.Account?> currentUser() => _authAPI.currentUserAccount();
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    state = false;
    //*Regresa un error, o un success
    response.fold(
        (l) => showSnackBar(
              context,
              l.message,
            ), (r) {
      showSnackBar(context, "Accounted created! Please login.");
      Navigator.push(
        context,
        LoginView.route(),
      );
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.login(email: email, password: password);
    state = false;
    //*Regresa un error, o un success
    response.fold(
        (l) => showSnackBar(
              context,
              l.message,
            ), (r) {
      Navigator.push(
        context,
        HomeView.route(),
      );
    });
  }
}
