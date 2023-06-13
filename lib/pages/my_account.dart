import 'package:ecomm/main.dart';
import 'package:flutter/material.dart';

import '../widgets/nav_drawer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
      ),
      drawer: const NavDrawer(),
    );
  }
}
