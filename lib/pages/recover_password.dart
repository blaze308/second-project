import 'package:ecomm/main.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: NavDrawer(),
      body: Center(child: Container()),
    );
  }
}