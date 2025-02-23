// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

// class RecognizePage extends StatefulWidget {
//   final String? path;
//   const RecognizePage({Key? key, this.path}) : super(key: key);

//   @override
//   State<RecognizePage> createState() => _RecognizePageState();
// }

// class _RecognizePageState extends State<RecognizePage> {
//   bool _isBusy = false;
//   TextEditingController controller = TextEditingController();

//   String name = '';
//   final nameFieldController = TextEditingController();

//   String function = '';
//   final functionFieldController = TextEditingController();

//   TextEditingController societeFieldController = TextEditingController();
//   TextEditingController adresse1FieldController = TextEditingController();
//   TextEditingController adresse2FieldController = TextEditingController();

//   String number = '';
//   final numeroFieldController = TextEditingController();

//   final emailFieldController = TextEditingController();

//   String website = '';
//   final websiteFieldController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     processImage(widget.path!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Recognized Page")),
//       body: _isBusy
//           ? const Center(child: CircularProgressIndicator())
//           : Container(
//               padding: const EdgeInsets.all(20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Nom et prénom'),
//                     TextFormField(
//                       onChanged: (value) {
//                         name = value;
//                       },
//                       controller: nameFieldController,
//                       style: const TextStyle(fontSize: 20,color: Colors.black),
//                     ),
//                     const Text('Fonction'),
//                     TextFormField(
//                       onChanged: (value) {
//                         function = value;
//                       },
//                       controller: functionFieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Société'),
//                     TextFormField(
//                       onChanged: (value) {},
//                       controller: societeFieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Adresse 1'),
//                     TextFormField(
//                       onChanged: (value) {},
//                       controller: adresse1FieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Adresse 2'),
//                     TextFormField(
//                       onChanged: (value) {},
//                       controller: adresse2FieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Numéro'),
//                     TextFormField(
//                       onChanged: (value) {
//                         number = value;
//                       },
//                       controller: numeroFieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Email'),
//                     TextFormField(
//                       onChanged: (value) {},
//                       controller: emailFieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const Text('Site Web'),
//                     TextFormField(
//                       onChanged: (value) {
//                         website = value;
//                       },
//                       controller: websiteFieldController,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         saveForm();
//                       },
//                       child: const Text('Save'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   void processImage(String imagePath) async {

//     setState(() {
//       _isBusy = true;
//     });

//     try {
//       final text = await FlutterTesseractOcr.extractText(imagePath);
//       setState(() {
//         controller.text = text;
//         extractInformation(text);
//         print(text);
//       });
//     } catch (e) {
//       log(e.toString());
//     }

//     setState(() {
//       _isBusy = false;
//     });
//   }

//   void extractInformation(String text) {
//     final name = extractName(text);
//     final function = extractFunction(text, name);
//     final societe = extractSociete(text);
//     final adresse1 = extractAdresse1(text);
//     final adresse2 = extractAdresse2(text);
//     final numero = extractNumero(text);
//     final email = extractEmail(text);
//     final website = extractWebsite(text);

//     nameFieldController.text = name;
//     functionFieldController.text = function;
//     societeFieldController.text = societe;
//     adresse1FieldController.text = adresse1;
//     adresse2FieldController.text = adresse2;
//     numeroFieldController.text = numero;
//     emailFieldController.text = email;
//     websiteFieldController.text = website;
//   }

//   String extractName(String text) {
//     final namePattern = RegExp(r'[A-Za-z]+\s[A-Za-z]+');
//     final match = namePattern.firstMatch(text);
//     if (match != null) {
//       return match.group(0)!;
//     }
//     return '';
//   }

//   String extractFunction(String text, String name) {
//     final lines = text.split('\n');

//     final nameLineIndex = lines.indexWhere((line) => line.contains(name));
//     if (nameLineIndex != -1 && nameLineIndex < lines.length - 1) {
//       final functionLineIndex = nameLineIndex + 1;
//       final functionLine = lines[functionLineIndex].trim();
//       final commonWords = ['and', 'the', 'of', 'in', 'at', 'on'];
//       final functionWords = functionLine.split(' ');
//       final filteredWords = functionWords
//           .where((word) => !commonWords.contains(word.toLowerCase()));

//       final jobTitle = filteredWords.join(' ');

//       return jobTitle.trim();
//     }

//     return '';
//   }

//   String extractSociete(String text) {
//     return 'Company name';
//   }

//   String extractAdresse1(String text) {
//     return 'adress';
//   }

//   String extractAdresse2(String text) {
//     return 'adress';
//   }

//   String extractNumero(String text) {
//     final phoneNumberPattern =
//         RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");

//     final match = phoneNumberPattern.firstMatch(text);
//     if (match != null) {
//       return match.group(0)!;
//     }

//     return '';
//   }

//   String extractEmail(String text) {
//     return 'Email';
//   }

//   String extractWebsite(String text) {
//     final websitePattern = RegExp(
//         r"^(http:)|(https:)|(www){1,256}\.[a-zA-Z0-9]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&//=]*)$");
//     final match = websitePattern.firstMatch(text);
//     if (match != null) {
//       return match.group(0)!;
//     }
//     return '';
//   }

//   void saveForm() {
//     final name = nameFieldController.text;
//     final function = functionFieldController.text;
//     final societe = societeFieldController.text;
//     final adresse1 = adresse1FieldController.text;
//     final adresse2 = adresse2FieldController.text;
//     final numero = numeroFieldController.text;
//     final email = emailFieldController.text;
//     final website = websiteFieldController.text;

//     print('Name: $name');
//     print('Function: $function');
//     print('Societe: $societe');
//     print('Adresse 1: $adresse1');
//     print('Adresse 2: $adresse2');
//     print('Numéro: $numero');
//     print('Email: $email');
//     print('Website: $website');
//   }
// }
