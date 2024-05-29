import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _sendFeedback(BuildContext context) async {
    final smtpServer = SmtpServer('smtp.ethereal.email',
        username: 'gayle97@ethereal.email',
        password: 'MfW4aEsKtXKXSh4WbC');

    final message = Message()
      ..from = Address(_emailController.text)
      ..recipients.add('contact.rrconsultancy@gmail.com')
      ..subject = 'ব্যবহারকারীর প্রতিক্রিয়া এবং পরামর্শ'
      ..text = '''
নাম: ${_nameController.text}
ইমেইল ঠিকানা: ${_emailController.text}
ফোন নম্বর: ${_phoneController.text}
স্থানীয় ঠিকানা: ${_addressController.text}
প্রতিক্রিয়া এবং পরামর্শ: ${_feedbackController.text}
''';

    try {
      final sendReport = await send(message, smtpServer);
      // ignore: avoid_print
      print('বার্তা সফলভাবে পাঠানো হয়েছে: ${sendReport.toString()}');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('প্রতিক্রিয়া এবং পরামর্শ সফলভাবে পাঠানো হয়েছে'),
            content: const Text('আপনার প্রতিক্রিয়া এবং পরামর্শর জন্য ধন্যবাদ!'),
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
        title: const Text('আপনার মতামত এবং পরামর্শ জানান ?'),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
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
                  controller: _nameController,
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'স্থানীয় ঠিকানা',
                    labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _feedbackController,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'আপনার মতামত এবং আপনার পরামর্শ',
                    labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _sendFeedback(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'মতামত এবং পরামর্শ পাঠান',
                      style: TextStyle(fontSize: 20),
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
