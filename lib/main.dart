import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _cityName = "La Paz";
  String _apiKey = "886705b4c1182eb1c69f28eb8c520e20";
  String _apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=";
  String _temperature = "";
  String _description = "";

  Future<void> _fetchData() async {
    final response =
    await http.get(Uri.parse("$_apiUrl$_cityName&appid=$_apiKey&units=metric&lang=es"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _temperature = "${data['main']['temp']} °C";
        _description = data['weather'][0]['description'];
      });
    } else {
      setState(() {
        _temperature = "Unable to get temperature.";
        _description = "Unable to get description.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ciudad: $_cityName',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Temperatura: $_temperature',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Descripción: $_description',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
