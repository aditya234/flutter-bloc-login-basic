import 'package:flutter/material.dart';
import 'package:flutter_block_signin/utils/dummy_data.dart';
import 'package:flutter_block_signin/utils/validators/validators.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey;
  bool _autoValidate = false;
  String _email;
  String _password;
  String _firstName;
  String _lastName;
  Validations validations = Validations();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  'Sign up',
                  style: TextStyle(color: Colors.grey, fontSize: 48),
                ),
                SizedBox(height: 10.0),
                createTextField(
                    fieldIcon: Icons.person_outline,
                    labelText: 'First name',
                    hintText: 'Should have atleast 6 characters.',
                    validator: validations.validateName,
                    onSubmit: (value) {
                      _firstName = value;
                    }),
                SizedBox(height: 25.0),
                createTextField(
                    fieldIcon: Icons.person_outline,
                    labelText: 'Last name',
                    hintText: 'Should have atleast 6 characters.',
                    validator: validations.validateName,
                    onSubmit: (value) {
                      _lastName = value;
                    }),
                SizedBox(height: 25.0),
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
                  child: createButton(
                      buttonColor: Colors.cyan,
                      label: 'Sign Up',
                      onPressed: handelSignUp),
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
                      label: 'Log In',
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                SizedBox(height: 35.0),
              ],
            ),
          ),
        ),
      ),
    );
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

  handelSignUp() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      print('Not Validate');
      _autoValidate = true;
    } else {
      form.save();
      dymmyUserDb.add({
        "firstname": _firstName,
        "lastname": _lastName,
        "email": _email,
        "password": _password
      });
      Navigator.of(context).pop();
    }
  }
}
