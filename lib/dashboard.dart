import 'package:flutter/material.dart';
import 'package:herra_app/persona.dart';
import 'package:herra_app/clima.dart';
import 'package:herra_app/edad.dart';
import 'package:herra_app/universidad.dart';
import 'package:herra_app/wordpress.dart';
import 'package:herra_app/contacto.dart';


class Dashboard extends StatelessWidget {
  // Lista de rutas de las imágenes
  final List<String> imgSrc = [
    "assets/persona.png",
    "assets/edad.png",
    "assets/uni.png",
    "assets/clima.webp",
    "assets/wordpress.png",
    "assets/contacto.jpg",
  ];

  // Lista de títulos correspondientes a las imágenes
  final List<String> tittles = [
    "Género",
    "Edad",
    "Universidad",
    "Clima",
    "WordPress",
    "Contacto",
  ];

  // Lista de pantallas a las que navegar
  final List<Widget> pages = [
    PersonaScreen(),
    EdadScreen(),
    UniversidadScreen(),
    ClimaScreen(),
    WordpressScreen(),
    ContactoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener la altura y el ancho de la pantalla
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo,
          width: width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.25,
                width: width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.sort,
                              color: Colors.indigo,
                              size: 40,
                            ),
                          ),
                          // Imagen de perfil
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/ing.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Texto principal
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Herramientas",
                            style: TextStyle(
                              fontSize: 38,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Freddy Manuel Villar Abreu / 2021-1870",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                width: width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: imgSrc.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navegar a la pantalla correspondiente al hacer clic en un ítem del GridView
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              imgSrc[index],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              tittles[index],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
