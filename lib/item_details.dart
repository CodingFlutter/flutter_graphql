import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  String name;
  String image;
  String gender;
  String species;

  ItemDetails(
    this.name,
    this.image,
    this.gender,
    this.species,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.white,
                height: 300,
                width: 300,
                child: Card(
                  child: Expanded(
                    child: Image(
                      height: 250,
                      width: 250,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              gender,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              species,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
