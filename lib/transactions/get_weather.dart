import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> getWeather(String apiKey, String city) async {
  String apiUrl =
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

  http.Response response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    //Tudo ok
    return json.decode(response.body);
  } else {
    return {
      'main': {
        'temp': city == '' ? '' : 'Unknow\n${city.toUpperCase()}',
      }
    };
  }
}
