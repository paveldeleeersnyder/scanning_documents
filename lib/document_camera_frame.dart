import 'dart:io';
import 'package:flutter/material.dart';
import 'package:document_camera_frame/document_camera_frame.dart';

class DocumentCamera extends StatefulWidget {
  const DocumentCamera({super.key});

  @override
  State<DocumentCamera> createState() => _DocumentCameraState();
}

class _DocumentCameraState extends State<DocumentCamera> {
  var image;

  void scanImage(path) async {
    setState(() {
      image = path;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ScanningFrame(setImage: scanImage)),
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

class ScanningFrame extends StatelessWidget {
  const ScanningFrame({super.key, required this.setImage});

  final Function(String) setImage;

  @override
  Widget build(BuildContext context) {
    return DocumentCameraFrame(
      frameWidth: 300,
      frameHeight: 450,
      titleStyle: DocumentCameraTitleStyle(
        title: Text('Scan Passport', style: TextStyle(color: Colors.white)),
      ),
      requireBothSides: false,
      sideIndicatorStyle: DocumentCameraSideIndicatorStyle(
        showSideIndicator: false,
      ),
      enableAutoCapture: false,
      instructionStyle: DocumentCameraInstructionStyle(
        frontSideInstruction: "Position passport within the frame",
      ),
      onDocumentSaved: (data) => setImage(data.frontImagePath!),
    );
  }
}