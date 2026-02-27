import 'package:document_frame_scanner/document_frame_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DocumentScanner extends StatefulWidget {
  const DocumentScanner({super.key});

  @override
  State<DocumentScanner> createState() => _DocumentScannerState();
}

class _DocumentScannerState extends State<DocumentScanner> {
  var image;

  void scanImage(String imagePath) async {
    setState(() {
        image = imagePath;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DocumentScannerScreen(setImage: scanImage,)),
            ),
            child: const Text('Start Document Capture'),
          )
        ),
        SizedBox(height: 10,),
        Container(
          height: 500,
          width: 250,
          child: image == null ? const Text("No image taken yet") : Image.file(File(image))
        )
      ],
    );
  }
}

class DocumentScannerScreen extends StatelessWidget {
  const DocumentScannerScreen({super.key, required this.setImage});

  final Function(String) setImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DocumentFrameScanner(
        frameWidth: 300.0,
        frameHeight: 400.0,
        title: const Text(
          'Capture Your Document',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        showCloseButton: true,
        onCaptured: (imgPath) => debugPrint('Captured image path: $imgPath'),
        onSaved: (imgPath) => {
          debugPrint('Saved image path: $imgPath'),
          setImage(imgPath),
          Navigator.pop(context),
        },
      ),
    );
  }
}