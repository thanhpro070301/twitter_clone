import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;
import '../../apis/auth_api.dart';
import '../../apis/user_api.dart';
import '../../core/until.dart';
import '../../model/user_model.dart';
import '../home/view/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(AuthAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  //state = isLoading

  Future<model.Account?> currentUser() {
    return _authAPI.currentUserAccount();
  }

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) => showNackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          bannerPic: '',
          bio: '',
          profilePic: '',
          uid: '',
          isTwitterBlue: false);
      final res2 = await _userAPI.saveUserData(userModel);

      res2.fold(
        (l) => showNackBar(context, l.message),
        (r) {
          showNackBar(context, 'Account create! Please login.');
          Navigator.push(context, HomeView.route());
        },
      );
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
