import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class QnAPage extends StatefulWidget {
  final List<String> questions;
  const QnAPage(this.questions, {super.key});

  @override
  State<QnAPage> createState() => _QnAPageState();
}

class _QnAPageState extends State<QnAPage> {
  final items = [
    "Question 1",
    "Question 2",
    "Question 3",
    "Question 4",
    "Question 5"
  ];
  int current = 0;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordSpoken = "";

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    print(result);
    setState(() {
      _wordSpoken = result.recognizeWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.questions;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5),
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              current == index ? Colors.blue : Colors.white54),
                      child: Text(items[index]),
                    ),
                  );
                },
              ),
            ),
            Text(
              questions[current],
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? "listening..."
                    : _speechEnabled
                        ? "Tap the microphone to start recording..."
                        : "Scpeech isn't available",
              ),
            ),
            Expanded(
              child: Container(
                child: Text(_wordSpoken),
              ),
            ),
            ElevatedButton(
              onPressed:
                  _speechToText.isListening ? _stopListening : _startListening,
              child: Icon(Icons.mic),
            )
          ],
        ),
      ),
    );
  }

  static dynamic electric() {
    return "it's work huh?";
  }
}
