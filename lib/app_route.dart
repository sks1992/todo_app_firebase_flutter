import 'package:get/get.dart';
import 'package:todo_project/ui/screens/user_screen.dart';

class RouteNames {
  static String userScreen ="/userScreen";
}

class AppRoute {
  static final route =[
    GetPage(name: RouteNames.userScreen, page: ()=>UserScreen()),
  ];
}