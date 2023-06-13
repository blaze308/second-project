import 'package:ecomm/db/backend.dart';
import 'package:ecomm/db/postgres.dart';
import 'package:ecomm/pages/add_product.dart';
import 'package:ecomm/pages/auth.dart';
import 'package:ecomm/pages/cart.dart';
import 'package:ecomm/pages/my_account.dart';
import 'package:ecomm/pages/single_product.dart';
import 'package:ecomm/widgets/large_text.dart';
import 'package:ecomm/widgets/medium_text.dart';
import 'package:ecomm/widgets/price_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/app_bar.dart';
import 'widgets/nav_drawer.dart';

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
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      PostGres.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // const snackBar = SnackBar(content: Text("Clicked"));

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const NavDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          // shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                      LargeText(text: "Awesome Products to use in Eternity")),
            ),
            FutureBuilder(
              future: NodeConnect().fetchData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 15,
                          childAspectRatio: 2 / 2.8,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SingleProduct(
                                          snapshot: snapshot, index: index))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: MediumText(
                                              text: snapshot.data[index]
                                                  ["title"])),
                                    ),
                                    SizedBox(
                                      height: 150,
                                      width: double.maxFinite,
                                      child: Image.network(
                                        snapshot.data[index]["image"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: PriceText(
                                            text:
                                                "GHC ${snapshot.data[index]["price"]}"
                                                    .toString()),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  );
                } else {
                  return Center(child: MediumText(text: "Data not Found"));
                }
              },
            ),
          ],
        ),
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

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("jwtToken");
}
