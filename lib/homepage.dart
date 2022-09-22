import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> characters = [];
  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Rick and Morty API'),
      ),
      body: _loading
          ? const CircularProgressIndicator()
          : characters.isEmpty
              ? Column(
                  children: [
                    // Container(
                    //   width: 150,
                    //   height: 150,
                    //   child: Image(
                    //     image: NetworkImage(characters[0]),
                    //   ),
                    //),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          fechCharacters();
                        },
                        child: const Text('Fetch Characters'),
                      ),
                    ),
                  ],
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image(
                              image: NetworkImage(characters[index]['image']),
                            ),
                          ),
                          Text(characters[index]['name']),
                        ],
                      ),
                    );
                  }),
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
