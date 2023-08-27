// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../data/product.dart';

class Txt extends StatefulWidget {
  final Product product;

  const Txt({
    super.key,
    required this.product,
  });

  @override
  State<Txt> createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 15,
          child: Container(
              padding: const EdgeInsets.all(2),
              height: 110,
              width: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  widget.product.img,
                  fit: BoxFit.cover,
                ),
              )),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.brown,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 10,
          child: Container(
            child: Text(
              widget.product.price.toString(),
              style: const TextStyle(fontSize: 25, color: Colors.brown),
            ),
          ),
        ),
      ],
    );
  }
}
