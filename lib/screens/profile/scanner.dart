// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';

// class CNICScanner extends StatefulWidget {
//   const CNICScanner({super.key});

//   @override
//   CNICScannerState createState() => CNICScannerState();
// }

// class CNICScannerState extends State<CNICScanner> {
//   final ImagePicker _picker = ImagePicker();
//   String scannedText = "";

//   Future<void> pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return;

//     final inputImage = InputImage.fromFile(File(image.path));
//     recognizeText(inputImage);
//   }

//   Future<void> recognizeText(InputImage image) async {
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(image);
//     textRecognizer.close();

//     print("Full Extracted Text: \n" + recognizedText.text); // Debugging

//     List<String> lines = recognizedText.text.split('\n');
//     String detectedID = "No ID found";

//     for (String line in lines) {
//       if (RegExp(r'\b\d{5}-\d{7}-\d\b').hasMatch(line)) {
//         // ID format
//         detectedID = line;
//         break;
//       }
//     }

//     setState(() {
//       scannedText = detectedID;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('CNIC Scanner')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               scannedText,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: pickImage,
//               child: Text('Pick Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
