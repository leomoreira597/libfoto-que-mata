import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../flutter_scalable_ocr.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Future<void> verifyText(dynamic value) async{
    final text = value as String;
    final List<String> TextList = [text.replaceAll(" ", "")];
    final String textFinal =  TextList[0];
    if(textFinal == null || textFinal.isEmpty){
      throw Error();
    }
    else{
      print("olha aqui $textFinal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ScalableOCR(
                paintboxCustom: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4.0
                  ..color = const Color.fromARGB(153, 102, 160, 241),
                boxLeftOff: 5,
                boxBottomOff: 2.5,
                boxRightOff: 5,
                boxTopOff: 2.5,
                boxHeight: MediaQuery.of(context).size.height / 3,
                getRawData: (value) {
                  inspect(value);
                },
                getScannedText: (value) {
                  verifyText(value);
                }),
            StreamBuilder<String>(
              stream: controller.stream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Result(text: snapshot.data != null ? snapshot.data! : "");
              },
            )
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("Readed text: $text");
  }
}

