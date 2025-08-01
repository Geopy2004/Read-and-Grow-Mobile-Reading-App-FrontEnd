import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

class Activity1Page extends StatefulWidget {
  const Activity1Page({super.key});

  @override
  _Activity1PageState createState() => _Activity1PageState();
}

class _Activity1PageState extends State<Activity1Page> {
  int _currentPage = 0;

  // List of pages for the activity
  final List<Widget> _pages = [
    const AgFamilyPage(),
    const MatchPicturesPage(),
    const MatchWordsToPicturesPage(),
    const FillInTheBlanksPage(),
    const ReadingPage(), // Add the fifth page
  ];

  // Function to navigate to the previous page
  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  // Function to navigate to the next page
  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the current page
            Expanded(child: _pages[_currentPage]),
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 0 ? _goToPreviousPage : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios_new_sharp, size: 50),
                  ),
                ),
                Text(
                  "Page ${_currentPage + 1} of ${_pages.length}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ElevatedButton(
                  onPressed:
                      _currentPage < _pages.length - 1 ? _goToNextPage : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward_ios_sharp, size: 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for the "Ag Family" page
class AgFamilyPage extends StatefulWidget {
  const AgFamilyPage({super.key});

  @override
  _AgFamilyPageState createState() => _AgFamilyPageState();
}

class _AgFamilyPageState extends State<AgFamilyPage> {
  final List<String> agFamilyWords = [
    'bag',
    'jag',
    'tag',
    'nag',
    'sag',
    'dag',
    'mag',
    'rag',
    'lag',
    'wag',
  ];

  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speakWords() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.3); // Adjust speech rate for kids
    await _flutterTts.speak(agFamilyWords.join(", "));
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display an image for the "Ag Family"
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image.asset(
                  "assets/activity_images/ag-family.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display a grid of words
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2.0,
                ),
                itemCount: agFamilyWords.length,
                itemBuilder: (context, index) {
                  return WordCard(word: agFamilyWords[index]);
                },
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 10,
          child: FloatingActionButton(
            onPressed: _speakWords,
            child: Icon(Icons.volume_up, size: 30),
          ),
        ),
      ],
    );
  }
}

// Widget for the "Match Pictures" page
class MatchPicturesPage extends StatelessWidget {
  const MatchPicturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> matchItems = [
      {"image": "assets/activity_images/tag.jpg", "word": "rag"},
      {"image": "assets/activity_images/bag.jpg", "word": "wag"},
      {"image": "assets/activity_images/wag.jpg", "word": "nag"},
      {"image": "assets/activity_images/rag.jpg", "word": "tag"},
      {"image": "assets/activity_images/nag.png", "word": "bag"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Instructions for the activity
        Text(
          "Match the pictures with the correct words.",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        // List of items to match
        Expanded(
          child: ListView.builder(
            itemCount: matchItems.length,
            itemBuilder: (context, index) {
              final item = matchItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ), // Add spacing between rows
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 80,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item["word"]!,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "© Live Work Sheets",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class MatchWordsToPicturesPage extends StatelessWidget {
  const MatchWordsToPicturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> matchItems = [
      {"word": "wag", "image": "assets/activity_images/bag.jpg"},
      {"word": "tag", "image": "assets/activity_images/wag.jpg"},
      {"word": "bag", "image": "assets/activity_images/rag.jpg"},
      {"word": "rag", "image": "assets/activity_images/tag.jpg"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "-ag Word Family: Match the word with the correct picture.",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: matchItems.length,
            itemBuilder: (context, index) {
              final item = matchItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: Card(color: Theme.of(context).colorScheme.primary,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item["word"]!,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold, color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "© Live Work Sheets",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class FillInTheBlanksPage extends StatelessWidget {
  const FillInTheBlanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> fillItems = [
      {"image": "assets/activity_images/bag.jpg", "word": "_ag"},
      {"image": "assets/activity_images/tag.jpg", "word": "_ag"},
      {"image": "assets/activity_images/wag.jpg", "word": "_ag"},
      {"image": "assets/activity_images/rag.jpg", "word": "_ag"},
    ];

    final List<String> options = ["r", "w", "t", "b"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fill in the blank with the correct letter.",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: fillItems.length,
            itemBuilder: (context, index) {
              final item = fillItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 45, // Set a fixed width for the TextField
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "ag",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Center(
          child: Text(
            "Options:",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Wrap(
            spacing: 10,
            children:
                options
                    .map(
                      (option) => Chip(
                        label: Text(
                          option,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      ),
                    )
                    .toList(),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "© Live Work Sheets",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final List<String> sentences = [
    "The bag is on the cab.",
    "Gab is on the cab.",
    "Gab's bag has a jam.",
    "Gab's bag has a jam and a cam.",
  ];

  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speakSentences() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.3); // Reduced speech rate for kids
    await _flutterTts.speak(sentences.join(" "));
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Read the sentences below:",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sentences.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      sentences[index],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 120,
          right: 20,
          child: Text(
            "Tap this sound button to hear \n the sentences.",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: FloatingActionButton(
            onPressed: _speakSentences,
            child: Icon(Icons.volume_up, size: 30),
          ),
        ),
      ],
    );
  }
}

// Widget for displaying a word card
class WordCard extends StatelessWidget {
  final String word;

  const WordCard({super.key, required this.word});

  // Function to get a random color for the card
  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
    ];
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: _getRandomColor(),
      child: Center(
        child: Text(
          word,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
