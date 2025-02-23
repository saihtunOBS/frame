import 'package:get/get.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/nav_screen/nav_screen.dart';

class RouteHelper {
  static const String initial = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String splash = "/splash";

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          Get.arguments;
          NavScreens navScreens = Get.arguments;
          return navScreens;
        },
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: login,
        page: () => const LoginScreen(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: register,
        page: () => const RegisterScreen(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    
  ];
}