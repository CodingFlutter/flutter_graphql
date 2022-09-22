import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  String name;

  ItemDetails(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(name)),
      ),
    );
  }
}
