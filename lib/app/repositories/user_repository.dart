import 'dart:async';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:temparty/app/data/data_sources/user/user_local_data_source.dart';
import 'package:temparty/app/data/data_sources/user/user_remote_data_source.dart';
import 'package:temparty/app/data/model/user_model.dart';

@injectable
class UserRepository {
  final UserLocalDataSource _userLocal;
  final UserRemoteDataSource _userRemote;

  UserRepository(this._userLocal, this._userRemote);

  Future<UserModel?> getUserData() async {
    final user = await _userLocal.getUserData();
    if (user != null) return UserModel.fromJson(jsonDecode(user));
    return _userRemote.getUserData();
  }

  Future<void> loginUser() async {
    await _userLocal.deleteUserData();
    final userData = await _userRemote.getUserData();
    await _userLocal.saveUserData(jsonEncode(userData));
  }

  Future<void> createUserData(Map<String, String> data) async {
    await _userLocal.deleteUserData();
    final user = UserModel.fromJson(data);

    await _userRemote.createUserData(user);
  }

  Future<void> updateUserData(Map<String, String> data, XFile? image) async {
    await _userRemote.updateUserData(data, image);
    await _userLocal.deleteUserData();
    await getUserData();
  }

  Future<void> removeProfileImage() async {
    await _userRemote.removeUserProfileImage();
    await getUserData();
  }

  Future<void> updateOrganizerAccount(bool? value) async {
    await _userRemote.updateOrganizerAccount(value);
    await getUserData();
  }
}
