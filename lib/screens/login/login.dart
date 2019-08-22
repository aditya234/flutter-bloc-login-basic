import 'package:flutter/material.dart';
import 'package:flutter_block_signin/bloc/login_bloc.dart';
import 'package:flutter_block_signin/bloc_provider/bloc_provider.dart';
import 'package:flutter_block_signin/screens/login/login_form.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}
