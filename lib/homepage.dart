import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> characters = [];
  final bool _loading = false;

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
                    Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    const ElevatedButton(
                      onPressed: null,
                      child: Text('Fetch Characters'),
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
                          Image(
                            image: NetworkImage(characters[index]['image']),
                          ),
                          Text(characters[index]['name']),
                        ],
                      ),
                    );
                  }),
    );
  }
}
