import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Data.dart';

convertTime(String inputTime) {
  String time = inputTime;
  int temp = int.parse(time.split(':')[0]);
  String? t;
  if (temp >= 12 && temp < 24) {
    t = " PM";
  } else {
    t = " AM";
  }
  if (temp > 12) {
    temp = temp - 12;
    if (temp < 10) {
      time = time.replaceRange(0, 2, "0$temp");
      time += t;
    } else {
      time = time.replaceRange(0, 2, "$temp");
      time += t;
    }
  } else if (temp == 00) {
    time = time.replaceRange(0, 2, '12');
    time += t;
  } else {
    time += t;
  }
  return time;
}

Future<Data> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://api.aladhan.com/v1/timingsByCity?city=Riyadh&country=Saudi Arabia&method=4'));

  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}



timeMethod(Future<Data> futureData, String pray,context) {
  return SizedBox(
    width: 50,
    child: Container(
      height: 65,
      decoration:  BoxDecoration(
        color: Colors.green.shade200,
        border: Border.all(
          color: Colors.green,
        ),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(pray),
          FutureBuilder<Data>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('${convertTime(snapshot.data!.data['timings'][pray])}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    ),
  );
}


