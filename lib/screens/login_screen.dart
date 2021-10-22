import 'dart:ui';

import 'package:ecommerce_application/provider/modalHud.dart';
import 'package:ecommerce_application/screens/home_screen.dart';
import 'package:ecommerce_application/screens/signup_screen.dart';
import 'package:ecommerce_application/services/auth.dart';
import 'package:ecommerce_application/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  //const LoginScreen({Key? key}) : super(key: key);
  String? _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffcc5c04),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              // App Logo & Title
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //Image
                      Image(
                        image: AssetImage('assets/icons/buyicon.png'),
                        color: Colors.white, //Color(0xff233452),
                      ),

                      //Text (Title) (Positioned)
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Ecommerce App',
                          style: GoogleFonts.pacifico(
                              fontSize: 32, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                //),
              ),

              SizedBox(
                height: height * 0.1,
              ),
              // Login Form
              //Email Text Field
              AppTextField(
                onClick: (value) {
                  _email = value;
                },
                icon: Icons.email,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: height * 0.02,
              ),

              //Password Text Field
              AppTextField(
                onClick: (value) {
                  _password = value;
                },
                icon: Icons.lock,
                hint: 'password',
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: height * 0.1,
              ),

              //Login Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        final modalHud =
                            Provider.of<ModalHud>(context, listen: false);
                        modalHud.setIsLoading(true);
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState!.save();

                          try {
                            final result =
                                await _auth.signIn(_email!, _password!);
                            modalHud.setIsLoading(false);
                            Navigator.pushNamed(context, HomeScreen.id);
                          } on FirebaseAuthException catch (e) {
                            modalHud.setIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.message.toString(),
                                ),
                              ),
                            );
                          }
                        }
                        modalHud.setIsLoading(false);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),

              //Sign Up Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do Not Have an Account?',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                    child: Text('Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
