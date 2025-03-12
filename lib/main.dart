import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran_wireframe/app_data/app_data.dart';
import 'package:quran_wireframe/app_data/theme_data.dart';
import 'package:quran_wireframe/firebase_options.dart';

import 'routes/route_helper.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_binding/app_binding.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  await GetStorage.init();
  await dep.init();
  if (AppData.shared.getThemeMode() == 'light') {
    Get.changeTheme(lightTheme);
  } else {
    Get.changeTheme(darkTheme);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Center(
        child: ElevatedButton(
            onPressed: () async {
              await FirebaseAnalytics.instance.logEvent(
                name: "USER",
              ).whenComplete((){
                print('success');
              }).catchError((e){
                print('object');
              });
            },
            child: Text('Test')),
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
    );
  }
}

class ScannerN extends StatefulWidget {
  const ScannerN({super.key});

  @override
  State<ScannerN> createState() => _ScannerNState();
}

class _ScannerNState extends State<ScannerN> {
  final picker = ImagePicker();
  String extractedData = '';

  String apiKey = "AIzaSyCmw9TNkD5qAPSqIHn3LB02FyV4nepQSMo";
  String url =
      "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCmw9TNkD5qAPSqIHn3LB02FyV4nepQSMo";

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      readTextFromImage(image: File(pickedFile.path));
      callGemini(imagePath: pickedFile.path);
    }
  }

  Future<void> readTextFromImage({required File image}) async {}

  Future<void> callGemini({required String imagePath}) async {
    final bytes = File(imagePath).readAsBytesSync();
    final String base64Image = base64Encode(bytes);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "requests": [
            {
              "image": {'content': base64Image},
              'features': [
                {'type': 'LABEL_DETECTION', 'maxResults': 10},
                {'type': 'OBJECT_LOCALIZATION', 'maxResults': 10}
              ]
            }
          ]
        }),
      );

      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }

    //   if (response.statusCode == 200) {
    //     print('object');
    //     var data = jsonDecode(response.body);
    //     var textResponse = data['candidates'][0]['content']['parts'][0]['text'];

    //     var filterData = textResponse.replaceAll('`', "");
    //     var mapData = json.decode(filterData);

    //     // print("Company Name: ${mapData["company_name"]}");
    //     // print("Person Name: ${mapData["person_name"]}");
    //     // print("Email: ${mapData["email"]}");
    //     // print("Website: ${mapData["website"]}");
    //     // print("Phone Number: ${mapData["phone_number"]}");
    //     // print("Address: ${mapData["address"]}");
    //   } else {
    //     print("Failed to get response: ${response.body}");
    //   }
    // } catch (e) {
    //   print("Error calling Gemini: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              getImageFromGallery();
            },
            child: Text('Open gallery')),
      ),
    );
  }
}
