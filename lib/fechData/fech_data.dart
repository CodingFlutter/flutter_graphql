import 'package:graphql_flutter/graphql_flutter.dart';

void fechCharacters() async {
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
        characters(){
          result{
            name
            image
          }
        }
      }""",
      ),
    ),
  );
}
