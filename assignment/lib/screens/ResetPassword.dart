import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../services/firebase_exceptions.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    controller: _emailController,
                    cursorColor: Colors.purple.shade400,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple.shade400)),
                        hintText:'Email Address',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 16),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(top: 31, bottom: 21),
                  child: MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          // LoaderX.show(context);
                          final _status = await _authService.forgotPassword(
                              email: _emailController.text.trim());
                          if (_status == AuthStatus.successful) {
                            // LoaderX.hide();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  LoginScreen()));
                          } else {
                            // LoaderX.hide();
                            final error =
                            AuthExceptionHandler.generateErrorMessage(_status);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                          }
                        }
                      },
                      padding: EdgeInsets.symmetric(vertical: 13),
                      minWidth: double.infinity,
                      color: Colors.purple.shade300,
                      disabledColor: Colors.grey.shade300,
                      textColor: Colors.white,
                      child: SizedBox(
                        height: 20,
                        width: 40,
                        child:Text('Done')),
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}