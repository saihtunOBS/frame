// import 'package:flutter/material.dart';
// import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   bool isParsed = false;
//   MRZController? controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera'),
//       ),
//       body: MRZScanner(
//         withOverlay: true,
//         onControllerCreated: onControllerCreated,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.stopPreview();
//     super.dispose();
//   }

//   void onControllerCreated(MRZController controller) {
//     this.controller = controller;
//     controller.onParsed = (result) async {
//       if (isParsed) return;
//       isParsed = true;

//       if (mounted) {
//         setState(() {
//           showDialog<void>(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text("Scan Result"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Document Type: ${result.documentType}'),
//                   Text('Given Names: ${result.givenNames}'),
//                   Text('Document Number: ${result.documentNumber}'),
//                   ElevatedButton(
//                     child: const Text('OK'),
//                     onPressed: () {
//                       isParsed = false;
//                       Navigator.pop(context, true);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       }
//     };
//     controller.onError = (error) => print(error);

//     controller.startPreview();
//   }
// }
