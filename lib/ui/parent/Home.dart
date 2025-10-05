import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:slatereduc/ui/parent/chat.dart';
import 'package:slatereduc/ui/parent/activity.dart';
import 'package:slatereduc/ui/parent/profil.dart';
import 'package:slatereduc/ui/parent/widget.dart';


class HomePage extends StatefulWidget {
 // final void Function(bool)? onThemeModeChanged;
  //final bool isDarkMode;
  //final String username;
  //const HomePage({super.key, this.onThemeModeChanged, this.isDarkMode = false, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  int _selectedIndex = 0;
  int _currentChildIndex = 0; // Nouvel état pour suivre l'enfant actuel

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentChildIndex = _controller.page?.round() ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Ajout des pages pour chaque onglet du BottomNavigationBar
  List<Widget> get _pages => [
    _HomeTab(controller: _controller, currentChildIndex: _currentChildIndex, username: '',
       // username: widget.
    ),
    ChatTab(),
    ActiviteTab(),
    ProfilTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Activité",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Définition des bases de chaque interface
class _HomeTab extends StatelessWidget {
  final PageController controller;
  final int currentChildIndex;
  final String username;

  const _HomeTab({required this.controller, required this.currentChildIndex, required this.username});

  // Données des statistiques pour chaque enfant
  final List<Map<String, List<Map<String, String>>>> _childrenStats = const [
    {
      "stats": [
        {"value": "83%", "label": "Moyenne Périodique"},
        {"value": "6/50", "label": "Place au classement"},
      ]
    },
    {
      "stats": [
        {"value": "75%", "label": "Moyenne Périodique"},
        {"value": "12/50", "label": "Place au classement"},
      ]
    },
    {
      "stats": [
        {"value": "92%", "label": "Moyenne Périodique"},
        {"value": "3/50", "label": "Place au classement"},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentStats = _childrenStats[currentChildIndex]["stats"]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person, size: 32, color: Colors.white),
                backgroundColor: Colors.blue,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bonjour,",
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications_none),
            ],
          ),
          const SizedBox(height: 20),

          // CARTE ENFANT
          SizedBox(
            height: 180, // hauteur du PageView
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                ChildCard(
                  name: "Ocean Ntambwe",
                  level: "5ème Primaire",
                  presence: [true, true, false, true, false, false],
                ),
                ChildCard(
                  name: "Luna Kabila",
                  level: "3ème Primaire",
                  presence: [true, true, true, true, true, false],
                ),
                ChildCard(
                  name: "Eliot Mvemba",
                  level: "2ème Primaire",
                  presence: [true, false, true, true, false, false],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // STATISTIQUES - QUI CHANGE AVEC L'ENFANT
          Container(
            width: double.infinity, // occupe toute la largeur
            margin: const EdgeInsets.symmetric(horizontal: 12), // marge externe
            padding: const EdgeInsets.all(16), // espace interne
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade700],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  "Statistiques Périodique",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final stat in currentStats)
                      StatItem(value: stat["value"]!, label: stat["label"]!),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3, // nombre d'enfants
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
                spacing: 4,
              ),
            ),
          ),

          const SizedBox(height: 24),

// SECTION PROGRESSION
          const Text(
            "Progression",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Moyenne Mathématique",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "L'élève Océan Ntambwe doit améliorer sa moyenne",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(
                        value: 0.3, // 30%
                        strokeWidth: 5,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    const Text(
                      "30%",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

// SECTION DISCIPLINE
          const Text(
            "Discipline",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.rule, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Barème de sanction",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "L'élève Mulsagwa a déjà enregistré 3 absences sur 4 sans justification",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(
                        value: 0.75, // 75%
                        strokeWidth: 5,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    const Text(
                      "75%",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
