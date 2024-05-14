import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_flutter/pages/Portfolio.page.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter/Widgets/CardTop.dart';
import 'package:projet_flutter/Widgets/ProgressBarCustom.dart';
import 'package:projet_flutter/Widgets/ThemeNotifier.page.dart';
import 'package:projet_flutter/pages/Etude.page.dart';
import 'package:projet_flutter/pages/Experience.page.dart';
import 'package:projet_flutter/pages/about.page.dart';

class ComCertifPage extends StatefulWidget {
  @override
  _ComCertifState createState() => _ComCertifState();
}

class _ComCertifState extends State<ComCertifPage> {
  final List<Map<String, dynamic>> _pages = [
    {'title': 'About Me', 'icon': Icons.person_outline_rounded},
    {'title': 'Experience', 'icon': Icons.work_outline_outlined},
    {'title': 'Education', 'icon': Icons.school},
    {'title': 'Competence', 'icon': Icons.star_border},
    {'title': 'Portfolio', 'icon': Icons.portrait},
  ];
  final PageController _pageController = PageController();
// Add a variable to store translations for the current language
  Map<String, String> _translations = {};

  // Add a method to load translations from JSON files
  Future<void> _loadTranslations(String language) async {
    final localeData = await rootBundle.loadString('assets/translations.json');
    final jsonData = jsonDecode(localeData) as Map<String, dynamic>;
    final translations =
        jsonData['translations'][language] as Map<String, dynamic>;

    _translations = translations.cast<String, String>();
  }

  // Pre-translate strings before building the UI
  String _translate(String key) {
    return _translations[key] ?? key; // Return key if translation not found
  }

  @override
  void initState() {
    super.initState();
    // Load translations for the default language (English) on initial state
    _loadTranslations('en');
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final translatedTitles =
        _pages.map((page) => _translate(page['title'])).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff040305),
        elevation: 0,
        title: Row(
          // Add a dropdown menu for language selection (consider state management for selected language)
          children: [
            Text(
              _translate(
                  'Compétences Et Certification'), // Translate app title using _translate method
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const Spacer(),
            DropdownButton<String>(
              value:
                  'en', // Consider using a state variable for selected language
              items: [
                const DropdownMenuItem(value: 'en', child: Text('English')),
                const DropdownMenuItem(
                    value: 'fr', child: Text('Français')), // Add French option
              ],
              onChanged: (value) async {
                // Update translations and potentially rebuild UI on language change (consider state management)
                await _loadTranslations(value!);
                setState(() {}); // Rebuild UI with new translations
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              ),
              Container(
                height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _pages.map((page) {
                      final textLength = (page['title']).length;
                      final containerWidth =
                          textLength * 15.0; // Adjust the multiplier as needed
                      return GestureDetector(
                        onTap: () {
                          final index = _pages.indexOf(page);
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          width: containerWidth,
                          height: 110,
                          child: CardTop(
                            icon: page['icon'],
                            text: (page['title']), // Use pre-translated titles
                            isColor: themeNotifier.isDarkMode,
                            page: _buildPage(page['title'], themeNotifier),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 40.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff1F1E25),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compétences',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 30.0),
                    ProgressBarCustom(
                      skill: 'angular',
                      percentage: 95,
                    ),
                    ProgressBarCustom(
                      skill: 'Springboot',
                      percentage: 80,
                    ),
                    ProgressBarCustom(
                      skill: 'Flutter',
                      percentage: 75,
                    ),
                    ProgressBarCustom(
                      skill: 'php',
                      percentage: 70,
                    ),
                    ProgressBarCustom(
                      skill: '.Net',
                      percentage: 70,
                    ),
                    ProgressBarCustom(
                      skill: 'Data Mining',
                      percentage: 70,
                    ),
                    ProgressBarCustom(
                      skill: 'java',
                      percentage: 60,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              const Text(
                'Certifications',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 15.0),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: const Color(0xff1F1E25),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: Color(0xffA36FF6),
                          size: 35,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'CCNA',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'iit - 2024',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: const Color(0xff1F1E25),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: Color(0xffA36FF6),
                          size: 35,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Delf',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'iit - 2024',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// No changes needed in _buildPage function
  Widget _buildPage(String page, ThemeNotifier themeNotifier) {
    final isColor = themeNotifier.isDarkMode;
    switch (page) {
      case 'About Me':
        return AboutMEPage(); // Assuming AboutMEPage contains translated content
      case 'Experience':
        return ExperiencePage(); // Assuming ExperiencePage contains translated content
      case 'Education':
        return EtudePage(); // Assuming EtudePage contains translated content
      case 'Competence':
        return ComCertifPage(); // Assuming ComCertifPage contains translated content
      case 'Portfolio':
        return PortfolioPage();
      default:
        return Container();
    }
  }
}
