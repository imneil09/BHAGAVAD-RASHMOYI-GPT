import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'base.dart';

// ignore: use_key_in_widget_constructors
class Authentication extends StatelessWidget {
  final TextEditingController _accessCodeController = TextEditingController();
  final RxBool _isAuthenticated = false.obs;

  final box = GetStorage();

  // ignore: non_constant_identifier_names
  Gita() {
    // Initialize GetStorage once
    GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.deepOrange,
                  child:Image.asset(
                    'assets/images/Srimad_Bhagabad_Gita.png', // Adjust the path as necessary
                    width: 130.0,
                    height: 130.0,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'অ্যাক্সেস পেতে পাসকোড লিখুন।',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _accessCodeController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'এখানে অ্যাক্সেস কোড লিখুন',
                        hintText: 'অ্যাক্সেস কোডঃ Radhe Radhe',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'প্রমাণিত করুন',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() {
                  if (_isAuthenticated.value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Navigating to HomePage upon successful authentication
                      final sessionKey = DateTime.now().microsecondsSinceEpoch.toString();
                      box.write('sessionKey', sessionKey);
                      Get.off(Base(sessionKey: sessionKey));
                    });
                    return const Text(
                      'অ্যাক্সেস দেওয়া হয়েছে!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:Colors.deepOrange,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 40),  // Adding a larger gap for separation

                // Enhanced styling for the new section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'ভগবদ গীতা পঠনের গুরুত্ব :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'ভগবদ গীতা একটি উত্তম ধর্মীয় গ্রন্থ যা মানব জীবনের উদ্দেশ্য এবং দার্শনিক প্রতিষ্ঠানের ব্যাপারে আলোকিত করে। এটি জীবনের প্রতিটি দিক সম্মানিত করে এবং সঠিক মার্গে এগিয়ে এগিয়ে আগাতে সাহায্য করে।',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate() {
    final accessCode = _accessCodeController.text;
    if (accessCode == 'Radhe Radhe') {
      _isAuthenticated.value = true;
    } else {
      Get.dialog(
        AlertDialog(
          title: const Text('ভুল অ্যাক্সেস কোড'),
          content: const Text('দয়া করে আবার চেষ্টা করুন।'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('ঠিক আছে'),
            ),
          ],
        ),
      );
    }
  }
}
