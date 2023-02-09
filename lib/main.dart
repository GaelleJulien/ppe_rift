import 'dart:collection';
import 'dart:io';
import 'package:csv/csv.dart';

import 'package:flutter/material.dart';
import 'package:ppe_rift_test/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:flutter/services.dart' show rootBundle;




void main()  {

  runApp(const MyApp());

}

Future<String> getData() async {
  final url = Uri.parse('https://proxy.transport.data.gouv.fr/resource/ilevia-lille-gtfs-rt');
  final response = await http.get(url);

    final feedMessage = FeedMessage.fromBuffer(response.bodyBytes);

    print(feedMessage.entity.toString());

  return feedMessage.entity.toString();

}



String getDataString(){
  String dataString = getData() as String;
  print (dataString);
  return dataString;
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
        primarySwatch: Colors.red
      ),
      home: MyHomePage (),
    );
  }
}


