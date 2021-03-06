import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Picker();
}

class _Picker extends State<Picker> {
  late Position position;

  List<String> coutries = [];
  List<String> cities = [];

  fetchCountryData() async {
    final response = await http.get(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/positions'));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      for (var y in res['data']) {
        setState(() {
          coutries.add(y['name']);
        });
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  String countyname = '';
  String cityname = '';

  fetchCityData(String val) async {
    final response = await http.post(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/cities'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'country': val,
        }));
    try {
      var res = jsonDecode(response.body);
      setState(() {
        cities.clear();
      });
      for (var y in res['data']) {
        setState(() {
          cities.add(y);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: ListView(
              children: [
                DropdownButton(
                    items: coutries
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) async {
                      if (kDebugMode) {
                        print(val);
                      }
                      fetchCityData(val as String);
                      setState(() {
                        countyname = val as String;
                      });
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('country', countyname);
                    }),
                countyname.isEmpty
                    ? Container()
                    : Center(
                        child: DropdownButton(
                            items: cities
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) async {
                              if (kDebugMode) {
                                print(val);
                              }
                              setState(() {
                                cityname = val as String;
                              });
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('city', cityname);
                            }),
                      ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await Permission.location.request();
                      await Permission.locationAlways.request();
                      await Permission.locationWhenInUse.request();
                    } catch (e) {}

                    position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setDouble('x', position.latitude);
                    await prefs.setDouble('y', position.longitude);
                    if (kDebugMode) {
                      print(position);
                    }
                  },
                  child: const Text("get location"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
