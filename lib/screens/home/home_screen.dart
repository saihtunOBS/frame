import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool isMinimized = false;
  bool isMiniPlayerVisible = false; // Initially hidden

  @override
  void initState() {
    _initializePlayer();
    super.initState();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(
            'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'),
      );

      await _videoPlayerController.initialize();

      if (!mounted) return;

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: false,
          looping: false,
        );
      });
    } catch (e) {
      print("Error initializing video: $e");
    }
  }


  void _playVideo(String videoUrl) async {
  // Dispose of the old controller before creating a new one
  _videoPlayerController.dispose();
  _chewieController?.dispose();

  _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

  await _videoPlayerController.initialize();

  if (!mounted) return;

  setState(() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      allowFullScreen: true, // Ensure full-screen mode is enabled
    );
    isMinimized = false;
    isMiniPlayerVisible = true; // Show full-screen player
  });
}

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DraggableBottomSheet(
        
        minExtent: 80, // Hide mini-player initially
        useSafeArea: false,
        curve: Curves.easeInOut,
        previewWidget:  miniPlayer()
           , // Show mini-player only if visible
        expandedWidget: fullPlayer(), // Full player when expanded
        backgroundWidget: videoList(), // Background content (list of videos)
        maxExtent: MediaQuery.of(context).size.height * 0.8, // Maximum height
        onDragging: (double extent) {
          setState(() {
            isMinimized = extent <= 150;
            isMiniPlayerVisible =
                isMinimized; // Show mini-player only after swipe
          });
        },
      ),
    );
  }

  /// 🟢 Full-Screen Player
  Widget fullPlayer() {
    return Container(
      color: Colors.black,
      child: Center(
        child: _videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const CircularProgressIndicator(),
      ),
    );
  }

  /// 🔵 Mini Player (Appears only after swipe down)
  Widget miniPlayer() {
    return GestureDetector(
      onTap: () => setState(() {
        isMinimized = false;
        isMiniPlayerVisible = false; // Hide mini-player when tapped
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 80,
        color: Colors.black,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _videoPlayerController.value.isInitialized
                  ? VideoPlayer(_videoPlayerController)
                  : const CircularProgressIndicator(),
            ),
            const SizedBox(width: 10),
            const Text("Playing Video...",
                style: TextStyle(color: Colors.white)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => setState(() {
                isMinimized = false;
                isMiniPlayerVisible = false; // Hide mini-player when closed
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 🎥 Background Video List
  Widget videoList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.video_library, color: Colors.white),
          title:
              Text("Video $index", style: const TextStyle(color: Colors.white)),
          onTap: () {
            _playVideo(
                'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4');
          },
        );
      },
    );
  }
}
