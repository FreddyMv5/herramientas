import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EdadScreen extends StatefulWidget {
  @override
  _EdadScreenState createState() => _EdadScreenState();
}

class _EdadScreenState extends State<EdadScreen> {
  final TextEditingController _controller = TextEditingController();
  String _name = '';
  int _age = 0;
  String _ageCategory = '';
  bool _isLoading = false;

  Future<void> _getAge() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.agify.io?name=$_name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
        _ageCategory = _categorizeAge(_age);
        _isLoading = false;
      });
    } else {
      // Manejo de errores
      setState(() {
        _isLoading = false;
        _ageCategory = 'error';
      });
    }
  }

  String _categorizeAge(int age) {
    if (age < 18) {
      return 'joven';
    } else if (age <= 65) {
      return 'adulto';
    } else {
      return 'anciano';
    }
  }

  String _mapCategoryToSpanish(String category) {
    switch (category) {
      case 'joven':
        return 'Joven';
      case 'adulto':
        return 'Adulto';
      case 'anciano':
        return 'Anciano';
      default:
        return 'Desconocido';
    }
  }

  String _getImageForCategory(String category) {
    switch (category) {
      case 'joven':
        return 'assets/joven.jpg'; 
      case 'adulto':
        return 'assets/adulto.jpg'; 
      case 'anciano':
        return 'assets/anciano.jpg'; 
      default:
        return 'assets/error.png';  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Predicción de Edad',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/edades.jpg', 
                height: 230,
              ),
              SizedBox(height: 50),
              
              Text(
                'Escribe tu nombre para saber qué edad tienes',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(137, 79, 127, 223),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getAge,
                child: Text('Obtener Edad'),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : _age > 0
                      ? Column(
                          children: [
                            Image.asset(
                              _getImageForCategory(_ageCategory),
                              height: 100,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Edad: $_age años',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Categoría: ${_mapCategoryToSpanish(_ageCategory)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
