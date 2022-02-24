import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:praytimes/Country_Data.dart';
import 'package:http/http.dart' as http;

class Picker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Picker();
}

class _Picker extends State<Picker> {
  late Future<CountryData> futureCountryData;

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  List<String> xxx = [];

  Future<CountryData> fetchCountryData() async {
    final response = await http.get(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/positions'));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      for (var y in res['data']) {
        setState(() {
          xxx.add(y['name']);
        });
      }
      return CountryData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCountryData = fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: ListView(
              children: [
                DropdownButton(
                    items: xxx
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      print(val);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
