import 'package:flutter/material.dart';
import 'package:formation/data/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'pages/note_list_page.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(ChangeNotifierProvider(
    create: (context) => NoteDatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
    const nhitecRed = Color(0xFFC11B17);
    const nhitecDark = Color(0xFF303030);
    const nhitecLight = Color(0xFFF6F6F6);

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: nhitecRed,
      brightness: brightness,
      surface: brightness == Brightness.light ? nhitecLight : nhitecDark,
      primary: nhitecRed.withAlpha(85),
      secondary: brightness == Brightness.light ? nhitecDark : nhitecLight,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: nhitecRed.withAlpha(150),
        foregroundColor: nhitecLight,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: nhitecRed.withAlpha(150),
        foregroundColor: nhitecLight,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: brightness == Brightness.light ? nhitecDark : nhitecLight,
          fontSize: 18,
        ),
        displayMedium: TextStyle(
          color: brightness == Brightness.light ? nhitecDark : nhitecLight,
          fontSize: 14,
        ),
        displaySmall: TextStyle(
          color: brightness == Brightness.light ? nhitecDark : nhitecLight,
          fontSize: 12,
        ),
      ),
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formation N-HiTec',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const NoteListPage(),
    );
  }
}
