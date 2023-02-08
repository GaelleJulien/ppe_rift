import 'package:flutter/material.dart';
import 'package:ppe_rift_test/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';




void main() async {

  final url = Uri.parse('https://proxy.transport.data.gouv.fr/resource/ilevia-lille-gtfs-rt');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final feedMessage = FeedMessage.fromBuffer(response.bodyBytes);

    print('Number of entities: ${feedMessage.entity.length}.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPE RIFT',
      theme : ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: const HomeScreen (),
    );
  }
}


