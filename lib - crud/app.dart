
import 'package:app/product_list_screen.dart';
import 'package:flutter/material.dart';


class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud App',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.purple)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.purple)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.red)
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: ProductListScreen(),
    );
  }
}
