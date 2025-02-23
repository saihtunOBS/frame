import 'package:get/instance_manager.dart';
import 'package:quran_wireframe/controller/nav_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => NavController());
}
