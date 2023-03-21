import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:appwrite_flutter/core/core.dart';
import 'package:appwrite_flutter/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  //*Escuchamos el cliente de AppWrite
  return AuthAPI(
    account: account,
  );
});

//*Cuando queremos iniciar sesion, obtener la cuenta del usuario ->> Account
//*Cuando queremos acceder a los datos del usuario ->> model.Account
abstract class IAuthAPI {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
  Future<model.Account?> currentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  //*Constructor Privado
  AuthAPI({required Account account}) : _account = account;

  //*Creacion de Usuario
  @override
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      //*Crear Usuario
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          message: e.message ?? "Ocurrio un error",
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }

  //*Inicio de Sesion
  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      //*Crear Usuario
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          message: e.message ?? "Ocurrio un error",
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<model.Account?> currentUserAccount() async {
    try {
      return _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
