import 'dart:async';

import 'package:flutter_block_signin/bloc_provider/bloc_provider.dart';
import 'package:flutter_block_signin/serializers/user.dart';
import 'package:flutter_block_signin/utils/constants/data_format_constants.dart';
import 'package:flutter_block_signin/utils/dummy_data.dart';

class LoginBloc extends BlocBase {
// streams of Login Data
  StreamController streamListController = StreamController<Map>.broadcast();

// sink
  Sink get userDataSink => streamListController.sink;

// stream
  Stream<Map> get userDataStream => streamListController.stream;

  startLoading() {
    values = {
      'status': LoadingStatus.loading,
      'data': null,
      'error': false,
      'message': null
    };
    userDataSink.add(values);
  }

  stopLoading() {
    values = {
      'status': LoadingStatus.idle,
      'data': null,
      'error': false,
      'message': null
    };
    userDataSink.add(values);
  }

// logging User in
  Future loginUser(String email, String password) async {
    await Timer(Duration(seconds: 2), () {
      Iterable<Map<String, dynamic>> match = dymmyUserDb.where((userData) {
        User user = User.fromJson(userData);
        if ((user.email == email) && (user.password == password)) {
          return true;
        }
        return false;
      });
      if(match.isEmpty){
        values = {
          'status': LoadingStatus.failed,
          'data': false,
          'error': false,
          'message': null
        };
      }else{
        values = {
          'status': LoadingStatus.complete,
          'data': true,
          'error': false,
          'message': null
        };
      }
      print('Match- $match');

      userDataSink.add(values);
    });
  }

//disponsing our Stream
  @override
  dispose() {
    streamListController.close();
  }
}
