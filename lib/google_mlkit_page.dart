import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class GoogleMLKit extends StatefulWidget {
  const GoogleMLKit({super.key});

  @override
  State<GoogleMLKit> createState() => _GoogleMLKitState();
}

class _GoogleMLKitState extends State<GoogleMLKit> {
  var image;

  DocumentScannerOptions options = DocumentScannerOptions(
    mode: ScannerMode.filter, // to control the feature sets in the flow
    isGalleryImport: false, // importing from the photo gallery
    pageLimit: 1, // setting a limit to the number of pages scanned
  );

  void scanImage() async {
    DocumentScanner documentScanner = DocumentScanner(
      options: options
    );
    var images = await documentScanner.scanDocument();
    if (images.images.isNotEmpty) {
      setState(() {
        image = images.images[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ElevatedButton(onPressed: () => scanImage(), child: const Text("Click here to scan document")),
          SizedBox(height: 10,),
          Container(
            height: 500,
            width: 250,
            child: image == null ? const Text("No image taken yet") : Image.file(File(image))
          )
        ],
      ),
    );
  }
}