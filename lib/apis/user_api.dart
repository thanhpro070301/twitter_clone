import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';

import '../core/provider.dart';
import '../model/user_model.dart';

abstract class IUserAPI {
  //Lưu người dùng vào DB này chỉ là giao diện thôi xuống kia mới xử lí
  FutureEitherVoid saveUserData(UserModel userModel);
  //Này thì lấy dữ liệu người dùng dựa trên uid
  Future<model.Document> getUserData(String uid);
}

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

class UserAPI implements IUserAPI {
  final Databases _db;
  //Biến private nên khởi tạo kiểu này
  UserAPI({required Databases db}) : _db = db;

  @override
  //FutureEitherVoid là kiểu typedef mà mình tự định nghĩa nó là
  //FutureEither<void>
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(message: e.toString(), stackTrace: st),
      );
    } catch (e, st) {
      return left(
        Failure(message: e.toString(), stackTrace: st),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollection,
      documentId: uid,
    );
  }
}
