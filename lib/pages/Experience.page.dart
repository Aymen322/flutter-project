import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_flutter/Widgets/CardTop.dart';
import 'package:projet_flutter/Widgets/ExperienceCard.dart';
import 'package:projet_flutter/Widgets/ThemeNotifier.page.dart';
import 'package:projet_flutter/pages/ComCertif.page.dart';
import 'package:projet_flutter/pages/Etude.page.dart';
import 'package:projet_flutter/pages/Portfolio.page.dart';
import 'package:projet_flutter/pages/about.page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final List<Map<String, dynamic>> _pages = [
    {'title': 'About Me', 'icon': Icons.person_outline_rounded},
    {'title': 'Experience', 'icon': Icons.work_outline_outlined},
    {'title': 'Education', 'icon': Icons.school},
    {'title': 'Competence', 'icon': Icons.star_border},
    {'title': 'Portfolio', 'icon': Icons.portrait},
  ];
  final PageController _pageController = PageController();
  Map<String, String> _translations = {};
  String _selectedLanguage = 'en'; // Default language is English

  Future<void> _loadTranslations(String language) async {
    final localeData =
        await rootBundle.loadString('lib/assets/translations.json');
    final jsonData = jsonDecode(localeData) as Map<String, dynamic>;
    final translations =
        jsonData['translations'][language] as Map<String, dynamic>;

    _translations = translations.cast<String, String>();
  }

  String _translate(String key) {
    return _translations[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _loadTranslations(_selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff040305),
        elevation: 0,
        title: Row(
          children: [
            Text(
              _translate('Experience'),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            DropdownButton<String>(
              value: _selectedLanguage, // Reflects the selected language
              items: [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'fr', child: Text('Français')),
              ],
              onChanged: (value) async {
                await _loadTranslations(value!);
                setState(() {
                  _selectedLanguage = value; // Update the selected language
                });
              },
              dropdownColor: themeNotifier.isDarkMode
                  ? Colors.black
                  : Colors.white, // Set dropdown color based on theme
              style: TextStyle(
                color: themeNotifier.isDarkMode
                    ? Colors.white
                    : Colors.black, // Set text color based on theme
              ),
              iconEnabledColor: themeNotifier.isDarkMode
                  ? Colors.white
                  : Colors.black, // Set icon color based on theme
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
                      final textLength = _translate(page['title']).length;
                      final containerWidth =
                          textLength * 15.0; // Adjust the multiplier as needed
                      return GestureDetector(
                        onTap: () {
                          final index = _pages.indexOf(page);
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          width: containerWidth,
                          height: 110,
                          child: CardTop(
                            icon: page['icon'],
                            text: _translate(page['title']),
                            isColor: themeNotifier.isDarkMode,
                            page: _buildPage(page['title'], themeNotifier),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ExperienceCard(
                title: _translate('Internship: Website CvThéque'),
                duration: 'Actia - June 2021 to August 2021',
                description:
                    _translate('Design and development of a website Cvthéque'),
                imagePath: 'lib/assets/image1.jpg',
                url:
                    'https://www.actia.com/pays/tunisie/', // URL specific to this ExperienceCard
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              ExperienceCard(
                title: _translate('Internship: CA forecast kastelo'),
                duration: 'Kastelo - August 2023 to September 2023',
                description:
                    _translate('Prediction model to predict boutique turnover'),
                imagePath: 'lib/assets/image2.png',
                url:
                    'https://kastelo.com.tn/', // URL specific to this ExperienceCard
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              ExperienceCard(
                title: _translate('Internship: Dashboard with BI'),
                duration: 'Clinisys - February 2022 to May 2022',
                description: _translate(
                    'Analyze experimental data with solid expertise in data visualization and analysis using advanced Power BI usage'),
                imagePath: 'lib/assets/image3.png',
                url:
                    'https://csys.com.tn/', // URL specific to this ExperienceCard
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String page, ThemeNotifier themeNotifier) {
    final isColor = themeNotifier.isDarkMode;
    switch (page) {
      case 'About Me':
        return AboutMEPage();
      case 'Experience':
        return ExperiencePage();
      case 'Education':
        return EtudePage();
      case 'Competence':
        return ComCertifPage();
      case 'Portfolio':
        return PortfolioPage();
      default:
        return Container();
    }
  }
}
