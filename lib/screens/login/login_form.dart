import 'package:flutter/material.dart';
import 'package:flutter_block_signin/screens/home/home.dart';
import 'package:flutter_block_signin/screens/sign_up/sign_up.dart';
import 'package:flutter_block_signin/stores/login_store.dart';
import 'package:flutter_block_signin/utils/constants/data_format_constants.dart';
import 'package:flutter_block_signin/utils/validators/validators.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey;
  bool _autoValidate = false;
  String _email;
  String _password;
  Validations validations = Validations();
  final LoginStore _loginStore = LoginStore();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      if ((_loginStore.values["status"] == LoadingStatus.complete)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        });
      }

      return Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Log In',
                      style: TextStyle(color: Colors.grey, fontSize: 48),
                    ),
                    SizedBox(height: 10.0),
                    createTextField(
                        fieldIcon: Icons.person,
                        labelText: 'email',
                        hintText: 'Enter email here',
                        validator: validations.validateEmail,
                        onSubmit: (value) {
                          _email = value;
                        }),
                    SizedBox(height: 25.0),
                    createTextField(
                        fieldIcon: Icons.vpn_key,
                        labelText: 'Password',
                        hintText: 'Should have atleast 6 characters.',
                        validator: validations.validatePassword,
                        onSubmit: (value) {
                          _password = value;
                        }),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
                      ),
                      child:
                          (_loginStore.values['status'] == LoadingStatus.failed)
                              ? createButton(
                                  buttonColor: Colors.redAccent,
                                  label: 'Wrong Credentials',
                                  onPressed: handelLogin,
                                )
                              : createButton(
                                  buttonColor: Colors.cyan,
                                  label: 'Log In',
                                  onPressed: handelLogin,
                                ),
                    ),
                    SizedBox(height: 35.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Reset form details ?'),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            final FormState form = _formKey.currentState;
                            form.reset();
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
                      ),
                      child: createButton(
                          buttonColor: Colors.grey,
                          label: 'Sign Up',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
                          }),
                    ),
                  ],
                ),
              ),
            ),
            _loginStore.values['status'] == LoadingStatus.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      );
    });
  }

  createTextField(
      {IconData fieldIcon,
      String labelText,
      String hintText,
      int maxLines,
      validator,
      Function onSubmit}) {
    if (fieldIcon == null) {
      return TextFormField(
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        onSaved: onSubmit,
      );
    }
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(fieldIcon),
        hintText: hintText,
        labelText: labelText,
      ),
      validator: validator,
      onSaved: onSubmit,
    );
  }

  createButton({Color buttonColor, Function onPressed, String label}) {
    return RaisedButton(
      padding: const EdgeInsets.all(12.0),
      color: buttonColor,
      onPressed: onPressed,
      elevation: 7.0,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: Container(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21.0,
          ),
        ),
      ),
    );
  }

  handelLogin() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
    } else {
      form.save();
      _loginStore.login(_email.trim(), _password.trim());
    }
  }
}
