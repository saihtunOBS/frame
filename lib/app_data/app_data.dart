import 'package:get_storage/get_storage.dart';

class AppData {
  final storage = GetStorage();
  static var shared = AppData();

  saveThemeMode({required String theme}){
    storage.write('theme', theme);
  }

 String getThemeMode(){
    return storage.read('theme') ?? 'light';
  }
}