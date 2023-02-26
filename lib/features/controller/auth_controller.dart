import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apis/auth_api.dart';
import '../../core/until.dart';
import '../home/view/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(AuthAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
  //state = isLoading
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) {
      return showNackBar(context, l.message);
    }, (r) {
      showNackBar(context, 'Account create! Please login.');
      Navigator.push(context, HomeView.route());
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) {
      return showNackBar(context, l.message);
    },
        // ignore: void_checks
        (r) {
      Navigator.push(context, HomeView.route());
    });
  }
}
