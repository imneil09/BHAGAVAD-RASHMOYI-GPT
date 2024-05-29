// ignore: file_names
import 'package:flutter/material.dart';
import '../constants/chapters.dart'; // Import your chapter data

class SearchVerse extends StatefulWidget {
  const SearchVerse({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchVerseState createState() => _SearchVerseState();
}

class _SearchVerseState extends State<SearchVerse> {
  String chapterTitle = '';
  String verseNumber = '';
  String searchedVerse = '';
  String searchedTranslation = '';

  void performSearch() {
    if (chapterTitle.isNotEmpty && verseNumber.isNotEmpty) {
      Map<String, String>? chapterVerseMap;
      Map<String, String>? chapterTranslationMap;

      // Fetch chapter verse and translation maps from ChapterData using chapterTitle
      for (Chapter chapter in ChapterData.chapters) {
        if (chapter.title == chapterTitle) {
          chapterVerseMap = chapter.verse;
          chapterTranslationMap = chapter.translation;
          break;
        }
      }

      if (chapterVerseMap != null && chapterTranslationMap != null) {
        String verse = chapterVerseMap[verseNumber] ?? 'বাক্য পাওয়া যায়নি';
        String translation = chapterTranslationMap[verseNumber] ?? 'অনুবাদ পাওয়া যায়নি';
        setState(() {
          searchedVerse = verse;
          searchedTranslation = translation;
        });
      } else {
        setState(() {
          searchedVerse = 'অধ্যায় পাওয়া যায়নি';
          searchedTranslation = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Card(
            color: Colors.blueGrey,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        chapterTitle = value;
                      });
                    },
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'অধ্যায়ের শিরোনাম',
                      labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        verseNumber = value;
                      });
                    },
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'বাক্য সংখ্যা',
                      labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        performSearch();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), backgroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                        color: Colors.deepOrange,
                      ),
                      label: const Text(
                        'অনুসন্ধান করুন',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  searchedVerse.isNotEmpty
                      ? Card(
                    color: Colors.grey[800], // Change color as desired
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'অনুসন্ধান ফলাফল :',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            searchedVerse,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            searchedTranslation,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
