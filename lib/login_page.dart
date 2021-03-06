import 'package:firebase_authentication/auth/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;

  LoginPage({this.auth});

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  FormType formType = FormType.login;

  TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInput() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInput() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: "Email"),
        validator: (value) => value.isEmpty ? "Email can't be empty " : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "password"),
        obscureText: true,
        controller: _emailController,
        validator: (value) => value.isEmpty ? "Password can't be empty " : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            "create an account",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            "Register",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            "already have an account",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      // todo : using onSave method to save our form values
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      {
        try {
          if (formType == FormType.login) {
            String userId =
                await widget.auth.signInWithEmailAndPassword(_email, _password);
//            AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.trim(), password: _password.trim());
            print(userId);
          } else {
//            AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.trim(), password: _password.trim());
            String userId = await widget.auth
                .createAccountWithEmailAndPassword(_email, _password);
            print(userId);
          }
        } catch (e) {
          print("Error $e");
        }
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      formType = FormType.login;
    });
  }
}
