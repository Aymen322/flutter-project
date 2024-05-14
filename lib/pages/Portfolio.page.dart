import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_flutter/pages/ComCertif.page.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter/Widgets/CardTop.dart';
import 'package:projet_flutter/Widgets/ThemeNotifier.page.dart';
import 'package:projet_flutter/Widgets/_buildStudyProjects.dart';
import 'package:projet_flutter/pages/Etude.page.dart';
import 'package:projet_flutter/pages/Experience.page.dart';
import 'package:projet_flutter/pages/about.page.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<Map<String, dynamic>> _pages = [
    {'title': 'About Me', 'icon': Icons.person_outline_rounded},
    {'title': 'Experience', 'icon': Icons.work_outline_outlined},
    {'title': 'Education', 'icon': Icons.school},
    {'title': 'Competence', 'icon': Icons.star_border},
    {'title': 'Portfolio', 'icon': Icons.portrait},
  ];
  final PageController _pageController = PageController();
  Map<String, String> _translations = {};

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
          children: [
            Text(
              _translate('Portfolio'),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Spacer(),
            DropdownButton<String>(
              value: 'en',
              items: [
                const DropdownMenuItem(value: 'en', child: Text('English')),
                const DropdownMenuItem(value: 'fr', child: Text('Français')),
              ],
              onChanged: (value) async {
                await _loadTranslations(value!);
                setState(() {});
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
                      final textLength = _translate(page['title']).length;
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
              _buildStudyProjects(
                  themeNotifier.isDarkMode), // Pass isDarkMode here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudyProjects(bool isDarkMode) {
    final Map<String, IconData> frameworkIcons = {
      'Flutter': Icons.phone_android,
      'laravel.js': Icons.web,
      'Dart': Icons.code,
      '.net': Icons.flight,
      'angular': Icons.web,
      'laravel': Icons.web,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        ProjectItem(
          title: _translate('Mobile App: Cv'),
          description: _translate(
              'The project is to develop your curriculum vitae in the form of a mobile application'),
          skills: [_translate('Flutter')],
          isDarkMode: isDarkMode,
          iconData: frameworkIcons['Flutter']!,
        ),
        SizedBox(height: 20.0),
        Divider(),
        SizedBox(height: 20.0),
        ProjectItem(
          title: _translate('Web App: E-commerce Platform'),
          description:
              _translate('The project is to develop an E-commerce website'),
          skills: [_translate('Laravel.js'), _translate('Vue.js')],
          isDarkMode: isDarkMode,
          iconData: frameworkIcons['laravel.js']!,
        ),
        SizedBox(height: 20.0),
        Divider(),
        SizedBox(height: 20.0),
        ProjectItem(
          title: _translate('Web App: Carpooling Platform'),
          description:
              _translate('The project is to develop a carpooling website'),
          skills: [_translate('Angular'), _translate('Spring boot')],
          isDarkMode: isDarkMode,
          iconData: frameworkIcons['Flutter']!,
        ),
        SizedBox(height: 20.0),
        Divider(),
        SizedBox(height: 20.0),
        ProjectItem(
          title: _translate('Web App: travel agency Platform'),
          description: _translate('The project is to develop a travel agency'),
          skills: [_translate('.net')],
          isDarkMode: isDarkMode,
          iconData: frameworkIcons['.net']!,
        ),
        SizedBox(height: 20.0),
        Divider(),
        SizedBox(height: 20.0),
        ProjectItem(
          title: _translate('Web App: hotel agency Platform'),
          description: _translate('The project is to develop a hotel agency'),
          skills: [_translate('angular'), _translate('laravel')],
          isDarkMode: isDarkMode,
          iconData: frameworkIcons['angular']!,
        ),
      ],
    );
  }

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
