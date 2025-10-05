import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardSlide> slides = [
    _OnboardSlide(
      imagePath: 'assets/images/img1.png',
      title: 'Suivez vos enfants facilement',
      subtitle: "Accédez instantanément au parcours scolaire de vos enfants.",
    ),
    _OnboardSlide(
      imagePath: 'assets/images/img2.png',
      title: 'Notifications en temps réel',
      subtitle: 'Recevez les mises à jour importantes et ne manquez rien.',
    ),
    _OnboardSlide(
      imagePath: 'assets/images/img3.png',
      title: 'Communiquez avec les enseignants',
      subtitle: 'Envoyez et recevez des messages .',
    ),
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    // envoie vers la page login
    if (!mounted) return;
    context.go('/');
  }

  void _next() {
    if (_currentIndex < slides.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _completeOnboarding();
    }
  }

  void _skip() {
    _completeOnboarding();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(slides.length, (i) {
        final bool active = i == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: active ? 14 : 10,
          height: active ? 14 : 10,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.white70,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // fond bleu similaire à ton screenshot
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF3A86FF),
        child: SafeArea(
          child: Column(
            children: [
              // Skip bouton en haut à droite
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    'Passer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Zone principale : PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    final s = slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image ovale / circulaire blanche
                        Container(
                          width: size.width * 0.72,
                          height: size.height * 0.50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(120),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              s.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, e, st) {
                                return const Center(child: Icon(Icons.image, size: 64, color: Colors.grey));
                              },
                            ),
                          ),
                        ),




                        const SizedBox(height: 12),
                        // Dots
                        _buildDots(),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            s.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: Text(
                            s.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        GestureDetector(
                          onTap: _next,
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              index == slides.length - 1 ? Icons.check : Icons.arrow_forward,
                              color: const Color(0xFF3A86FF),
                              size: 28,
                            ),
                          ),
                        ),
                      ],
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

class _OnboardSlide {
  final String imagePath;
  final String title;
  final String subtitle;
  _OnboardSlide({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
