import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

const apiKey = "AIzaSyBatUW7pEBpkEEa5Kqgw5GZUgzg0s01lcU";

class ImageAnalyzerPage extends StatefulWidget {
  const ImageAnalyzerPage({super.key});

  @override
  State<ImageAnalyzerPage> createState() => _ImageAnalyzerPageState();
}

class _ImageAnalyzerPageState extends State<ImageAnalyzerPage> {
  File? _selectedImage;
  String analyzationResult = "";
  final geminiModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ]);

  final prompt =
      TextPart("Tolong analisa gambar ini, dan beri solusi dari penanganannya, jangan dengan format bulletpoin, hanya dalam paragraf yang padat dan jelas");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Analyzer"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _pickImageOnGallery,
                child: Text("Pick image from gallery")),
            ElevatedButton(
                onPressed: _pickImageOnCamera,
                child: Text("Pick image from camera")),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Container(
                    margin: EdgeInsets.fromLTRB(30,5,30,5 ),
                    constraints: BoxConstraints(maxHeight: 400),
                    decoration: BoxDecoration(
                        border: Border.all(width: 10, color: Colors.brown)),
                    child: Image.file(_selectedImage!))
                : Text("Please select an image"),
            ElevatedButton(onPressed: _handleAnalyze, child: Text("Analisa!")),
            Text(analyzationResult),
          ],
        ),
      ),
    );
  }

  Future _pickImageOnGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageOnCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _handleAnalyze() async {
    if (_selectedImage == null) return;
    final image = await _selectedImage!.readAsBytes();
    final imagePart = DataPart("image/jpeg", image);

    final response = await geminiModel.generateContent([
      Content.multi([prompt, imagePart])
    ]);
    setState(() {
      analyzationResult = response.text!;
    });
  }
}
