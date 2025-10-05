import 'package:flutter/material.dart';

import 'activityDetail.dart';

class ActiviteTab extends StatelessWidget {
  const ActiviteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> eleves = [
      {
        "nom": "Ocean NTAMBWE",
        "classe": "4 ème Primaire",
        "imagePath": "assets/images/img1.png", // Remplace par une image existante
      },
      {
        "nom": "Lumière NTAMBWE",
        "classe": "6ème Commerciale et Gestion",
        "imagePath": "assets/images/img1.png", // Remplace par une image existante
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Activités des élèves"),
        centerTitle: true,
      ),
      body: ListView(
        children: eleves.map((eleve) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      eleve["imagePath"]!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          eleve["nom"]!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          eleve["classe"]!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),

                        SizedBox(height: 8),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActiviteDetailsScreen(
                                  nom: eleve["nom"]!,
                                  classe: eleve["classe"]!,
                                  imagePath: eleve["imagePath"]!,
                                ),
                              ),
                            );
                          },
                          child: Text("Voir les activités"),
                        ),


                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
