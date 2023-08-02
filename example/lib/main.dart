import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:widget_to_image/widget_to_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool firstColor = false;
  GlobalKey key = GlobalKey();
  bool hasConverted = false;
  Image? image;
  Future<Image>? imageFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getWidgetAsImage(key);
    }

    final widgetOriginal = Expanded(
      child: Column(
        children: [
          Text('Widget'),
          RepaintBoundary(
            key: key,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: firstColor ? Colors.red : Colors.green,
              ),
              onPressed: () async {
                final image2 = await WidgetToImage.asDartUiImage(key);
                final byte = await WidgetToImage.asByteData(key);
                final uint = await WidgetToImage.asUint8List(key);
                final inasd = await WidgetToImage.asImage(key);

                print(image2);
                print(byte is ByteData);
                print(uint is Uint8List);
                print(inasd is Image);

                setState(() {
                  firstColor = !firstColor;
                });
              },
              child: Container(
                color: firstColor ? Colors.red : Colors.green,
                child: Text('Click to change color'),
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            widgetOriginal,
            Expanded(
              child: Column(
                children: [
                  Text('Image'),
                  hasConverted
                      ? Container(
                          height: 35,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image!.image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getWidgetAsImage(GlobalKey key) async {
    image = await WidgetToImage.asImage(key);

    setState(() {
      hasConverted = true;
    });

    setState(() {});
  }
}
