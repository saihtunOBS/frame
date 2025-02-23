// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:quran_wireframe/screens/profile/test.dart';

// class NewScanner extends StatefulWidget {
//   const NewScanner({super.key});

//   @override
//   State<NewScanner> createState() => _NewScannerState();
// }

// class _NewScannerState extends State<NewScanner> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? imageFile;
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> pickImage() async {
//     imageFile = await _picker.pickImage(source: ImageSource.gallery);
//     scanText();
//     setState(() {});
//   }

//   Future<void> scanText() async {
//     final inputImage = InputImage.fromFilePath(imageFile!.path);
//     final textDetector = TextRecognizer();

//     final RecognizedText recognizedText =
//         await textDetector.processImage(inputImage);

//     extractIDDetails(recognizedText.text);

//     textDetector.close();
//   }

//   void extractIDDetails(String scannedText) {
//     RegExp namePattern = RegExp(r'Name: (\w+\s\w+)');
//     RegExp idPattern = RegExp(r'ID Number: (\d{10})');

//     String? name = namePattern.firstMatch(scannedText)?.group(1);
//     String? idNumber = idPattern.firstMatch(scannedText)?.group(1);

//     print('Name: $name');
//     print('ID Number: $idNumber');
//   }

//   // Get surname
// // var surname = await results.textFieldValueByTypeLcidSourceOriginal(FieldType.SURNAME, LCID.INDONESIAN, ResultType.VISUAL_OCR_EXTENDED, true);
// // // Get address
// // var address = await results.textFieldValueByTypeLcidSourceOriginal(FieldType.ADDRESS, LCID.LATIN, ResultType.BAR_CODES_TEXT_DATA, true);

//   // initLicense() async {
//   //   var initConfig = InitConfig(await rootBundle.load("assets/regula.license"));
//   //   await documentReader?.initializeReader(initConfig);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           spacing: 20,
//           children: [
//             const SizedBox(
//               height: 200,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   pickImage();
//                 },
//                 child: const Text('Click')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) => RecognizePage(
//                             path: imageFile!.path,
//                           )));
//                 },
//                 child: const Text('go')),
//           ],
//         ),
//       ),
//     );
//   }
// }
