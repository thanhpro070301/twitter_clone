// ignore_for_file: non_constant_identifier_names, duplicate_ignore
import 'package:appwrite/models.dart' as model;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../core/provider.dart';

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

// ignore: non_constant_identifier_names
final AuthAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  @override
  Future<model.Account?> currentUserAccount() async {
    try {
      print("lay dc roi");
      return await _account.get();
    } catch (_) {}
    print("tao bi null");
    return null;
  }

  @override
  FutureEither<model.Account> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(message: e.toString(), stackTrace: stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
