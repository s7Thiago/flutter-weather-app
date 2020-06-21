import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/change_city.dart';
import 'package:flutter_weather_app/transactions/get_weather.dart';
import 'package:flutter_weather_app/util/util.dart' as util;

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String _insertedCity;

  Future _openScreen(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ChangeCity();
    }));

    if (result != null && result.containsKey('city')) {
      _insertedCity = result['city'];
      debugPrint('Cidade inserida: $_insertedCity');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather App'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _openScreen(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/umbrella.png',
              color: Colors.red,
              colorBlendMode: BlendMode.darken,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 80, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (_insertedCity ?? util.targetCity).toUpperCase(),
                  style: util.cityTextStyle,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/light_rain.png'),
          ),
          updateWeather(_insertedCity)
        ],
      ),
    );
  }

  Widget updateWeather(String city) {
    return FutureBuilder(
      future: getWeather(util.appId, city ?? util.targetCity),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          //Verificando se existem dados no snapshot
          Map content = snapshot.data;

          return Container(
            margin: const EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    content['main']['temp'].toString().contains('Unknow')
                        ? content['main']['temp']
                        : content['main']['temp'] == ''
                            ? ''
                            : '${content['main']['temp'].toString()} Cº',
                    style: util.tempTextStyle,
                  ),
                  subtitle: ListTile(
                    title: Text(
                      content['main']['temp'].toString() == ''
                          ? ''
                          : content['main']['temp']
                                  .toString()
                                  .contains('Unknow')
                              ? ''
                              : 'Humidade: ${content['main']['humidity'].toString()}\n'
                                  'Min: ${content['main']['temp_min'].toString()} ºC\n'
                                  'Max: ${content['main']['temp_max'].toString()} ºC',
                      style: util.extraTemp,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            child: Text('Falha ao obter dados'),
          );
        }
      },
    );
  }
}
