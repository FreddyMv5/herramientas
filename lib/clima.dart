import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClimaScreen extends StatefulWidget {
  @override
  _ClimaScreenState createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  String _description = '';
  double _temperature = 0.0;
  String _icon = '';
  bool _isLoading = false;
  String _apiKey = '13ebc22588a54163bca01ebd148ca10b'; // Reemplaza con tu clave de API de Weatherbit

  final double _lat = 18.4861; // Latitud de Santo Domingo
  final double _lon = -69.9312; // Longitud de Santo Domingo

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://api.weatherbit.io/v2.0/current?lat=$_lat&lon=$_lon&key=$_apiKey&units=M&lang=es';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _description = data['data'][0]['weather']['description'];
        _temperature = data['data'][0]['temp'];
        _icon = data['data'][0]['weather']['icon'];
        _isLoading = false;
      });
    } else {
      // Manejo de errores
      setState(() {
        _isLoading = false;
        _description = 'Error al obtener el clima';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clima en RD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 253, 255, 126),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 34, 175, 241), Color.fromARGB(255, 170, 228, 255)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_icon.isNotEmpty)
                      Image.network(
                        'https://www.weatherbit.io/static/img/icons/$_icon.png',
                        height: 150,
                      ),
                    SizedBox(height: 50),
                    Text(
                      'Santo Domingo',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$_description',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${_temperature.toStringAsFixed(1)} °C',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
