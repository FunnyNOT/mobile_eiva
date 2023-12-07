import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eiva_mobile/MyList.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  void initState() {
    super.initState();
    // Initialize controllers after myList is populated
    controllers =
        List.generate(myList.length, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    myList.sort((a, b) => b['group'].compareTo(a['group']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ρυθμίσεις'),
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                if (index == 0 ||
                    myList[index]['group'] != myList[index - 1]['group'])
                  Text(
                    myList[index]['group'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                FutureBuilder<String>(
                  future: getPreferenceValue(myList[index]['name']),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      controllers[index].text = snapshot.data ?? '';
                      return TextFormField(
                        controller: controllers[index],
                        decoration: InputDecoration(
                          labelText: myList[index]['greek'],
                          labelStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (value) {
                          savePreferenceValue(myList[index]['name'], value);
                        },
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
