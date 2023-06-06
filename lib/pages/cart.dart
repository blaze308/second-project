import 'package:ecomm/main.dart';
import 'package:ecomm/widgets/large_text.dart';
import 'package:ecomm/widgets/price_text.dart';
import 'package:flutter/material.dart';

import '../widgets/medium_text.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const NavDrawer(),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: LargeText(text: "My Cart"),
        ),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 60,
              width: double.maxFinite,
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  "assets/images/img.jpg",
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: MediumText(
                                  text: "Product Title",
                                  maxLines: 2,
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            PriceText(
                                text: "GHC 898",
                                textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF869013),
                                    fontWeight: FontWeight.bold)),
                            Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.redAccent, size: 25)),
                              const Badge(
                                child: Icon(Icons.shopping_cart,
                                    color: Colors.blueGrey),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_circle,
                                      color: Colors.greenAccent, size: 25)),
                            ]),
                            PriceText(
                                text: "Total",
                                textStyle: const TextStyle(
                                    color: Color(0xFF869013),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                  ]),
            )),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 10, top: 20),
            height: 80,
            width: 300,
            decoration: const BoxDecoration(color: Color(0xFF79FF7E)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: MediumText(
                        text: "Total Amount of Items in Your Cart",
                        maxLines: 3,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: PriceText(text: "GHC 587932"),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
