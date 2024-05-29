import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  void _sendFeedback() async {
    final smtpServer = SmtpServer('smtp.ethereal.email',
        username: 'gayle97@ethereal.email',
        password: 'MfW4aEsKtXKXSh4WbC');

    final message = Message()
      ..from = Address(emailController.text)
      ..recipients.add('contact.rrconsultancy@gmail.com')
      ..subject = 'ব্যবহারকারীর দ্বারা যোগাযোগের অনুরোধ'
      ..text =
          'নাম: ${nameController.text}\nইমেইল ঠিকানা: ${emailController.text}\nফোন নম্বর: ${phoneController.text}\nকথোপকথনের বিষয়: ${feedbackController.text}';

    try {
      final sendReport = await send(message, smtpServer);
      // ignore: avoid_print
      print('বার্তা সফলভাবে পাঠানো হয়েছে: ${sendReport.toString()}');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('অনুরোধ সফলভাবে পাঠানো হয়েছে'),
            content: const Text('আপনার অনুরোধ জন্য ধন্যবাদ!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ঠিক আছে'),
              ),
            ],
          );
        },
      );
    } on MailerException catch (e) {
      // ignore: avoid_print
      print('এই ইমেলটি পাঠানোর সময় ত্রুটি ঘটেছে৷: $e');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('যোগাযোগে ত্রুটি ঘটেছে'),
            content: const Text('অনুরোধ পাঠানোর সময় ত্রুটি ঘটেছে,আবার চেষ্টা করুন!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ঠিক আছে'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('প্রতিক্রিয়ার জন্য যোগাযোগ করুন'),
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
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'সম্পূর্ণ নাম লিখুন',
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
                  controller: emailController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'বৈধ ইমেল ঠিকানা',
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
                  controller: phoneController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'বৈধ ফোন নম্বর',
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
                  controller: feedbackController,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'আপনার কথোপকথনের বিষয়',
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
                  child: ElevatedButton(
                    onPressed: _sendFeedback,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'কল ব্যাক করার জন্য অনুরোধ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
