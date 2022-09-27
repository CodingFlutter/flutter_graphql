import 'package:flutter/material.dart';
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
          ? const CircularProgressIndicator()
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
                      child: ElevatedButton(
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
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
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
                                          characters[index]['image']),
                                    ),
                                  ),
                                  Text(
                                    characters[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
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
                                      characters[index]['name'],
                                      characters[index]['image'],
                                      characters[index]['status'],
                                      characters[index]['species'],
                                      characters[index]['type'],
                                      characters[index]['gender'],
                                      characters[index]['origin']['name'],
                                      characters[index]['location']['name'],
                                      characters[index]['location']['type'],
                                      characters[index]['episode'],
                                    ),
                                  ),
                                ));
                      }),
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
            type
            gender
            origin{
             name
            }
           location{
             name
             type
           }
           
           episode{
              id
              name
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
