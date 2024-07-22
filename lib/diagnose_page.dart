import 'package:careai/qna_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
const apiKey = "AIzaSyBatUW7pEBpkEEa5Kqgw5GZUgzg0s01lcU";

class DiagnoseWithVoicePage extends StatefulWidget {
  const DiagnoseWithVoicePage({super.key});

  @override
  State<DiagnoseWithVoicePage> createState() => _DiagnoseWithVoicePageState();
}

class _DiagnoseWithVoicePageState extends State<DiagnoseWithVoicePage> {
  final feel = TextEditingController();
  final incident = TextEditingController();
  final lang = TextEditingController();
  final geminiModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnose with voice"),
      ),
      body: Column(
        children: [
          ..._qnaBox(
              "What do you feel right now?", "ex: headache, anxiety", feel),
          ..._qnaBox(
              "Did you do something that may lead the condition lately?",
              "ex: I slept late last night, I smoke frequently in this 3 days",
              incident),
          ..._qnaBox("Choose language", "ex: Bahasa Indonesia", lang),
          ElevatedButton(
            onPressed: () async {
              _getResult();
            },
            child: Text("Mulai sesi"),
          ),
        ],
      ),
    );
  }

  List<Widget> _qnaBox(
    String q,
    String hint,
    TextEditingController controller,
  ) {
    return [
      Text(
        q,
        style: TextStyle(color: Colors.grey),
      ),
      TextField(
        controller: controller,
        minLines: null,
        decoration: InputDecoration(hintText: hint),
      )
    ];
  }

  Future _getResult() async {
    print("${feel.text}, ${incident.text}, ${lang.text}");
    final prompt =
        '''saya memiliki keluhan ${feel.text}, yang terjadi baru baru ini adalah saya
         ${incident.text}, buat 5 pertanyaan diagnosa dengan format 5 baris, karena ini akan 
         saya masukkan ke program maka jangan ditambah catatan apapun,
         dengan bahasa ${lang.text}''';
    final response = await geminiModel.generateContent([Content.text(prompt)]);
    setState(() {
      final qs = response.text!;
      int startIndex = qs.indexOf(RegExp(r'1\.\s'));

      if (startIndex != -1) {
        // Extract the substring starting from the first question
        String questionsPart = qs.substring(startIndex);

        // Split the questions part into a list
        List<String> questions = questionsPart.split(RegExp(r'\n(?=\d+\.\s)'));
        Get.to(QnAPage(questions));
      } else {
        print('No questions found in the text.');
      }
    });
  }
}
