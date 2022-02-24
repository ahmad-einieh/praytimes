import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main() async {
  var res = jsonDecode((await http.get(
          Uri.parse('https://countriesnow.space/api/v0.1/countries/positions')))
      .body);

  print(res['data']);
  for (var x in res['data']) {
    print(x['name']);
  }

  var res2 = await http.post(
      Uri.parse('https://countriesnow.space/api/v0.1/countries/cities'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'country': 'Saudi Arabia',
      }));

  print('--------------------------------------------------------------------');
  //print(jsonDecode(res2.body)['data']);
  for( var y in jsonDecode(res2.body)['data']){
    print(y);
  }
}
