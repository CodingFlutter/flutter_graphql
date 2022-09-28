import 'dart:io';
import 'package:flutter/material.dart';
import './widgets/my_text.dart';

class ItemDetails extends StatelessWidget {
  String name;
  String image;
  String status;
  String species;
  String gender;
  String origin;
  String locName;
  List<dynamic> episods = [];

  ItemDetails(
    this.name,
    this.image,
    this.status,
    this.species,
    this.gender,
    this.origin,
    this.locName,
    this.episods,
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
                height: 230,
                width: 230,
                child: Card(
                  child: Expanded(
                    child: Image(
                      height: 170,
                      width: 170,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32,
              ),
              child: Platform.isIOS
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          myTitle: 'Status:  $status',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        MyText(
                          myTitle: 'Species:  $species',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        MyText(
                          myTitle: 'Gender:  $gender',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        MyText(
                          myTitle: 'Origin:  $origin',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        MyText(
                          myTitle: 'Location:  $locName',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        const MyText(
                          myTitle: 'Episodes:',
                          textSize: 16,
                          textColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            itemCount: episods.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: MyText(
                                    myTitle: episods[index]['episode'],
                                    textSize: 12,
                                    textColor: Colors.lightGreen,
                                  ),
                                  title: MyText(
                                    myTitle: episods[index]['name'],
                                    textSize: 16,
                                    textColor: Colors.lightGreen,
                                  ),
                                  subtitle: MyText(
                                    myTitle: episods[index]['air_date'],
                                    textSize: 12,
                                    textColor: Colors.lightGreen,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            myTitle: 'Status:  $status',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          MyText(
                            myTitle: 'Species:  $species',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          MyText(
                            myTitle: 'Gender:  $gender',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          MyText(
                            myTitle: 'Origin:  $origin',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          MyText(
                            myTitle: 'Location:  $locName',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          const MyText(
                            myTitle: 'Episodes:',
                            textSize: 18,
                            textColor: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 225,
                            child: ListView.builder(
                              itemCount: episods.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: MyText(
                                      myTitle: episods[index]['episode'],
                                      textSize: 12,
                                      textColor: Colors.lightGreen,
                                    ),
                                    title: MyText(
                                      myTitle: episods[index]['name'],
                                      textSize: 16,
                                      textColor: Colors.lightGreen,
                                    ),
                                    subtitle: MyText(
                                      myTitle: episods[index]['air_date'],
                                      textSize: 12,
                                      textColor: Colors.lightGreen,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
