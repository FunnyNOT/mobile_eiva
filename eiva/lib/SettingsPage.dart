import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<TextEditingController> controllers = [];

  Future<String> getPreferenceValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(key);
    return value != null ? value.toString() : 'Nop';
  }

  Future<void> savePreferenceValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, int.parse(value));
  }

  static const List myList = [
    {'name': 'type_lamarina_isio', 'greek': 'Λαμαρίνα Ισιό'},
    {'name': 'type_lamarina_diatrito', 'greek': 'Λαμαρίνα Διάτρητο'},
    {'name': 'type_lamarina_kampylo', 'greek': 'Λαμαρίνα Καμπύλο'},
    {'name': 'type_alumnio', 'greek': 'Αλουμίνιο'},
    {'name': 'type_dixty_mikro', 'greek': 'Δίχτυ Μικρό'},
    {'name': 'type_dixty_messaio', 'greek': 'Δίχτυ Μεσαίο'},
    {'name': 'type_dixty_megalo', 'greek': 'Δίχτυ Μεγάλο'},
    {'name': 'type_kampylo_sita', 'greek': 'Καμπύλο Σίτα'},
    {'name': 'type_lamarina_monosh', 'greek': 'Λαμαρίνα Μονός'},
    {'name': 'type_vammeno', 'greek': 'Βαμμένο'},
    {'name': 'lastixo_fouska', 'greek': 'Λάστιχο Φούσκα'},
    {'name': 'channel_viomixaniko', 'greek': 'Βιομηχανικό'},
    {'name': 'channel_viomixaniko_vathy', 'greek': 'Βιομηχανικό Βαθύ'},
    {'name': 'channel_analogiko', 'greek': 'Αναλογικό'},
    {'name': 'channel_vammeno', 'greek': 'Βαμμένο'},
    {'name': 'motor_60/600', 'greek': '60/600'},
    {'name': 'motor_76/600', 'greek': '76/600'},
    {'name': 'motor_76/1200', 'greek': '76/1200'},
    {'name': 'motor_75/60', 'greek': '75/60'},
    {'name': 'motor_100/60', 'greek': '100/60'},
    {'name': 'electronics_sonata', 'greek': 'Ηλεκτρονικό Sonata'},
    {'name': 'electronics_double_button', 'greek': 'Ηλεκτρονικό Διπλό Κουμπί'},
    {'name': 'electronics_button_key', 'greek': 'Ηλεκτρονικό Κουμπί Κλειδί'},
    {'name': 'box_35_35', 'greek': '35x35'},
    {'name': 'box_40_40', 'greek': '40x40'},
    {'name': 'box_45_45', 'greek': '45x45'},
    {'name': 'box_50_50', 'greek': '50x50'},
    {'name': 'box_vammeno', 'greek': 'Βαμμένο'},
    {'name': 'metopi_37', 'greek': '37'},
    {'name': 'metopi_42', 'greek': '42'},
    {'name': 'metopi_47', 'greek': '47'},
    {'name': 'metopi_52', 'greek': '52'},
    {'name': 'apasfalish', 'greek': 'Απασφάλιση'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              for (int i = 0; i < myList.length; i++) {
                savePreferenceValue(myList[i]['name'], controllers[i].text);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          TextEditingController controller = TextEditingController();
          controllers.add(controller);
          return FutureBuilder<String>(
            future: getPreferenceValue(myList[index]['name']),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                controller.text = snapshot.data ?? '';
                return TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: myList[index]['greek'],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
