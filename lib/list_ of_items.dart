import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './item_details.dart';

class ListOffItems extends StatefulWidget {
  const ListOffItems({Key? key}) : super(key: key);

  @override
  State<ListOffItems> createState() => _ListOffItemsState();
}

class _ListOffItemsState extends State<ListOffItems> {
  List<dynamic> characters = [];
  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Rick and Morty API'),
        backgroundColor: Colors.lightGreen,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.lightGreen,
            ))
          : characters.isEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Image.asset('assets/pics/rick.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Platform.isIOS
                          ? CupertinoButton(
                              color: Colors.lightGreen,
                              child: const Text(
                                'Show Characters',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                fechCharacters();
                              })
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightGreen,
                              ),
                              onPressed: () {
                                fechCharacters();
                              },
                              child: const Text(
                                'Show Characters',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Platform.isIOS
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 0.84,
                          ),
                          itemCount: characters.length,
                          itemBuilder: (context, index) {
                            var character = characters[index];
                            return InkWell(
                                child: Card(
                                  color: Colors.lightGreen,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image(
                                          image: NetworkImage(
                                            characters[index]['image'],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        characters[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemDetails(
                                          character['name'],
                                          character['image'],
                                          character['status'],
                                          character['species'],
                                          character['gender'],
                                          character['origin']['name'],
                                          character['location']['name'],
                                          character['episode'],
                                        ),
                                      ),
                                    ));
                          })
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: characters.length,
                          itemBuilder: (context, index) {
                            var character = characters[index];
                            return InkWell(
                              child: Card(
                                color: Colors.lightGreen,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image(
                                        image: NetworkImage(
                                          characters[index]['image'],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      characters[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetails(
                                    character['name'],
                                    character['image'],
                                    character['status'],
                                    character['species'],
                                    character['gender'],
                                    character['origin']['name'],
                                    character['location']['name'],
                                    character['episode'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
    );
  }

  void fechCharacters() async {
    setState(() {
      _loading = true;
    });
    HttpLink link = HttpLink('https://rickandmortyapi.com/graphql');
    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(
          """query{
        characters{
          results{
             name
            image
            status
            species
            gender
            origin{
              name
            }
            location{
             name
           }
           episode{
              id
              name
              air_date
              episode
            }
          }
        }
      }""",
        ),
      ),
    );

    setState(() {
      characters = queryResult.data!['characters']['results'];
      _loading = false;
    });
  }
}
