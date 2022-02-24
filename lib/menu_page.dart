import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:praytimes/picker_of_city.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Picker()),
                    );
                  }
                },
                child: Text("1")),
            Text("2"),
            Text("3"),
            Text("4"),
            Text("5"),
          ],
        ),
      ),
    );
  }
}
