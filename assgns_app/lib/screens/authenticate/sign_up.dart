import '/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  const SignUp({required this.toggleView, Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _pass;
  late String _name;
  late String _div;
  late String _roll_no;
  late bool _hidePassword;

  @override
  void initState() {
    _email = '';
    _pass = '';
    _name = '';
    _div = '';
    _roll_no = '';
    _hidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Sign up page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Spacer(),
              _emailFormField(hintText: "Email"),
              const SizedBox(height: 20),
              _nameFormField(hintText: "Name"),
              const SizedBox(height: 20),
              _divFormField(hintText: "Div"),
              const SizedBox(height: 20),
              _rollFormField(hintText: "Roll no"),
              const SizedBox(height: 20),
              _passwordFormField(hintText: "Password"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?, ",
                      style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: const Text(
                      "Sign-in",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.grey[100]),
                    ),
                  )
                ],
              ),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: _signUpButton(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _emailFormField({required String hintText}) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
      onChanged: (val) {
        setState(() => _email = val);
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
    );
  }

  TextFormField _nameFormField({required String hintText}) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
      onChanged: (val) {
        setState(() => _name = val);
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
    );
  }

  TextFormField _divFormField({required String hintText}) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
      onChanged: (val) {
        setState(() => _div = val);
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
    );
  }

  TextFormField _rollFormField({required String hintText}) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
      onChanged: (val) {
        setState(() => _roll_no = val);
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
    );
  }

  TextFormField _passwordFormField({required String hintText}) {
    return TextFormField(
      validator: (val) =>
          val!.length < 6 ? "Password must have at least 6 characters" : null,
      onChanged: (val) {
        setState(() => _pass = val);
      },
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _hidePassword = !_hidePassword);
            },
            icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
      obscureText: _hidePassword,
    );
  }

  ElevatedButton _signUpButton() {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result =
              await _auth.signup(_email, _pass, _name, _div, _roll_no);
          print("email : $_email");
          print("name : $_name");
          print("roll_no : $_roll_no");
          print("div : $_div");

          print("pass : $_pass");
          if (result != null) {
            print("$result, Successfully signed up with email & password");
            print(result.userId);
          } else {
            print("Error in registering ");
          }
        }
      },
      child: const Text(
        "Sign-up",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
