import 'package:ecomm/db/backend.dart';
import 'package:ecomm/main.dart';
import 'package:ecomm/pages/recover_password.dart';
import 'package:ecomm/widgets/large_text.dart';
import 'package:flutter/material.dart';

import '../widgets/nav_drawer.dart';
import '../widgets/app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showLoginForm = true;
  bool showSignupForm = false;

  void showLoginFormOnly() {
    setState(() {
      showLoginForm = true;
      showSignupForm = false;
    });
  }

  void showSignupFormOnly() {
    setState(() {
      showLoginForm = false;
      showSignupForm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const opVal = 0.8;
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8d2hpdGUlMjBzaG9wfGVufDB8MXwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                opacity: 0.9,
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const MyAppBar(),
          drawer: const NavDrawer(),
          body: Center(
            child: Container(
              width: 360,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(opVal),
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: showLoginFormOnly,
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color(0xff69F26E).withOpacity(opVal),
                            fixedSize: const Size(180, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10)))),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      TextButton(
                          onPressed: showSignupFormOnly,
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffEA6A6A).withOpacity(opVal),
                              fixedSize: const Size(180, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10)))),
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  if (showLoginForm)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Username/Email Address*")),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white.withOpacity(opVal),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )),
                          const SizedBox(height: 20),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Password*")),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white.withOpacity(opVal),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordRecovery())),
                            child: const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Forgot Password",
                                      style:
                                          TextStyle(color: Color(0xff60279A))),
                                )),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              String username = _usernameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              String identifier =
                                  username.isNotEmpty ? username : email;
                              NodeConnect().login(identifier, password);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const MyApp()));
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                backgroundColor:
                                    Colors.white.withOpacity(opVal),
                                elevation: 10),
                            child: LargeText(
                              text: "Portal Access",
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          GestureDetector(
                            onTap: showSignupFormOnly,
                            child: const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Not a user? Create Account",
                                      style:
                                          TextStyle(color: Color(0xff60279A))),
                                )),
                          ),
                        ],
                      ),
                    ),
                  if (showSignupForm)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Username*")),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white.withOpacity(opVal),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )),
                          const SizedBox(height: 10),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Email Address*")),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white.withOpacity(opVal),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )),
                          const SizedBox(height: 10),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Password*")),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white.withOpacity(opVal),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              String username = _usernameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              NodeConnect().signUp(username, email, password);
                              setState(() {
                                showLoginForm = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                backgroundColor:
                                    Colors.white.withOpacity(opVal),
                                elevation: 10),
                            child: LargeText(
                              text: "Create My Account",
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          GestureDetector(
                            onTap: showLoginFormOnly,
                            child: const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Already a user? Login Here",
                                      style:
                                          TextStyle(color: Color(0xff60279A))),
                                )),
                          ),
                        ],
                      ),
                    ),
                ]),
              ),
            ),
          ),
        ));
  }
}
