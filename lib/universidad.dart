import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; 

class UniversidadScreen extends StatefulWidget {
  @override
  _UniversidadScreenState createState() => _UniversidadScreenState();
}

class _UniversidadScreenState extends State<UniversidadScreen> {
  final TextEditingController _controller = TextEditingController();
  String _country = '';
  bool _isLoading = false;
  List<dynamic> _universities = [];

  Future<void> _fetchUniversities() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$_country'));

    if (response.statusCode == 200) {
      setState(() {
        _universities = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      // Manejo de errores
      setState(() {
        _isLoading = false;
        _universities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Universidades por País',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      //Degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 239, 229, 92), Color.fromARGB(255, 249, 239, 106)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/universidad.jpg', // Cambia esta ruta a la imagen que deseas mostrar
                    height: 230,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Escribe el nombre de un país para ver sus universidades',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _country = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _fetchUniversities,
                  child: Text('Buscar Universidades'),
                ),
                SizedBox(height: 25),
                _isLoading
                    ? CircularProgressIndicator()
                    : _universities.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _universities.length,
                            itemBuilder: (context, index) {
                              final university = _universities[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(university['name']),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Dominio: ${university['domains'][0]}'),
                                      GestureDetector(
                                        onTap: () {
                                          _launchURL(university['web_pages'][0]);
                                        },
                                        child: Text(
                                          university['web_pages'][0],
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
