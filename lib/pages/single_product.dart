import 'package:ecomm/main.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({required this.snapshot, required this.index, super.key});
  final AsyncSnapshot snapshot;
  final int index;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Single Product")),
      // drawer: const NavDrawer(),
      body: Container(
        width: double.maxFinite,
        // child: Text(widget.snapshot.data[widget.index]["title"]),
        child: Column(children: [
          Row(
            children: [
              Image.network(
                widget.snapshot.data[widget.index]["image"],
                width: 200,
              ),
              Text(widget.snapshot.data[widget.index]["title"]),
              Text(widget.snapshot.data[widget.index]["price"].toString())
            ],
          )
        ]),
      ),
    );
  }
}
