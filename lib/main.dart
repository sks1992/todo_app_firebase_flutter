import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TODOApp());
}

class TODOApp extends StatelessWidget {
  const TODOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO App',
      enableLog: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.userScreen,
      getPages: AppRoute.route,
    );
  }
}

