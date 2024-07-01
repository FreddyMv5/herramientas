import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacto',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 78, 160, 74),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 167, 247, 163), Color.fromARGB(255, 42, 104, 39)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto del perfil
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                'assets/fotopf.jpeg', // Ruta de la imagen en assets
              ),
            ),
            SizedBox(height: 20),
            // Nombre y Descripción
            Text(
              'Saludos, mi nombre es Freddy Villar!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Soy un joven estudiante de desarrollo de software en el ITLA, actualmente estoy practicando el mundo del desarrollo móvil para enfrentar todos los retos que se presenten en este mundo de la tecnología.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // Datos de Contacto
            Text(
              'Contacto:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ContactDetail(
              icon: Icons.email,
              text: 'freddyvillarccs@gmail.com',
              url: 'freddyvillarccs@gmail.com',
            ),
            ContactDetail(
              icon: Icons.phone,
              text: '829-209-1400',
              url: 'tel:+18292091400',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  final IconData icon;
  final String text;
  final String url;

  const ContactDetail({
    required this.icon,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(text),
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'No se pudo abrir el enlace $url';
        }
      },
    );
  }
}
