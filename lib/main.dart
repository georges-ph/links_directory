import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:links_directory/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Links Directory",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.chivoTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.grey.shade300,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
        ),
      ),
    );
  }
}
