import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'list_ of_items.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GraphQL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListOffItems(),
    );
  }
}
