import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আমাদের সম্পর্কে ?'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/ai.png'),
                    radius: 60,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'এই অ্যাপটির বিকাশকারী :',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  '@ALPHABET BY নীল ভৌমিক (সোশ্যাল মিডিয়া হিসেবে)',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
                const SizedBox(height: 20),
                const Text(
                  'পেশা :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'ডেভেলপার @FLUTTER(BY GOOGLE)',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
                const SizedBox(height: 20),
                const Text(
                  'আমাদের উদ্দেশ্য :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'আমরা একটি গীতা অ্যাপ ডেভেলপ করেছি যা মানবতার উন্নতি ও ধার্মিক মৌলিকতার সম্পর্কে জানাতে সাহায্য করতে ডিজাইন করা হয়েছে। আমরা শ্রীমদ ভগবদ্ গীতার অধ্যয়ন এবং বোঝার জন্য একটি সহযোগিতার উদ্দেশ্যে এই অ্যাপ্লিকেশনটি তৈরি করেছি।',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
                const SizedBox(height: 20),
                const Text(
                  'আমাদের ভিশন :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'আমরা এই অ্যাপটির মাধ্যমে গীতা শাস্ত্রের শেখা ও সম্মাননা প্রসার করতে চাই। আমরা মানবিক উন্নতি ও ধার্মিক সংজ্ঞানের প্রতি জনগণের সহায়ক হতে চাই।',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
