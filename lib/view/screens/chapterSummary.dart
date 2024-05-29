// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/summary.dart';

class ChapterSummary extends StatelessWidget {
  final List<String> chapterList = [
    '১. বিষাদ যোগ',
    '২. সাংখ্য যোগ',
    '৩. কর্ম যোগ',
    '৪. জ্ঞান যোগ',
    '৫. কর্মসন্ন্যাস যোগ',
    '৬. ধ্যান যোগ',
    '৭. বিজ্ঞান যোগ',
    '৮. অক্ষরব্রহ্ম যোগ',
    '৯. রাজগূহ্য যোগ',
    '১০. বিভূতি যোগ',
    '১১. বিশ্বরূপ দর্শন যোগ',
    '১২. ভক্তি যোগ',
    '১৩. প্রকৃতি পুরুষ বিবেক যোগ',
    '১৪. গুণত্রয় বিভাগ যোগ',
    '১৫. পুরুষোত্তম যোগ',
    '১৬. দৈবসুর সম্পদ বিভাগ যোগ',
    '১৭. শ্রদ্ধত্রয় বিভাগ যোগ',
    '১৮. মোক্ষ যোগ',
  ];

  ChapterSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chapterList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final chapter = chapterList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ChapterDetailsScreen(chapter: chapter));
                },
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.book,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          chapter,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChapterDetailsScreen extends StatelessWidget {
  final String chapter;

  const ChapterDetailsScreen({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> summary = Summary.summary;
    final Map<String, String> usecase = Summary.usecase;

    return Scaffold(
      appBar: AppBar(
        title: Text(chapter),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'সারসংক্ষেপ :',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      summary[chapter] ??
                          'সারাংশ উপলব্ধ নয়, একটি অজানা ত্রুটি ঘটেছে ৷',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'ব্যবহার ক্ষেত্র : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      usecase[chapter] ??
                          'ব্যবহার ক্ষেত্র উপলব্ধ নয়, একটি অজানা ত্রুটি ঘটেছে ৷',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
