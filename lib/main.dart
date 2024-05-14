import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_flutter/Widgets/ThemeNotifier.page.dart';
import 'package:projet_flutter/pages/about.page.dart';
import 'package:projet_flutter/Widgets/splash_screen.dart'; // Import the SplashScreen widget
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme:
              themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          localizationsDelegates: const [
            // AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English (United States)
            const Locale('fr', 'FR'), // French (France)
          ],
          debugShowCheckedModeBanner: false,
          title: 'CV Mobile',
          initialRoute: 'splash',
          routes: {
            'splash': (_) => SplashScreen(),
            'about': (_) => AboutMEPage(),
          },
        );
      },
    );
  }
}
