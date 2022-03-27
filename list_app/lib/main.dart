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

  UserEntry _userentry = UserEntry(entry: "");
  List<UserEntry> _userentries = [];

  final _formKey = GlobalKey<FormState>();
  //final userInputData = GlobalKey<ScaffoldState>();

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
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  // counterText: '0 characters',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _userentry.entry = value!),
                //onSaved: (value) => userInput = value!,
              ),
              ElevatedButton(
                onPressed: _validInput,
                child: const Text("Submit"),
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
                      }))
            ],
          ),
        ),
      ),
    );
  }

  _validInput() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted Successfully')),
      );
      _formKey.currentState!.save();
      _userentries.add(UserEntry(entry: _userentry.entry));
      _formKey.currentState!.reset();
    }
  }
}

class UserEntry {
  UserEntry({required this.entry});

  String entry;
}
