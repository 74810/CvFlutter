import 'package:flutter/material.dart';
import 'widgets/section_title.dart';

const deepBlue = Color(0xFF12374E);
const blue = Color(0xFF669BBC);
const semiDeepBlue = Color(0xFF146687);
const lightBlue = Color(0xFF8FE1F1);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: deepBlue,
          primary: semiDeepBlue,
          secondary: lightBlue,
          surface: blue.withOpacity(0.5),
        ),
        useMaterial3: true,
      ),
      home: const CVScreen(),
    );
  }
}

class CVScreen extends StatefulWidget {
  const CVScreen({super.key});

  @override
  State<CVScreen> createState() => _CVScreenState();
}

class _CVScreenState extends State<CVScreen> {
  bool menuAbierto = false;

  static const phone = "678 88 78 54";
  static const email = "pablobarbadas@gmail.com";

  final experiencia = const [
    "Técnico de Sistemas Microinformáticos y Redes\nTelecomunicaciones Posío\n2023–2024",
    "Recepcionista de hotel\nEurostars\n2022",
    "Dependiente de supermercado\nSpar\n2021",
    "Repartidor de comida a domicilio\nDomino's Pizza\n2020",
  ];

  final estudios = const [
    "Desarrollo de Aplicaciones Multiplataforma (DAM)\nI.E.S. Fernando Wirtz\n2024–Actualidad",
    "Curso de especialización en IA\nRacksLabs\n2024",
    "Sistemas Microinformáticos y Redes (SMR)\nCIFP Marcos Valcárcel\n2018–2020",
    "Educación Secundaria Obligatoria\nCPR Luis Vives\n2017"
  ];

  final Map<String, List<String>> habilidades = {
    "Programación": ["Java", "Dart", "Python", "POO", "APIs REST", "Flutter"],
    "Sistemas": [
      "Windows",
      "Linux (Ubuntu/Debian)",
      "Gestión de usuarios y permisos",
      "Virtualización (VirtualBox)",
      "Resolución de incidencias",
    ],
    "Redes": [
      "Configuración TCP/IP",
      "Routers y switches",
      "Topologías LAN",
      "Diagnóstico de red",
      "Seguridad básica",
    ],
    "Bases de datos": [
      "Modelado entidad–relación",
      "SQL (consultas y joins)",
      "MySQL",
      "PostgreSQL",
    ],
    "Competencias personales": [
      "Trabajo en equipo",
      "Resolución de problemas",
      "Comunicación técnica",
    ],
  };

  final Map<String, bool> habilidadAbierta = {};

  @override
  void initState() {
    super.initState();
    for (final k in habilidades.keys) {
      habilidadAbierta[k] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1400;

    final perfil = _panelPerfil();

    final contenido = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (!isWide) perfil,
        if (!isWide) const SizedBox(height: 20),

        const SectionTitle(
          text: "Experiencia",
          textColor: lightBlue,
          lineColor: semiDeepBlue,
        ),
        _cardSeccion(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: experiencia
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(e),
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 20),

        const SectionTitle(
          text: "Estudios",
          textColor: lightBlue,
          lineColor: semiDeepBlue,
        ),
        _cardSeccion(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: estudios.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(e, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        const SectionTitle(
          text: "Habilidades",
          textColor: lightBlue,
          lineColor: semiDeepBlue,
        ),
        _cardSeccion(
          child: Column(
            children: habilidades.keys.map((categoria) {
              final abierta = habilidadAbierta[categoria] == true;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        habilidadAbierta[categoria] = !abierta;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categoria,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: deepBlue,
                            ),
                          ),
                          Icon(
                            abierta ? Icons.expand_less : Icons.expand_more,
                            color: deepBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Lista habilidades que se despliegan
                  if (abierta)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: habilidades[categoria]!
                            .map(
                              (skill) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text("- $skill"),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 6),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlue,
        title: const Text("ProyectoCV", style: TextStyle(color: Colors.white)), centerTitle: true,
      ),
      body: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 320, child: perfil),
                const SizedBox(width: 8),
                Expanded(child: contenido),
              ],
            )
          : contenido,
    );
  }

  Widget _panelPerfil() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: blue,
                  shape: BoxShape.circle,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  "assets/img/image.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Pablo Gil Pérez",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: deepBlue,
            ),
          ),
          const SizedBox(height: 6),
          const Text("Desarrollador Full Stack"),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.phone, size: 18, color: deepBlue),
              SizedBox(width: 6),
              Text(phone),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(Icons.email, size: 18, color: deepBlue),
              SizedBox(width: 6),
              Expanded(child: Text(email)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardSeccion({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
