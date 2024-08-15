import 'package:flutter/material.dart';
import 'package:note_app_pc/view/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(400, 880),
    size: Size(600, 800),
    center: true,
    title: "NoteApp"
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async{
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
