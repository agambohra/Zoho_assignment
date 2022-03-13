import 'package:agam/method_login_signup.dart';
import 'package:agam/screens/form.dart';
import 'package:agam/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your password");
        }

        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          // if (_emailfield.text.isNotEmpty && _password.text.isNotEmpty) {
          //   setState(() {
          //     isLoading = true;
          //   });
          //   logIn(_email.text, _password.text).then(
          //     (user) {
          //       if (user != null) {
          //         setState(() {
          //           isLoading = false;
          //         });

          //         print("login successful");
          //         Navigator.of(context).pushNamed(HomeScreen.routeName);
          //       } else {
          //         print("login failed");
          //       }
          //     },
          //   );
          // } else {
          //   print("please enter the fields");
          // }
        },
        child: Text(
          "Sign In ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't Have an account?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    SizedBox(
                      height: 60,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Your Password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    loginButton,
                    //
                    // Material(
                    //   elevation: 5,
                    //   borderRadius: BorderRadius.circular(30),
                    //   color: Colors.blue,
                    //   child: MaterialButton(
                    //     padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    //     minWidth: MediaQuery.of(context).size.width,
                    //     onPressed: () {
                    //       // logIn(emailController.text, passwordController.text);
                    //       if (emailController.text.isNotEmpty &&
                    //           passwordController.text.isNotEmpty) {
                    //         setState(() {
                    //           isLoading = true;
                    //         });
                    //         logIn(emailController.text, passwordController.text)
                    //             .then(
                    //           (user) {
                    //             if (user != null) {
                    //               setState(() {
                    //                 isLoading = false;
                    //               });

                    //               print("login successful");
                    //               Fluttertoast.showToast(
                    //                   msg: "login Successful");
                    //               Navigator.of(context).pushReplacement(
                    //                 MaterialPageRoute(
                    //                   builder: (context) => FormScreen(),
                    //                 ),
                    //               );
                    //             } else {
                    //               print("login failed");
                    //             }
                    //           },
                    //         ).catchError((e) {
                    //           Fluttertoast.showToast(msg: e!.message);
                    //         });
                    //       } else {
                    //         print("please enter the fields");
                    //       }
                    //     },
                    //     child: Text(
                    //       "Sign In ",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    //
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => FormScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: Icon(Icons.forward),
                    // ),
                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "login Successful"),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => FormScreen(),
                  ),
                ),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
