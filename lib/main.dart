import 'package:ecomm/db/postgres.dart';
import 'package:ecomm/pages/add_product.dart';
import 'package:ecomm/pages/cart.dart';
import 'package:ecomm/pages/my_account.dart';
import 'package:ecomm/pages/single_product.dart';
import 'package:ecomm/widgets/large_text.dart';
import 'package:ecomm/widgets/medium_text.dart';
import 'package:ecomm/widgets/price_text.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PostGres.connect();
  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Inter"),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // const snackBar = SnackBar(content: Text("Clicked"));

    return Scaffold(
      appBar: AppBar(
          title: LargeText(text: "Awesome Store"),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54, size: 30)),
      drawer: const NavDrawer(),
      body: FutureBuilder(
        future: PostGres.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2.8,
                      mainAxisSpacing: 15),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Container(
                        child: Column(
                          children: [
                            MediumText(text: snapshot.data[index]["title"])
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.green),
                      )),
            );
          } else {
            return Center(child: MediumText(text: "Data not Found"));
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: 55,
        height: 55,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: const Color(0xFF9DA53F),
              child: const Text(
                "Add Products",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProduct()));
              }),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blueGrey)),
            accountName: MediumText(text: "John Doe"),
            accountEmail: MediumText(text: "johndoe@email.com"),
            decoration: const BoxDecoration(color: Colors.blueGrey),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              children: [
                ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading:
                        const Icon(Icons.home, color: Colors.black54, size: 35),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MyApp())),
                    minLeadingWidth: 0,
                    title: LargeText(text: "Home")),
                const SizedBox(height: 10),
                ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: const Icon(Icons.shopping_cart_checkout,
                        color: Colors.black54, size: 35),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Cart()));
                    },
                    minLeadingWidth: 0,
                    title: LargeText(text: "Cart")),
                const SizedBox(height: 10),
                ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: const Icon(Icons.person,
                        color: Colors.black54, size: 35),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyAccount()));
                    },
                    minLeadingWidth: 0,
                    title: LargeText(text: "My Account")),
                const SizedBox(height: 10),
                ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: const Icon(Icons.logout,
                        color: Colors.black54, size: 35),
                    onTap: () {},
                    minLeadingWidth: 0,
                    title: LargeText(text: "Logout")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
