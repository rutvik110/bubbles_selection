import 'package:bubbles_selection/bubbles_selection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const BubbleSelectionUi(),
    );
  }
}

class BubbleSelectionUi extends StatefulWidget {
  const BubbleSelectionUi({Key? key}) : super(key: key);

  @override
  State<BubbleSelectionUi> createState() => _BubbleSelectionUiState();
}

class _BubbleSelectionUiState extends State<BubbleSelectionUi> {
  late List<Bubble> selectedBubbles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedBubbles = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(
            "Bubble Selection",
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          const Spacer(),
          //  DropdownButton(items: const [], onChanged: onChanged)
          BubbleSelection(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            bubbles: [
              Bubble(
                  text: "Gaming🎮",
                  activeColor: Colors.red.withOpacity(0.5),
                  inactiveColor: Colors.blue.withOpacity(0.5),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.yellow,
                  )),
              Bubble(
                text: "Food🍔",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 237, 141, 17).withOpacity(0.5),
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Bubble(
                text: "Health &\n Fitness🏃",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 16, 233, 186).withOpacity(
                  0.5,
                ),
                scale: 0.8,
              ),
              Bubble(
                text: "Worklife🌏",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 89, 37, 245).withOpacity(0.5),
                textStyle: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Bubble(
                text: "Fun🎉",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 176, 34, 224).withOpacity(0.5),
              ),
              Bubble(
                text: "Comedy😂",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 89, 37, 245).withOpacity(0.5),
              ),
              Bubble(
                text: "Focus🎯",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 176, 34, 224).withOpacity(0.5),
              ),
              Bubble(
                text: "Music🎶",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 89, 37, 245).withOpacity(0.5),
                textStyle: const TextStyle(
                  fontSize: 28,
                ),
              ),
              Bubble(
                text: "Travel🚗",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 176, 34, 224).withOpacity(0.5),
              ),
              Bubble(
                text: "Sports🏀",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 89, 37, 245).withOpacity(0.5),
                textStyle: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Bubble(
                text: "News📰",
                activeColor: Colors.red.withOpacity(0.5),
                inactiveColor:
                    const Color.fromARGB(255, 176, 34, 224).withOpacity(0.5),
              ),
            ],
            selectedBubbles: selectedBubbles,
            size: const Size(
              900,
              300,
            ),
            onSelect: (bubble) {
              setState(() {
                selectedBubbles.add(bubble);
              });
            },
            onRemoved: (bubble) {
              setState(() {
                selectedBubbles.remove(bubble);
              });
            },
          ),
          const Spacer(),
          Wrap(
            children: selectedBubbles
                .map<Widget>(
                  (bubble) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text(
                        bubble.text,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
