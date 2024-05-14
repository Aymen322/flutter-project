import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter/Widgets/CardTop.dart';
import 'package:projet_flutter/Widgets/InfoCard.dart';
import 'package:projet_flutter/Widgets/ThemeNotifier.page.dart';
import 'package:projet_flutter/pages/ComCertif.page.dart';
import 'package:projet_flutter/pages/Etude.page.dart';
import 'package:projet_flutter/pages/Experience.page.dart';
import 'package:projet_flutter/pages/Portfolio.page.dart';
import 'package:url_launcher/url_launcher.dart';

// Import necessary libraries for translation
import 'package:flutter/services.dart'; // for rootBundle
import 'package:intl/intl.dart'; // for translations

class AboutMEPage extends StatefulWidget {
  @override
  _AboutMEPageState createState() => _AboutMEPageState();
}

class _AboutMEPageState extends State<AboutMEPage> {
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
  String _selectedLanguage = 'en';

  // Add a method to load translations from JSON files
  Future<void> _loadTranslations(String language) async {
    final localeData =
        await rootBundle.loadString('lib/assets/translations.json');
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
          children: [
            Text(
              _translate('About Me'),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'fr', child: Text('Français')),
              ],
              onChanged: (value) async {
                setState(() {
                  _selectedLanguage = value!;
                });
                await _loadTranslations(value!);
              },
              dropdownColor:
                  themeNotifier.isDarkMode ? Colors.black : Colors.white,
              style: TextStyle(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                // Adjust text color based on theme
              ),
              iconEnabledColor:
                  themeNotifier.isDarkMode ? Colors.white : Colors.black,
              // Adjust the color of the selected item based on the theme
              selectedItemBuilder: (BuildContext context) {
                return [
                  for (var item in ['English', 'Français'])
                    DropdownMenuItem(
                      value: item == 'English' ? 'en' : 'fr',
                      child: Text(
                        item,
                        style: TextStyle(
                          color: themeNotifier.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                ];
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                          text: _translate(
                              page['title']), // Use pre-translated titles
                          isColor: themeNotifier.isDarkMode,
                          page: _buildPage(page['title'], themeNotifier),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _pages.map((page) {
                  final translatedInfo = {
                    'Full Name': _translate('Full Name'),
                    'Date of Birth': _translate('Date of Birth'),
                    'Place of Birth': _translate('Place of Birth'),
                    'Address': _translate('Address'),
                    'Phone': _translate('Phone'),
                    'Email': _translate('Email'),
                  };
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(
                                'lib/assets/my_photo.jpg'), // Replace with your own image path
                          ),
                          const SizedBox(height: 20),
                          InfoCard(
                            text: translatedInfo['Full Name'] ??
                                'Full Name', // Use pre-translated info labels or fallback to default
                            value: 'Kharrat yasmine ',
                          ),
                          InfoCard(
                            text: translatedInfo['Date of Birth'] ??
                                'Date of Birth',
                            value: '16 Janvier 2001',
                          ),
                          InfoCard(
                            text: translatedInfo['Place of Birth'] ??
                                'Place of Birth',
                            value: 'Douz, Tunisie',
                          ),
                          InfoCard(
                            text: translatedInfo['Address'] ?? 'Address',
                            value: 'Route MAnzel cheker , Sfax, Tunisie',
                            onTap: () {
                              _launchMapsURL(
                                  'Route MAnzel cheker , Sfax, Tunisie');
                            },
                            showClickMessage:
                                true, // Add this parameter to show the click message
                          ),
                          InfoCard(
                            text: translatedInfo['Phone'] ?? 'Phone',
                            value: '+216 20 568 004',
                          ),
                          InfoCard(
                            text: translatedInfo['Email'] ?? 'Email',
                            value: 'kharratyasmine@gmail.com',
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchMapsURL(String address) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(address)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
