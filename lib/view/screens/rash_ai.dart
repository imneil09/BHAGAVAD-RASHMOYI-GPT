import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';

class RashAi extends StatefulWidget {
  const RashAi({super.key, required this.apiKey});

  final String apiKey;

  @override
  State<RashAi> createState() => _RashAiState();
}

class _RashAiState extends State<RashAi> {
  late GoogleGemini gemini;
  bool loading = false;
  List<Map<String, String>> chatMessages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    gemini = GoogleGemini(apiKey: widget.apiKey);
  }

  void handleMessageSubmit(String query) {
    if (query.isEmpty) return;

    setState(() {
      loading = true;
      chatMessages.add({"role": "উপাসক", "text": query});
      _textController.clear();
    });

    scrollToTheEnd();

    gemini.generateFromText("${query}GENERATE THE RESPONSE IN THE CONTEXT OF BHAGAVAD GITA AND GENERATE RESPONSE IN BANGLA TEXT").then((value) {
      setState(() {
        loading = false;
        chatMessages.add({"role": "বাসুদেব", "text": value.text});
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        chatMessages.add({"role": "বাসুদেব", "text":" INTERNAL SERVER ERROR, PLEASE TRY AGAIN !"});
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: chatMessages.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(chatMessages[index]["role"]!.substring(0, 1)),
                    ),
                    title: Text(chatMessages[index]["role"]!),
                    subtitle: Text(chatMessages[index]["text"]!),
                  );
                },
              ),
            ),
            if (loading) const CircularProgressIndicator(),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "আপনার প্রশ্ন লিখুন",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.transparent,
                      ),
                      onSubmitted: handleMessageSubmit,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded,color: Colors.deepOrange,),
                    onPressed: () => handleMessageSubmit(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
