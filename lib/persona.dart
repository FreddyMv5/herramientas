import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonaScreen extends StatefulWidget {
  @override
  _PersonaScreenState createState() => _PersonaScreenState();
}

class _PersonaScreenState extends State<PersonaScreen> {
  final TextEditingController _controller = TextEditingController();
  String _name = '';
  String _gender = '';
  bool _isLoading = false;

  Future<void> _predictGender() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io?name=$_name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
        _gender = 'error';
      });
    }
  }

  String _mapGenderToSpanish(String gender) {
    if (gender == 'male') {
      return 'hombre';
    } else if (gender == 'female') {
      return 'mujer';
    } else {
      return 'desconocido';
    }
  }

  Color _getGenderColor(String gender) {
    if (gender == 'male') {
      return Colors.blue;
    } else if (gender == 'female') {
      return Colors.pink;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Predicción de Género',
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
                'assets/genero.webp', // Cambia esta ruta a la imagen que deseas mostrar
                height: 240,
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
                onPressed: _predictGender,
                child: Text('Predecir Género'),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : _gender.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _getGenderColor(_gender),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Género: ${_mapGenderToSpanish(_gender)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PersonaScreen(),
  ));
}
