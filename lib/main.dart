import 'package:ecomm/db/postgres.dart';
import 'package:ecomm/pages/add_product.dart';
import 'package:ecomm/pages/cart.dart';
import 'package:ecomm/pages/my_account.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: const Text("Awesome Store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54, size: 30)),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Awesome Products to Use in Eternity",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            FutureBuilder(
                future: PostGres.getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              height: 350,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data[index]["title"],
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Image.network(
                                      snapshot.data[index]["image"],
                                      width: double.maxFinite,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "GHC ${snapshot.data[index]["price"].toString()}",
                                            style: const TextStyle(
                                                color: Color(0xFF869013),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("data not found"));
                  }
                })
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: const Color(0xFF9DA53F),
              child: const Text(
                "Add Products",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 8,
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
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blueGrey)),
            accountName: Text("John Doe"),
            accountEmail: Text("johndoe@email.com"),
            decoration: BoxDecoration(color: Colors.blueGrey),
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
                  title: const Text("Home",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const Icon(Icons.shopping_cart_checkout,
                      color: Colors.black54, size: 35),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Cart()));
                  },
                  minLeadingWidth: 0,
                  title: const Text("Cart",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading:
                      const Icon(Icons.person, color: Colors.black54, size: 35),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyAccount()));
                  },
                  minLeadingWidth: 0,
                  title: const Text("My Account",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading:
                      const Icon(Icons.logout, color: Colors.black54, size: 35),
                  onTap: () {},
                  minLeadingWidth: 0,
                  title: const Text("Logout",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
