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
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: brightness == Brightness.light ? Colors.green : Colors.red,
      brightness: brightness,
    );

    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 18,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 14,
        ),
        displaySmall: TextStyle(
          color: colorScheme.onSecondaryContainer,
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
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const NoteListPage(),
    );
  }
}
