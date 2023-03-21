import 'package:appwrite/appwrite.dart';
import 'package:appwrite_flutter/constant/appwrite_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//*Conexion con APPWRITE
final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppConstants.endPoint)
      .setProject(AppConstants.projectId)
      .setSelfSigned(status: true);
});

//*Obtenemos el cliente de AppWrite

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});
