import 'package:flutter/material.dart';
import 'package:testx/register_visitor.dart';

import 'utils/fonts.dart';

void main() {
  runApp(const TestX());
}

class TestX extends StatelessWidget {
  const TestX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: TestXFonts.bodyFontFamily,
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: TestXFonts.headerFontFamily,
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const RegisterVisitor(),
    );
  }
}
