import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/features/view/login_view.dart';
import '../../apis/auth_api.dart';
import '../../apis/user_api.dart';
import '../../core/until.dart';
import '../../model/user_model.dart';
import '../home/view/home_view.dart';

//Nắm đầu class AuthController đưa cho UI sài
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(AuthAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final idpr = Provider(
  (ref) {
    final x = ref.watch(currentUserAccountProvider).value!.$id;

    return ref.watch(userDetailProvider(x)).value!.uid;
  },
);
final currenUserDetailProvider = FutureProvider(
  (ref) {
    final currenUserId = ref.watch(currentUserAccountProvider).value!.$id;
    final userDetails = ref.watch(userDetailProvider(currenUserId));
    return userDetails.valueOrNull;
  },
);

//Lấy dữ liệu mà người dùng đang đăng nhập .family truyền vào uid
final userDetailProvider = FutureProvider.family((ref, String uid) async {
  final authController = ref.watch(authControllerProvider.notifier);

  return await authController.getUserData(uid);
});

//Kiểm tra xem người dùng có đăng nhập không
final currentUserAccountProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return await authController.currentUser();
});

//Class này sẽ làm việc hết những việc nó làm sao đó đưa lên các Provider ở trên để sử lí nó
class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      //Khởi tạo thôi, vì nó là biến private nên khởi tạo kiểu này
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  //state = isLoading

//Hàm này gọi sang AuthAPI để xử lí
  Future<model.Account?> currentUser() async {
    return await _authAPI.currentUserAccount();
  }

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //true thì xử lí dữ liệu vòng tròn xuay
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
          uid: r.$id,
          isTwitterBlue: false);
      //Lưu dữ liệu vào database trên appwrite
      final res2 = await _userAPI.saveUserData(userModel);

      res2.fold(
        (l) => showNackBar(context, l.message),
        (r) {
          showNackBar(context, 'Account create! Please login.');
          Navigator.push(context, LoginView.route());
        },
        //left quăng lỗi right chuyển trang
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

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updateUser = UserModel.fromMap(document.data);
    return updateUser;
  }
}
