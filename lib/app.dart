// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/provider/movie_provider.dart';
import 'presentation/provider/search_provider.dart';
import 'presentation/screens/splash_screen.dart'; // Import the SplashScreen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false, // Remove debug banner
        theme: ThemeData.dark(), // Using dark theme for better UI
        home: const SplashScreen(), // Set SplashScreen as the home widget
      ),
    );
  }
}
