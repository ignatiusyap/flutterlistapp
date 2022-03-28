import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InputForm(title: 'Flutter Assignment'),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  InputFormState createState() => InputFormState();
}

class InputFormState extends State<InputForm> {
  late String userInput;
  //final _entries = <Entries>[];
  //final List<Entries> _entries = [];
  //final List<String> _entries = [];

  final UserEntry _userentry = UserEntry(entry: "");
  final List<UserEntry> _userentries = [];
  int _charLength = 0;
  //bool _enableBtn = false;
  final _formKey = GlobalKey<FormState>();
  //final userInputData = GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: userInputData,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: textController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: 'Enter text',
                    counterText: '$_charLength characters',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //_enableBtn = false;
                      return 'Please enter some text';
                    }
                    if (_charLength <= 99) {
                      //_enableBtn = false;
                      return 'Please type at least a 100 characters text';
                    }
                    // else if (_charLength > -100) {
                    //   setState(() => _enableBtn = true);
                    // }
                    return null;
                  },
                  onSaved: (value) => setState(() => _userentry.entry = value!),
                  onChanged: _onChanged
                  //onSaved: (value) => userInput = value!,
                  ),
              ElevatedButton(
                //onPressed: _enableBtn ? _validInput : null,
                onPressed: _validInput,
                child: const Text("Add text"),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _userentries.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(_userentries[index].entry)),
                      const Divider(),
                    ],
                  );
                },
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                //reverse: true
              )),
              //FloatingActionButtonLocation.endDocked),
              FloatingActionButton(
                onPressed: _scrollUp,
                child: const Icon(Icons.arrow_upward),
              ),
              FloatingActionButton(
                onPressed: _scrollDown,
                child: const Icon(Icons.arrow_downward),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validInput() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submitted Successfully'),
          duration: Duration(milliseconds: 500),
        ),
      );
      _formKey.currentState!.save();
      _userentries.add(UserEntry(entry: _userentry.entry));
      //_enableBtn = false;
      _formKey.currentState!.reset();
    }
  }

  _onChanged(String value) {
    setState(() {
      _charLength = value.length;
    });
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class UserEntry {
  UserEntry({required this.entry});

  String entry;
}
