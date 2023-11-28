import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var DDTextStyle = 'Open Sans';
  var DDTextSize = 14;

  TextEditingController _textEditingController = TextEditingController();

  LindiController controller = LindiController(
    showFlip: false,
    showLock: false,
    showStack: false,
    shouldScale: false,
    shouldRotate: true,
  );
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Celebrare',
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LindiStickerWidget(
                controller: controller,
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.7,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter your Text',
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: 'Open Sans'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                  controller: _textEditingController,
                  style: TextStyle(
                      fontSize: DDTextSize.toDouble(), fontFamily: DDTextStyle),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Font Size'),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (DDTextSize > 0) {
                                  setState(() {
                                    DDTextSize -= 1;
                                  });
                                }
                              },
                              icon: Icon(CupertinoIcons.minus)),
                          Text('${DDTextSize}'),
                          IconButton(
                              onPressed: () {
                                if (DDTextSize < 100) {
                                  setState(() {
                                    DDTextSize += 1;
                                  });
                                }
                              },
                              icon: Icon(Icons.add))
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Font Style'),
                      DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'Caveat',
                              child: Text('Caveat'),
                            ),
                            DropdownMenuItem(
                              value: 'Dancing Script',
                              child: Text('Dancing Script'),
                            ),
                            DropdownMenuItem(
                              value: 'Nova Square',
                              child: Text('Nova Square'),
                            ),
                            DropdownMenuItem(
                              value: "Open Sans",
                              child: Text('Open Sans'),
                            ),
                          ],
                          value: DDTextStyle,
                          onChanged: (newvalue) {
                            setState(() {
                              DDTextStyle = newvalue!;
                            });
                          })
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    var EnteredText = _textEditingController.text.trim();
                    if (EnteredText.isNotEmpty) {
                      controller.addWidget(Text(
                        EnteredText,
                        style: TextStyle(
                            fontFamily: DDTextStyle,
                            fontSize: DDTextSize.toDouble()),
                      ));
                      _textEditingController.clear();
                    }
                  },
                  child: Text('Add Text')),
            ],
          ),
        ),
      ),
    );
  }
}
