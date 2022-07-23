import 'package:expense_tracker/welcomepage.dart';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'welcomepage.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(
    /* DevicePreview(enabled: true,
    tools: [
      ...DevicePreview.defaultTools
    ], builder: (context) =>
   */ MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}