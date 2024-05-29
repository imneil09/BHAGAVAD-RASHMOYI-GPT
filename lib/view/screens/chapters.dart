import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/chapters.dart';

class Chapters extends StatelessWidget {
  final List<Chapter> chapterList = ChapterData.chapters;

  Chapters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: chapterList.length,
        itemBuilder: (context, index) {
          final chapter = chapterList[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => ChapterDetailsScreen(chapter: chapter));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.book,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    chapter.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'এই অধ্যায় সম্পর্কে আরো অন্বেষণ করুন !',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChapterDetailsScreen extends StatelessWidget {
  final Chapter chapter;

  const ChapterDetailsScreen({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(chapter.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to allow scrolling
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: chapter.verse.entries.map((entry) {
            return Card(
              margin: const EdgeInsets.all(10),
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'শ্লোক : ${entry.value} ',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'অনুবাদ : ${chapter.translation[entry.key] ?? 'অনুবাদ উপলব্ধ নয়, অজানা ত্রুটি ঘটেছে ৷'}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
