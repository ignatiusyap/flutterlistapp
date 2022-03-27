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
  late String _userInput;
  final _formKey = GlobalKey<FormState>();
  //final userInputData = GlobalKey<>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  hintText: 'Enter text',
                  // counterText: '0 characters',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _userInput = value!,
              ),
              ElevatedButton(
                onPressed: _validInput,
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }

  _validInput() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted Successfully')),
      );
      _formKey.currentState!.save();
    }
  }
}
