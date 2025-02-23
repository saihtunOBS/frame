import 'package:flutter/material.dart';
import 'package:quran_wireframe/screens/bookmark/camera_page.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InkWell(
     
      child: const Center(child:  SizedBox(child: Text('open camra'),))));
  }
}
