import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const _WeatherApp(),
    );
  }
}

class _WeatherApp extends StatefulWidget {
  const _WeatherApp({super.key});

  @override
  State<_WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<_WeatherApp> {

  //変数定義
  TextEditingController controller = TextEditingController(); //入力欄
  String location = ''; //地域
  String weather = ''; //天気
  double temperature = 0.00; //気温
  double maxTemperature = 0.00; //最高気温
  double minTemperature = 0.00; //最低気温
  int humidity = 0; //湿度

  //非同期関数
  Future<void> loadWeather(String query) async {
    //入力欄(英字)に紐づく地域の天気情報を取得する。
    final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?appid=f0358874a07d87fa9b24a9ba9a4d32ba&lang=ja&units=metric&q=$query'));

    if (response.statusCode != 200) {
      return;
    } else {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      print(body);
      final main = (body['main'] ?? {}) as Map<String, dynamic>;
      final weatherMain = (body['weather'] ?? {}) as List<dynamic>;
      setState(() {
        location = (body['name'] ?? '');
        weather = (weatherMain[0]['description']?? '');
        temperature = (main['temp'] ?? 0) as double;
        maxTemperature = (main['temp_max'] ?? 0) as double;
        minTemperature = (main['temp_min'] ?? 0) as double;
        humidity = (main['humidity'] ?? 0) as int;
      });
    }
  }

  //画面描画
  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (value.isNotEmpty) {
              loadWeather(value);
            }
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(title: Text('地域'), subtitle: Text(location),),
          ListTile(title: Text('天気'), subtitle: Text(weather),),
          ListTile(title: Text('温度'), subtitle: Text(temperature.toString()),),
          ListTile(title: Text('最高気温'), subtitle: Text(maxTemperature.toString()),),
          ListTile(title: Text('最低気温'), subtitle: Text(minTemperature.toString()),),
          ListTile(title: Text('湿度'), subtitle: Text(humidity.toString()),)
        ],
      ),
    );
  }
}
