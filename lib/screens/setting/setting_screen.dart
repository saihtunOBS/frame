// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';

// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});

//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends State<SettingScreen> {
//   InputImage? inputImage;
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String result = '';
//   String idSerialNumber = "";
//   String idBirthdate = "";
//   String idValidUntil = "";
//   String idTCKN = "";
//   String idName = "";
//   String idSurname = "";
//   String idGender = "";
//   RegExp dateRegex = RegExp(
//       r'^\d{2}\.\d{2}\.\d{4}$'); // get date from picture and validate with this Regex

//   Future<void> pickImage(ImageSource source) async {
//     final XFile? pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//     }
//   }

//   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//   Future<void> processImage() async {
//     final InputImage inputImage;
//     if (_image != null) {
//       inputImage = InputImage.fromFile(_image!);
//       TextRecognizer textRecognizer =
//           TextRecognizer(script: TextRecognitionScript.latin);
//       final RecognizedText recognizedText =
//           await textRecognizer.processImage(inputImage);
//       String text = recognizedText.text;
//       List<String> lines = text.split('\n');

//       for (var element in lines) {
//         if (element.contains('Name:')) {
//           print(element.replaceAll('Name:', '').trim());
//         }
//       }
//     //   bool isSerial = false;
//     //   bool isBirthDate = false;
//     //   bool isValidUntil = false;
//     //   bool isTCKN = false;
//     //   bool isName = false;
//     //   bool isSurname = false;
//     //   bool isGender = false;
//     //   int counter = 0;

//     //   for (var line in lines) {
//     //     // print("line : $line");
//     //     if (isSerial) {
//     //       if (line.startsWith('A') && line.length == 9) {
//     //         idSerialNumber = line;
//     //         if (line[3] == '1')
//     //           idSerialNumber = idSerialNumber.replaceRange(3, 4, 'I');
//     //         if (line[3] == '0')
//     //           idSerialNumber = idSerialNumber.replaceRange(3, 4, 'O');

//     //         print("CONTROL: Serial Number $idSerialNumber");
//     //       } else {
//     //         //  Get.snackbar("Hata", "Seri Numarası Net Değil! Lütfen Tekrar Deneyin...");
//     //         break;
//     //       }
//     //       isSerial = false;
//     //     }
//     //     if (isBirthDate) {
//     //       if (double.tryParse(line[0]) != null &&
//     //           double.tryParse(line[2]) == null &&
//     //           dateRegex.hasMatch(line)) {
//     //         idBirthdate = line;
//     //         print("CONTROL: BIRTH DATE $line");
//     //       } else {
//     //         //  Get.snackbar("Hata", "Doğum Tarihi Net Değil! Lütfen Tekrar Deneyin...");

//     //         break;
//     //       }
//     //       isBirthDate = false;
//     //     }
//     //     if (isValidUntil) {
//     //       if (double.tryParse(line[0]) != null &&
//     //           double.tryParse(line[2]) == null &&
//     //           dateRegex.hasMatch(line)) {
//     //         idValidUntil = line;
//     //         print("CONTROL: VALID UNTIL:  $line");
//     //       } else {
//     //         //   Get.snackbar("Hata", "Son Geçerlilik Tarihi Net Değil! Lütfen Tekrar Deneyin...");

//     //         break;
//     //       }

//     //       isValidUntil = false;
//     //     }

//     //     //! !
//     //     if (isTCKN) {
//     //       if (true) {
//     //         print("CONTROL: TCKN:  $line");
//     //       }

//     //       isTCKN = false;
//     //     }
//     //     if (isName) {
//     //       if (true) {
//     //         idName = line;
//     //         print("CONTROL: NAME:  $line");
//     //       }

//     //       isName = false;
//     //     }
//     //     if (isSurname) {
//     //       if (true) {
//     //         idSurname = line;
//     //         print("CONTROL: SURNAME:  $line");
//     //       }

//     //       isSurname = false;
//     //     }

//     //     if (line.contains("Birth") ||
//     //         line.contains("Date") ||
//     //         line.contains("Doğum") ||
//     //         line.contains("Tarihi") ||
//     //         line.contains("Tarini") ||
//     //         line.contains("Tartini") ||
//     //         line.contains("Doğu")) {
//     //       isBirthDate = true;
//     //       counter++;
//     //     }

//     //     if (line.contains("Seri") ||
//     //         line.contains("Document") ||
//     //         line.contains("Ser") ||
//     //         line.contains("Doc")) {
//     //       isSerial = true;
//     //       counter++;
//     //     }

//     //     if (line.contains("Son") ||
//     //         line.contains("Geçerlilik") ||
//     //         line.contains("Valid") ||
//     //         line.contains("Until") ||
//     //         line.contains("Geçer") ||
//     //         line.contains("Valia") ||
//     //         line.contains("Unti") ||
//     //         line.contains("Geçeri") ||
//     //         line.contains("Geçerli")) {
//     //       isValidUntil = true;
//     //       counter++;
//     //     }
//     //     if (line.contains("Kimlik No") ||
//     //         line.contains("Kimlik") ||
//     //         line.contains("TR Identity") ||
//     //         line.contains("Identity No") ||
//     //         line.contains("Identity") ||
//     //         line.contains("TR") ||
//     //         line.contains("entity") ||
//     //         line.contains("ity No")) {
//     //       isTCKN = true;
//     //       counter++;
//     //     }
//     //     if (line.contains("Soyadı") ||
//     //         line.contains("Surname") ||
//     //         line.contains("Soyadi") ||
//     //         line.contains("urname") ||
//     //         line.contains("Soyad")) {
//     //       isSurname = true;
//     //       counter++;
//     //     }
//     //     if (line.contains("Adı") ||
//     //         line.contains("Adi") ||
//     //         line.contains("Given Name") ||
//     //         line.contains("Name(s)") ||
//     //         line.contains("Give") ||
//     //         line.contains("Name") ||
//     //         line.contains("Gven")) {
//     //       isName = true;
//     //       counter++;
//     //     }

//     //     print(line);
//     //   }
//     //   if (counter != 6) {
//     //     // Get.snackbar("Error",
//     //     //     "Some data couldn't be retrieved from the ID card photo. Please check photo quality and try again...",
//     //     //     backgroundColor: Colors.red, colorText: Colors.white);
//     //   } else {
//     //     // Get.snackbar(
//     //     //   'Success',
//     //     //   'Data successfully extracted from ID card photo.',
//     //     //   backgroundColor: Colors.green,
//     //     //   colorText: Colors.white,
//     //     // );
//     //   }
//     // }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           spacing: 20,
//           children: [
//             _image != null
//                 ? SizedBox(height: 200, width: 200, child: Image.file(_image!))
//                 : const SizedBox(),
//             Text(result),
//             ElevatedButton(
//                 onPressed: () {
//                   pickImage(ImageSource.camera);
//                 },
//                 child: const Text('click')),
//             ElevatedButton(
//                 onPressed: () {
//                   processImage();
//                 },
//                 child: const Text('process image')),
//           ],
//         ),
//       ),
//     );
//   }
// }
