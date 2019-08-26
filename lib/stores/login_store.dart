import 'dart:async';

import 'package:flutter_block_signin/serializers/user.dart';
import 'package:flutter_block_signin/utils/constants/error_messages.dart';
import 'package:mobx/mobx.dart';

import '../utils/constants/data_format_constants.dart';
import '../utils/dummy_data.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  Map<String, dynamic> values = {
    'status': LoadingStatus.idle,
    'data': null,
    'error': null,
    'message': null
  };

  @action
  login(String email, String password) async {
    startLoading();
    Timer(Duration(seconds: 2), () {
      Iterable<Map<String, dynamic>> match = dymmyUserDb.where((userData) {
        User user = User.fromJson(userData);
        return user.email == email && user.password == password;
      });
      if (match.isEmpty) {
        stopLoading(error: ErrorMessages.generalError);
      } else {
        stopLoading(complete: true);
      }
      print('Match- $match');
    });
  }

  @action
  startLoading() {
    values = {
      'status': LoadingStatus.loading,
      'data': null,
      'error': false,
      'message': null
    };
  }

  @action
  stopLoading({String error, bool complete}) {
    values = {
      'status': error != null
          ? LoadingStatus.failed
          : complete ?? false ? LoadingStatus.complete : LoadingStatus.idle,
      'data': null,
      'error': error != null,
      'message': error
    };
  }
}
