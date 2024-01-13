import 'package:flutter/material.dart';

class QuestionAnswer extends StatefulWidget {
  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  List<QAItem> qaList = [];
  TextEditingController questionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q&A Smart Travel Planner'),
        actions: [],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/travel-bg10.jpg'), fit: BoxFit.cover),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: qaList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          qaList[index].question,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(qaList[index].answer),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: 'Ask a question',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        _addQuestion();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addQuestion() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        qaList.add(QAItem(
          question: questionController.text,
          answer: 'Smart answer will be here...',
        ));
        questionController.clear();
      });
    }
  }
}

class QAItem {
  final String question;
  final String answer;

  QAItem({required this.question, required this.answer});
}
