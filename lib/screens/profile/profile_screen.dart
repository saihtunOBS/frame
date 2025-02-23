// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   ProfileScreenState createState() => ProfileScreenState();
// }

// class ProfileScreenState extends State<ProfileScreen> {
//   File? _image;
//   String scannedText = "";
//   final ImagePicker _picker = ImagePicker();

//   // Pick an image from Camera or Gallery
//   Future<void> pickImage(ImageSource source) async {
//     final XFile? pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//       processImage(File(pickedFile.path));
//     }
//   }

//   // Process the Image & Extract Text using ML Kit OCR
//   Future<void> processImage(File image) async {
//     final inputImage = InputImage.fromFile(image);
//     final textRecognizer = GoogleMlKit.vision.textRecognizer();
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);

//     setState(() => scannedText = recognizedText.text);
//     textRecognizer.close();
//   }

//   // Extract structured data (Name, Email, Phone, Address)
//   Map<String, String> extractDetails(String text) {
//     Map<String, String> details = {};

//     // Extract Name (Assuming first line is name)
//     List<String> lines = text.split("\n");
//     if (lines.isNotEmpty) {
//       details["Name"] = lines[0];
//     }

//     // Extract Email
//     RegExp emailRegex = RegExp(r"[\w\.-]+@[\w\.-]+\.\w+");
//     var emailMatch = emailRegex.firstMatch(text);
//     details["Email"] = emailMatch?.group(0) ?? "Not Found";

//     // Extract Phone Number (10-digit numbers)
//     RegExp phoneRegex = RegExp(r"\b\d{10,}\b");
//     var phoneMatch = phoneRegex.firstMatch(text);
//     details["Phone"] = phoneMatch?.group(0) ?? "Not Found";

//     // Extract Address (Simple Heuristic)
//     RegExp addressRegex =
//         RegExp(r"(\d{1,5}\s\w+\s(?:Street|Road|Ave|City|Lane|Plaza).*)");
//     var addressMatch = addressRegex.firstMatch(text);
//     details["Address"] = addressMatch?.group(0) ?? "Not Found";

//     return details;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Map<String, String> details = extractDetails(scannedText);

//     return Scaffold(
//       appBar: AppBar(title: const Text('ID Scanner')),
//       body: Column(
//         children: [
//           _image != null
//               ? Image.file(_image!, height: 200)
//               : const Icon(Icons.image, size: 200, color: Colors.grey),
//           const SizedBox(height: 20),
//           Text("Scanned Details:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           details.isNotEmpty
//               ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: details.entries
//                         .map((e) => Text("${e.key}: ${e.value}",
//                             style: TextStyle(fontSize: 16)))
//                         .toList(),
//                   ),
//                 )
//               : const Text("No details extracted."),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () => pickImage(ImageSource.camera),
//                 icon: const Icon(Icons.camera),
//                 label: const Text("Scan ID"),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () => pickImage(ImageSource.gallery),
//                 icon: const Icon(Icons.image),
//                 label: const Text("Upload ID"),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
