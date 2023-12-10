import 'package:flutter/material.dart';
import 'package:eiva_mobile/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await saveValue();
  runApp(MyApp());
}

// Save a value
Future<void> saveValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Create a map
  var myList = [
    {'name': 'type_lamarina_isio', 'price': 59, 'type': 'int'},
    {'name': 'type_lamarina_diatrito', 'price': 72, 'type': 'int'},
    {'name': 'type_lamarina_kampylo', 'price': 71, 'type': 'int'},
    {'name': 'type_alumnio', 'price': 87, 'type': 'int'},
    {'name': 'type_dixty_mikro', 'price': 110, 'type': 'int'},
    {'name': 'type_dixty_messaio', 'price': 100, 'type': 'int'},
    {'name': 'type_dixty_megalo', 'price': 85, 'type': 'int'},
    {'name': 'type_kampylo_sita', 'price': 85, 'type': 'int'},
    {'name': 'type_lamarina_monosh', 'price': 87, 'type': 'int'},
    {'name': 'type_vammeno', 'price': 18, 'type': 'int'},
    {'name': 'lastixo_fouska', 'price': 18, 'type': 'int'},
    {'name': 'channel_viomixaniko', 'price': 46, 'type': 'int'},
    {'name': 'channel_viomixaniko_vathy', 'price': 58, 'type': 'int'},
    {'name': 'channel_analogiko', 'price': 30, 'type': 'int'},
    {'name': 'channel_vammeno', 'price': 10, 'type': 'int'},
    {'name': 'motor_60/600', 'price': 200, 'type': 'int'},
    {'name': 'motor_76/600', 'price': 250, 'type': 'int'},
    {'name': 'motor_76/1200', 'price': 340, 'type': 'int'},
    {'name': 'motor_75/60', 'price': 220, 'type': 'int'},
    {'name': 'motor_100/60', 'price': 260, 'type': 'int'},
    {'name': 'electronics_sonata', 'price': 87, 'type': 'int'},
    {'name': 'electronics_double_button', 'price': 30, 'type': 'int'},
    {'name': 'electronics_button_key', 'price': 65, 'type': 'int'},
    {'name': 'box_35_35', 'price': 56, 'type': 'int'},
    {'name': 'box_40_40', 'price': 64, 'type': 'int'},
    {'name': 'box_45_45', 'price': 73, 'type': 'int'},
    {'name': 'box_50_50', 'price': 83, 'type': 'int'},
    {'name': 'box_vammeno', 'price': 12, 'type': 'int'},
    {'name': 'metopi_37', 'price': 20, 'type': 'int'},
    {'name': 'metopi_42', 'price': 25, 'type': 'int'},
    {'name': 'metopi_47', 'price': 30, 'type': 'int'},
    {'name': 'metopi_52', 'price': 35, 'type': 'int'},
    {'name': 'metopi_vammeno', 'price': 5, 'type': 'int'},
    {'name': 'apasfalish', 'price': 55, 'type': 'int'},
  ];

  for (var i = 0; i < myList.length; i++) {
    String key = myList[i]['name'] as String;
    int value = myList[i]['price'] as int;

    //check if the key doesnt exist
    if (!prefs.containsKey(key)) {
      //save the value
      prefs.setInt(key, value);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Get a value
  Future<int> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('myIntKey') ?? 0;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainPage(),
    );
  }
}
