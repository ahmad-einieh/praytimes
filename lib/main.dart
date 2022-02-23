import 'dart:convert';

import 'package:flutter/material.dart';

import 'helper.dart';
import 'Data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Data> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("pray times"),),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: FutureBuilder<Data>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data!.nameOfMethod}');
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Imsak'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Fajr'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Sunrise'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Dhuhr'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Asr'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Sunset'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Maghrib'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Isha'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            timeMethod(futureData, 'Midnight'),
          ],
        ),
      ),
    );
  }
}
