import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:quran_wireframe/app_data/app_data.dart';
import 'package:quran_wireframe/app_data/theme_data.dart';
import 'package:quran_wireframe/screens/bookmark/bookmark_screen.dart';
import 'package:quran_wireframe/screens/nav_screen/drawer.dart';
import 'package:quran_wireframe/screens/profile/profile_screen.dart';
import 'package:quran_wireframe/screens/profile/scanner.dart';
import 'package:quran_wireframe/screens/setting/setting_screen.dart';
import '../../controller/nav_controller.dart';
import '../home/home_screen.dart';

class NavScreens extends StatefulWidget {
  const NavScreens({super.key});

  @override
  State<NavScreens> createState() => _NavScreensState();
}

class _NavScreensState extends State<NavScreens> {
  final NavController controller = Get.put(NavController());

  final List<Widget> screens = [
    const HomeScreen(),
    const BookmarkScreen(),
     //CNICScanner(),
    // const SettingScreen(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const DrawerView(),
        appBar: appBar(),
        body: SafeArea(
          child: Obx(() => Stack(
                children: [
                  screens[controller.selectedScreen.value], // Display selected screen
                  Miniplayer(
                    minHeight: 80,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      return InkWell(
                        onTap: () => print('Tapped Miniplayer'),
                        child: Container(
                          color: Colors.red,
                          child: Center(child: Text('$height $percentage')),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.selectedScreen.value,
              onTap: (index) {
                controller.selectedScreen.value = index; // No need for setState()
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house_alt), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.bookmark), label: 'Bookmark'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: 'Setting'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_alt_circle),
                    label: 'Profile'),
              ],
            )),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(CupertinoIcons.bars),
        );
      }),
      toolbarHeight: 60,
      elevation: 0,
      title: const Text("Quran"),
      actions: [
        IconButton(
          onPressed: () {
            Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
            Get.theme.brightness == Brightness.dark
                ? AppData.shared.saveThemeMode(theme: 'light')
                : AppData.shared.saveThemeMode(theme: 'dark');
          },
          icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode),
        ),
      ],
    );
  }
}
