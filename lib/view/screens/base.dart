import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../util/upi_payment.dart';
import 'about.dart';
import 'authentication.dart';
import 'chapterSummary.dart';
import 'chapters.dart';
import 'contact.dart';
import 'feedback.dart';
import 'rash_ai.dart';
import 'search_verse.dart';
import 'package:upi_india/upi_india.dart';

class Base extends StatefulWidget {
  final String sessionKey;

  const Base({super.key, required this.sessionKey});

  @override
  // ignore: library_private_types_in_public_api
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  final _bottomNavIndex = RxInt(0);
  final List<Widget> _bottomNavPages = [
    ChapterSummary(),
    Chapters(),
    const SearchVerse(),
    const RashAi(
      apiKey: "AIzaSyASay9wEMaHT6EdINp7uXctBP5JR5xcrJs",
    ),
  ];

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        // ignore: avoid_print
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        // ignore: avoid_print
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        // ignore: avoid_print
        print('Transaction Failed');
        break;
      default:
        // ignore: avoid_print
        print('Received an Unknown transaction status');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ভগবদ্ রাশময়ী GPT',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              GetStorage().remove('sessionKey');
              Get.offAll(() => Authentication());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                image: DecorationImage(
                  image: AssetImage('assets/images/gita_drawer_account.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.7,
                  child: Card(
                    elevation: 24,
                    color: Colors.deepOrange,
                    child: Center(
                      child: Text(
                        'ওং নমঃ ভগবতে বাসুদেবায়',
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group, color: Colors.deepOrange),
              title: Text('আমাদের সম্পর্কে জানুন',
                  style: TextStyle(fontSize: screenHeight * 0.018)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback, color: Colors.deepOrange),
              title: Text('আপনার মতামত এবং পরামর্শ',
                  style: TextStyle(fontSize: screenHeight * 0.018)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedbackPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.deepOrange),
              title: Text('যোগাযোগ করুন',
                  style: TextStyle(fontSize: screenHeight * 0.018)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactPage()));
              },
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: Column(
                children: [
                  Text(
                    'এই প্রকল্পের উন্নয়নে সহায়তা করুন',
                    style: TextStyle(
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ElevatedButton(
                    onPressed: () async {
                      UpiPayment upiPayment = UpiPayment();
                      UpiResponse response = await upiPayment.initiatePayment();
                      _checkTxnStatus(response.status ?? 'Unknown');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.02),
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_circle_rounded,
                          size: screenHeight * 0.03,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'UPI দ্বারা Donate করুন',
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex.value,
        onTap: (index) {
          setState(() {
            _bottomNavIndex.value = index;
          });
        },
        selectedItemColor:  Colors.black,
        unselectedItemColor: Colors.deepOrange, 
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.summarize_sharp,
              size: 30,
            ),
            label: 'সারাংশ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              size: 30,
            ),
            label: 'অধ্যায়',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.find_in_page,
              size: 30,
            ),
            label: 'শ্লোক',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              size: 30,
            ),
            label: 'বাসুদেব',
          ),
        ],
      ),
      body: _bottomNavPages[_bottomNavIndex.value],
    );
  }
}
