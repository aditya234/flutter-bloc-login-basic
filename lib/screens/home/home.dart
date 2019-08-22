import 'package:flutter/material.dart';
import 'package:flutter_block_signin/screens/login/login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
