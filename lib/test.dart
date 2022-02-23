import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

main() async {
  /*String url = "https://api.pray.zone/v2/times/today.json?city=riyadh-sa&school=4&timeformat=1&key=MagicKey&juristic=1";
  String url2 = "https://api.pray.zone/v2/times/today.json?city=riyadh-sa&school=0&timeformat=1&key=MagicKey&juristic=0";
  Response x = await get(Uri.parse(url));
  Response x2 = await get(Uri.parse(url2));

  var y = jsonDecode(x.body);
  var y2 = jsonDecode(x2.body);
  print(y['results']['datetime'][0]['times']);
  print(y2['results']['datetime'][0]['times']);*/
  String url =
      "https://api.aladhan.com/v1/timingsByCity?city=Riyadh&country=Saudi%20Arabia&method=4";
  var res = jsonDecode((await get(Uri.parse(url))).body);

  //var tt = int.parse(res['data']['timings']['Fajr']);
  print(res);
  print(res['data']['date']);
  print(res['data']['date']['gregorian']);
  print(res['data']['meta']);
  print(res['data']['timings']);

  var time = "23:43";
  var temp = int.parse(time.split(':')[0]);
  String? t;
  if(temp >= 12 && temp <24){
    t = " PM";
  }
  else{
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
  }else{
    time += t;
  }
  print(time);
}
