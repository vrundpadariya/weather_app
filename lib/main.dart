import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/provider/api.dart';
import 'app/provider/themeProvider.dart';
import 'app/view/homepage/Homepage.dart';
import 'app/view/homepage/SplashScreen.dart';
import 'app/view/homepage/onetime.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => APICallProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ModelTheme(),
      )
    ],
    child: Consumer<ModelTheme>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.isDark
              ? ThemeData(useMaterial3: true, brightness: Brightness.dark)
              : ThemeData(useMaterial3: true, brightness: Brightness.light),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (ctx) => const Splash_screens(),
            'into': (ctx) => const introscreen(),
            'home': (ctx) => const HomePage(),
          },
        );
      },
    ),
  ));
}
