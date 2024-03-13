import 'package:flutter/material.dart';
import 'package:notelist/presentation/provider/note_provider.dart';
import 'package:provider/provider.dart';

// class NoteAddScreen extends StatelessWidget {
//   const NoteAddScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NoteEdit',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const NoteAddScreenPage(),
//     );
//   }
// }

// class NoteAddScreenPage extends StatefulWidget {
//   const NoteAddScreenPage({super.key});

//   @override
//   State<NoteAddScreenPage> createState() => _NoteAddScreenPageState();
// }

// ignore: must_be_immutable
class NoteAddScreen extends StatelessWidget {
  late String title;
  String text = "";

  NoteAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    maxLines: null, // Allow unlimited lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      //   borderSide: BorderSide.none,
                      // ),
                      hintText: 'Заголовок...',
                    ),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    minLines: 5,
                    maxLines: 15, // Allow unlimited lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Текст...',
                    ),
                    onChanged: (value) {
                      text = value;
                    },
                  ),
                ],
              ),
            ),
            //const SizedBox(height: 16.0),
            Consumer<NoteProviderChange>(
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    value.add(title, text);
                    Navigator.pop(context);
                  },
                  child: const Text('Записать'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
