import 'package:flutter/material.dart';
import 'package:eiva/navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eiva'),
      ),
      body: const Center(
        child: Text('HomePage'),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
